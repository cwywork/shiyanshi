<?php
namespace App\Http\Controllers;
use Validator;
use Excel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class Area extends Controller
{

    protected $request;
    
    private $enable_action = [];


    public function __construct(Request $request)
    {
        //$action_string = $request->route()->getActionName();
        //$this->verify($action_string);
    }

    public function getAreas (Request $request)
    {
        $rules      = [
            'area_id'   => 'required|numeric',
            'deep'      => 'required|min:0|max:5'
        ];

        $messages   = [
            'required'  => 'ERR_PARAM_:attribute_REQUIRED',
            'min'       => 'ERR_PARAM_:attribute_INVALID',
            'max'       => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'area_id'   => 'AREAID',
            'deep'      => 'DEEP'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }

        $param = (object)$request->only('area_id', 'deep');
        $find = DB::select('SELECT `oid`,level FROM areas WHERE id =?', [$param->area_id]);
        if(!$find) return response()->json(['code' => 'ERR_AREA_NOT_EXISTS'], 400);
        $idSkip     = $find[0]->oid;
        $tmp        = substr($idSkip, 0, 2*$find[0]->level-1);
        $idLimit    = str_pad($tmp, 9, 9,STR_PAD_RIGHT);
        $param->deep  = $param->deep + $find[0]->level;
        //获取行政地区列表
        $sql = "SELECT id, `oid`, name, level FROM areas WHERE `oid` between ".$idSkip." AND ".$idLimit." and level = ".$param->deep;
        $data  = DB::select($sql);
        return response()->json($data, 200);
    }

    public function getOne(Request $request, int $id)
    {
        $find = DB::select('SELECT * FROM areas WHERE id =?', [$id]);
        if(!$find) return response()->json(['code' => 'ERR_AREA_NOT_EXISTS'], 400);
        return response()->json($find[0], 200);
    }

    public function getAreaParents (Request $request)
    {
        $param = (object)$request->only('area_id');
        $find = DB::select('SELECT `oid`,level FROM areas WHERE id =?', [$param->area_id]);
        if(!$find) return response()->json([], 200);
        $where = '';
        for ($i = 1; $i <= 9; $i++) {
            $j = $i;
            if($j % 2 == 1){
                $h = 9 - $i;
                $tmp    = substr($find[0]->oid, 0, $i);
                $tmp    = str_pad($tmp, 9, 0,STR_PAD_RIGHT);
                $where  .= empty($where) ? 'oid='.$tmp : ' or oid='.$tmp;
            }
        }
        $data = DB::select('SELECT * FROM areas where '.$where);
        return response()->json($data, 200);
    }

    public function getPhases(Request $request)
    {
        $data = DB::select('SELECT * FROM edu_phases');
        return response()->json($data, 200);
    }

    //================================================================前端数据统计接口 =====================================================================
    /**
     * 按地区统计贫困户/人口比重分布情况
     */
    public function getMemeberByArea(Request $request, int $area_id)
    {
        // 获取子地区编码
        $areas = $this->getNextLevel($area_id, ' * ');
        if(!isset($areas[0]))       return response()->json([], 200);
        $sql = '';
        foreach ($areas as $key => $val) {
            $limit = $this->getAreasRangeByOid($val->oid,$val->level);
            $sql .= empty($sql) ? ' ' : ' union all ';
            $sql .= "select count(1) `family`, sum(members) `value`, {$val->id} area_id, '{$val->name}' `name` from families f 
                        left join areas a on f.area_id = a.id 
                    where a.oid BETWEEN {$limit->_skip} and {$limit->_limit}";
        }
        $data  = DB::select($sql);
        $total = 0;
        $max   = 0;
        foreach ($data as $key => $val) {
            $max = $val->value > $max ? $val->value : $max;
            $total += $val->value; 
        }
        $data = ['total'=>$total, 'max'=>$max, 'data'=>$data];
        
        return response()->json($data, 200);
    }


    /**
     * 按地区统计贫困原因 贫困户/人口/学生人数比重分布情况
     */
    public function getMemeberByPoorStatus(Request $request, int $area_id)
    {
        // 获取子地区编码
        $area   = DB::select('SELECT `oid`,`level` FROM areas where id = ?', [$area_id]);
        if(empty($area))  response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $sql = '';
        $phase  = (object)[
                    ['id'=>1,   'name'=>'未脱贫'],
                    ['id'=>2,   'name'=>'预脱贫'],
                    ['id'=>3,   'name'=>'脱贫'],
                    ['id'=>4,   'name'=>'返贫']
                ];
        $phase  = json_decode(json_encode($phase));
        
        foreach ($phase as $key => $val) {

            $sql .= empty($sql) ? ' ' : ' union all ';
            $sql .= "
            select mf.tt_students `tstudents`, sf.familys `family`, sf.values value,sf.poor_statuss poor_status, sf.names `name`  from
                (select count(1) `familys`, sum(members) `values`, {$val->id} poor_statuss, '{$val->name}' `names` ,{$area_id} `area_id` from families f 
                        left join areas a on f.area_id = a.id 
                        
                    where a.oid BETWEEN {$limit->_skip} and {$limit->_limit} and f.poor_status={$val->id})sf
                left join
                (select count(1) tt_students ,{$area_id} `area_id` from members m 
                        left join families f on m.family_id=f.id
                        left join areas a on f.area_id = a.id 
                    where a.oid BETWEEN {$limit->_skip} and {$limit->_limit} and f.poor_status={$val->id} and edu_status=1)mf     
                on sf.area_id=mf.area_id
                    ";
        }
        // return $sql;
        $data  = DB::select($sql);
        $total = 0;
        $max   = 0;
        foreach ($data as $key => $val) {
            $max = $val->value > $max ? $val->value : $max;
            $total += $val->value; 
        }
        $data = ['total'=>$total, 'max'=>$max, 'data'=>$data];
        
        return response()->json($data, 200);
    }

    /**
     * 按地区统计贫困户/人口/学生比重分布情况
     */
    public function getStudentsByArea(Request $request, int $area_id)
    {
        // 获取子地区编码
        $areas = $this->getNextLevel($area_id, ' * ');
        if(!isset($areas[0]))       return response()->json([], 200);
        $sql = '';
        foreach ($areas as $key => $val) {

            $limit = $this->getAreasRangeByOid($val->oid,$val->level);
            $sql .= empty($sql) ? ' ' : ' union all ';
            $sql .= "select f.families, f.members, s.students, a.id area_id, a.name from areas a 
                        left join (
                            select count(1) families, sum(members) members,{$val->id} aid from families f 
                                    left join areas a on f.area_id = a.id 
                            where a.oid BETWEEN {$limit->_skip} and {$limit->_limit}
                        )f on f.aid = a.id
                        left join (
                            select count(1) students, {$val->id} aid from edu_records r
                                    left join areas a       on r.area_id = a.id
                            where year=".date('Y')." and a.oid BETWEEN {$limit->_skip} and {$limit->_limit} and r.phase_id > 0 and r.status <> 5
                        )s on s.aid = a.id
                    where a.id = {$val->id}";
        }
        $data  = DB::select($sql);
        $total = 0;
        $max   = 0;
        foreach ($data as $key => $val) {
            $max = $val->students > $max ? $val->students : $max;
            $total += $val->students; 
        }
        $data = ['total'=>$total, 'max'=>$max, 'data'=>$data];
        return response()->json($data, 200);
    }

    /**
     * 按地区统计教育扶贫资金投入情况
     */
    public function getFundsByArea(Request $request, int $area_id)
    {

        // 获取子地区编码
        $areas = $this->getNextLevel($area_id, ' * ');

        if(!isset($areas[0])) return response()->json([], 200);
        $sql = '';
        foreach ($areas as $key => $val) {
            $limit = $this->getAreasRangeByOid($val->oid,$val->level);
            $sql  .= empty($sql) ? ' ' : ' union all ';
            $sql  .= "select count(1) people, sum(p.funds) `value`, {$val->id} area_id, '{$val->name}' name from edu_records_policies rp 
                        left join epa_policies p on rp.epa_policy_id = p.id
                        
                        left join edu_records er on rp.edu_record_id=er.id
                        
                        left join areas a          on rp.area_id = a.id
                    where a.oid BETWEEN {$limit->_skip} and {$limit->_limit}";
        }
//        return $sql;
        $data = DB::select($sql);
        $total = 0;
        $max   = 0;
        foreach ($data as $key => $val) {
            $total += $val->value;
            $val->value = ceil($val->value/10000);
            $max = $val->value > $max ? $val->value : $max;
            $data[$key]->value = $val->value;
        }
        $data = ['total'=>ceil($total/10000), 'max'=>$max, 'data'=>$data];
        return response()->json($data, 200);
    }
    /**
     * 按地区获取不同教育阶段经费情况
     */

    public function getEduFundsByArea(Request $request, int $area_id){

        $sql='select id ,name from edu_phases where parent_id=0 and id != 46 limit 2,20';
        $edu= DB::select($sql);
//        return $edu;
        // 获取子地区编码
        $sql='select * from areas where id='.$area_id;
        $area=DB::select($sql);
        foreach ($area as $key=>$val){
            $limit = $this->getAreasRangeByOid($val->oid,$val->level);
        }
        $sql='';
        foreach ($edu as $key=>$val){
            $sql  .= empty($sql) ? ' ' : ' union all ';
            $sql  .= "select count(distinct(er.member_id)) people, sum(p.funds) `value`, {$val->id} edu_id,  '{$val->name}' name from edu_records_policies rp
                        left join epa_policies p on rp.epa_policy_id = p.id
                        left join edu_records er on rp.edu_record_id=er.id
                        inner join areas a on   er.area_id=a.id
                        where er.phase_id={$val->id} and a.oid BETWEEN {$limit->_skip} and {$limit->_limit}"
                        ;
        }
//        return $sql;
        $data = DB::select($sql);
        $total = 0;
        $max   = 0;
        foreach ($data as $key => $val) {
            $total += $val->value;
            $val->value = ceil($val->value/10000);

            $max = $val->value > $max ? $val->value : $max;
            $data[$key]->value = $val->value;
        }
        $data = ['total'=>ceil($total/10000), 'max'=>$max, 'data'=>$data];
        return response()->json($data, 200);
    }

    public function getAgeFundsByArea(Request $request, int $area_id){
        $age=array(
            0=>array(
                'id'=>1,
                'name'=>'4~6岁',
                'age_begin'=>4,
                'age_end'=>6
            ),
            1=>array(
                'id'=>2,
                'name'=>'7~12岁',
                'age_begin'=>7,
                'age_end'=>12
            ),
            2=>array(
                'id'=>3,
                'name'=>'13~15岁',
                'age_begin'=>13,
                'age_end'=>15
            ),
            3=>array(
                'id'=>4,
                'name'=>'16~18岁',
                'age_begin'=>16,
                'age_end'=>18
            ),
            4=>array(
                'id'=>5,
                'name'=>'19岁及以上',
                'age_begin'=>19,
                'age_end'=>1000
            )
        );

        $sql='select * from areas where id='.$area_id;
        $area=DB::select($sql);
        foreach ($area as $key=>$val){
            $limit = $this->getAreasRangeByOid($val->oid,$val->level);
        }

        $sql='';

         
        foreach ($age as $key=>$val){
            $age_begin=ceil(time()/86400 - 365*($val['age_begin']-1));
            $age_end=ceil(time()/86400 - 365*$val['age_end']);

            $sql  .= empty($sql) ? ' ' : ' union all ';
            $sql  .= "select count(distinct(m.id)) people, sum(p.funds) `value`, {$val['id']} age_id,  \"{$val['name']}\" name from edu_records_policies rp
                        left join epa_policies p on rp.epa_policy_id = p.id
                        left join edu_records er on rp.edu_record_id=er.id
                        left join members m on m.edu_records_id=er.id
                        left join areas a on   er.area_id=a.id
                        where m.birthday>={$age_end} and m.birthday<{$age_begin} and a.oid BETWEEN {$limit->_skip} and {$limit->_limit}
                        " ;
//             return $sql;
        }   

        $data = DB::select($sql);

        $total = 0;
        $max   = 0;
        foreach ($data as $key => $val) {
            $total += $val->value;
            $val->value = ceil($val->value/10000);
            $max = $val->value > $max ? $val->value : $max;
            $data[$key]->value = $val->value;
        }
        $data = ['total'=>ceil($total/10000), 'max'=>$max, 'data'=>$data];
        return response()->json($data, 200);
    }

    public  function getStudentstest(Request $request){
        return 1;
    }

    /**
     * 按地区统计贫困户致贫原因情况
     */
    public function getFamiliesByReason(Request $request, int $area_id)
    {
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $find   = DB::select('SELECT * FROM poor_causes');
//        return $find;
        $sql    = '';
        foreach ($find as $key => $val) {
            $sql .= empty($sql) ? ' ' : ' union all ';
            $sql .= "select count(1) total_families, sum(members) total_members, '{$val->title}' reason from families f 
                        left join poor_causes p    on f.poor_causes_id = p.id
                        left join areas a           on f.area_id        = a.id  
                    where p.id = {$val->id} and a.oid BETWEEN {$limit->_skip} and {$limit->_limit}";
        }
//        return $sql;
        $data = DB::select($sql);
        $sum = 0;
        $max = 0;
        $newArray = [];
        foreach ($data as $key => $val) {
            $max = $val->total_members > $max ? $val->total_members : $max;
            $sum += $val->total_members;
            $newArray['data'][$val->reason] = $val->total_members;
        }
        $newArray['max']=$max;
        $newArray['sum']=$sum;
        return response()->json($newArray, 200);
    }

    /**
     * 按地区统计 致贫 学生人数
     */

    public function getStudentByReason(Request $request, int $area_id){
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $find   = DB::select('SELECT * FROM poor_causes');
//        return $find;
        $sql    = '';
        foreach ($find as $key => $val) {
            $sql .= empty($sql) ? ' ' : ' union all ';
            // $sql .= "select count(1) total_families, sum(members) total_members, '{$val->title}' reason from families f 
            //             left join members  m on m.family_id=f.id
            //             left join poor_causes p    on f.poor_causes_id = p.id
            //             left join areas a           on f.area_id        = a.id  
            //         where m.edu_status=1 and p.id = {$val->id} and a.oid BETWEEN {$limit->_skip} and {$limit->_limit}";
            $sql .= "
                select mf.tt_students `tstudents`, sf.values total_members ,sf.familys `family`, sf.values value,sf.poor_statuss poor_status, sf.names `title`  from
                (select count(1) `familys`, sum(members) `values`, {$val->id} poor_statuss, '{$val->title}' `names` ,{$area_id} `area_id` from families f 
                        left join poor_causes p    on f.poor_causes_id = p.id
                        left join areas a on f.area_id = a.id 
                    ";
                    if($val->id == 12){
                        $sql .=" where a.oid BETWEEN {$limit->_skip} and {$limit->_limit} and f.poor_causes_id = 0)sf ";
                    }else{
                        $sql .=" where a.oid BETWEEN {$limit->_skip} and {$limit->_limit} and p.id = {$val->id})sf ";
                    }
                    $sql .="
                left join
                (select count(1) tt_students ,{$area_id} `area_id` from members m 
                        left join families f on m.family_id=f.id
                        left join poor_causes p    on f.poor_causes_id = p.id
                        left join areas a on f.area_id = a.id ";
                        if($val->id == 12){
                            $sql .=" where a.oid BETWEEN {$limit->_skip} and {$limit->_limit} and f.poor_causes_id = 0 and edu_status=1)mf ";
                        }else{
                            $sql .=" where a.oid BETWEEN {$limit->_skip} and {$limit->_limit} and p.id = {$val->id} and edu_status=1)mf ";
                        }
                        $sql .="
                on sf.area_id=mf.area_id
                    ";
        }
//        return $sql;
        $data  = DB::select($sql);
        $total = 0;
        $max   = 0;
        foreach ($data as $key => $val) {
            $max = $val->value > $max ? $val->value : $max;
            $total += $val->value; 
        }
        $data = ['total'=>$total, 'max'=>$max, 'data'=>$data];

        return response()->json($data, 200);
    }

    /**
     * 辍学原因统计
     */
    public function getFamiliesByQuitReason(Request $request, int $area_id)
    {
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $find   = DB::select('SELECT id,title FROM dropout_causes');
//        return $find;
        $sql    = '';
        foreach ($find as $key => $val) {
            $sql .= empty($sql) ? ' ' : ' union all ';
            $sql .= "select count(1) total_members, '{$val->title}' reason from dropout_causes d
                        left join members m
                        on m.neisa_causes_id=d.id
                        left join areas a           on m.area_id        = a.id  
                    where has_neisa=1 and d.id = {$val->id} and a.oid BETWEEN {$limit->_skip} and {$limit->_limit}";
        }
//        return $sql;
        $data = DB::select($sql);
        $sum = 0;
        $max = 0;
        $newArray = [];
        foreach ($data as $key => $val) {
            $max = $val->total_members > $max ? $val->total_members : $max;
            $sum += $val->total_members;
            $newArray['data'][$val->reason] = $val->total_members;
        }
        $newArray['max']=$max;
        $newArray['sum']=$sum;
        return response()->json($newArray, 200);
    }


    /**
     * 按工种类型统计职业培训人次
     */
    public function getMembersByMajor(Request $request, int $area_id)
    {
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $sql = "SELECT count(1) jcount, p.parent_id, p.`name` mojors from edu_ves r
                    left join members m    on r.member_id = m.id
                    left join edu_majors p on r.edu_major_id = p.id
                    left join areas    a   on m.area_id = a.id
                where a.oid BETWEEN {$limit->_skip} and {$limit->_limit} group by r.edu_major_id";
        $data  = DB::select($sql);
        $pdata = DB::select('SELECT id,name from edu_majors where parent_id=0');
        $sum   = 0;
        $max   = 0;
        $newArray = [];
        foreach ($pdata as $k => $v) {
            $tmp = 0;
            foreach ($data as $key => $val) {
                if($v->id == $val->parent_id){
                    $tmp += $val->jcount;
                    $sum += $val->jcount;
                    // $tmp += $val->jcount;
                }
            }
            $max  = $tmp > $max ? $tmp : $max;
            $newArray['data'][$v->name] = $tmp;
        }
        $newArray['max']=$max;
        $newArray['sum']=$sum;
        return response()->json($newArray, 200);
    }

    /**
     * 按工种类型统计职业培训人次 too10
     */
    public function getMembersByMajorTop(Request $request, int $area_id)
    {
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $sql = "SELECT count(1) jcount, p.parent_id, p.`name` mojors from edu_ves r
                    left join members m    on r.member_id = m.id
                    left join edu_majors p on r.edu_major_id = p.id
                    left join areas    a   on m.area_id = a.id
                where a.oid BETWEEN {$limit->_skip} and {$limit->_limit} group by r.edu_major_id order by jcount desc limit 10";
        $data = DB::select($sql);
        $sum  = 0;
        $max  = 0;
        $newArray = [];
        foreach ($data as $key => $val) {
            $max = $val->jcount > $max ? $val->jcount : $max;
            $sum += $val->jcount;
            $newArray['data'][$val->mojors] = $val->jcount;
        }
        $newArray['max']=$max;
        $newArray['sum']=$sum;
        return response()->json($newArray, 200);
    }

    /**
     * 按学籍阶段统计某一地区
     */
    public function getMembersByPhase(Request $request, int $area_id)
    {
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $sql = "SELECT count(1) jcount, grade, p.`name`, p.parent_id from edu_records r
                    left join edu_phases p on r.grade      = p.id
                    left  join areas      a on r.area_id    = a.id
                where a.oid BETWEEN {$limit->_skip} and {$limit->_limit} group by r.grade";
        $data = DB::select($sql);
        $sum  = 0;
        $max  = 0;
        $newArray = [];
        $phase    = [['id'=>3,   'name'=>'学前教育'],
                    ['id'=>4,   'name'=>'小学'],
                    ['id'=>5,   'name'=>'初中'],
                    ['id'=>6,   'name'=>'高中|中职'],
                    ['id'=>7,   'name'=>'大学专科|高职'],
                    ['id'=>8,   'name'=>'大学本科'],
                    ['id'=>9,   'name'=>'硕士研究生'],
                    ['id'=>10,  'name'=>'博士研究生']];
        foreach ($phase as $k => $v) {
            $tmp = 0;
            foreach ($data as $key => $val) {
                if($v['id'] == $val->parent_id){
                    $tmp += $val->jcount;
                    $sum += $val->jcount;
                    $tmp += $val->jcount;
                }
            }
            $max  = $tmp > $max ? $tmp : $max;
            $newArray['data'][$v['name']] = $tmp;
        }
        $newArray['max'] = $max;
        $newArray['sum'] = $sum;
        return response()->json($newArray, 200);
    }

    /**
     * 按年级统计某一地区
     */
    public function getStudentsByGrade(Request $request, int $area_id)
    {
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $sql = "SELECT count(1) jcount, grade, p.`name`, p.parent_id from edu_records r
                    left join edu_phases p on r.grade      = p.id
                    left  join areas      a on r.area_id    = a.id
                where a.oid BETWEEN {$limit->_skip} and {$limit->_limit} and p.id between 12 and 26 group by r.grade";
        $data = DB::select($sql);
        $sum  = 0;
        $max  = 0;
        $newArray = [];
        foreach ($data as $key => $val) {
            $max = $val->jcount > $max ? $val->jcount : $max;
            $sum += $val->jcount;
            $newArray['data'][$val->name] = $val->jcount;
        }
        $newArray['max'] = $max;
        $newArray['sum'] = $sum;
        return response()->json($newArray, 200);
    }

    /**
     * 按辍学原因分布
     */
    public function getDropoutByreason(Request $request, int $area_id)
    {
        $year = date('Y');
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $sql = "select count(1) jcount, r.dropout_causes_id id from edu_records r 
                    left join areas a on r.area_id = a.id
                where `year`={$year} and r.status = 5 and a.oid BETWEEN {$limit->_skip} and {$limit->_limit} group by dropout_causes_id";
        $data = DB::select($sql);
        $find = DB::select('SELECT id, title from dropout_causes');
        $sum  = 0;
        $max  = 0;
        $newArray = [];
        foreach ($find as $key => $val) {
            $tmp = 0;
            foreach ($data as $k => $v) {
                if($val->id == $v->id) {
                    $tmp += $v->jcount;
                }
            }
            $max    = $tmp > $max ? $tmp : $max;
            $sum   += $tmp;
            $newArray['data'][$val->title] = $tmp;
        }
        $newArray['max'] = $max;
        $newArray['sum'] = $sum;
        return response()->json($newArray, 200);
    }

    /**
     * 按地区辍学率和返校率
     */
    public function getDropoutByYear(Request $request, int $area_id)
    {
        // 获取子地区编码
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $sql = '';
        for($year = 2016; $year <= date('Y'); $year ++){
            $sql .= empty($sql) ? '' : ' union all ';
            $sql .= "select d.std_dropouts, c.std_callback, b.std_tatol, {$year} `year` from 
                        (select count(1) std_dropouts,{$area_id} area_id from edu_records r 
                            left join areas a on r.area_id = a.id where `status`=5 and r.`year`={$year} and a.oid BETWEEN {$limit->_skip} and {$limit->_limit}) d 
                    left join 
                        (select count(1) std_callback,{$area_id} area_id from edu_records r 
                            left join areas a on r.area_id = a.id where `status`=6 and r.`year`={$year} and a.oid BETWEEN {$limit->_skip} and {$limit->_limit}) c on d.area_id = c.area_id
                    left join 
                        (select count(1) std_tatol,{$area_id} area_id from edu_records r 
                            left join areas a on r.area_id = a.id where (`status`<>6 or `status`<>5) and r.`year`={$year} and a.oid BETWEEN {$limit->_skip} and {$limit->_limit}) b on b.area_id = d.area_id";
        }
        $data = DB::select($sql);
        $year = [];
        $std  = [];
        $drop = [];
        $back = [];
        foreach ($data as $k => $v) {
            $year[] = $v->year;
            $std[]  = $v->std_tatol;
            $drop[] = $v->std_dropouts;
            $back[] = $v->std_callback;
        }
        $data = ['year'=>$year, 'students'=>$std, 'dropout'=>$drop, 'callback'=>$back];
        return response()->json($data, 200);
    }


    /**
     * 按年龄段统计人口分布情况
     */
    public function getByAgesFamilies(Request $request, int $area_id)
    {
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $sql = "SELECT count(1) jcount,grade, p.`name` from edu_records r
                    left join edu_phases p on r.grade = p.id
                    left join areas       a on r.area_id = a.id
                where a.oid BETWEEN {$limit->_skip} and {$limit->_limit} group by r.grade";
        $data = DB::select($sql);
        return response()->json($data, 200);
    }

    /**
     * 按年龄段统计人口分布情况 婴儿：1-3岁，青少年：3-18岁，19-25岁，26-59岁，60岁以上
     */
    public function getMembersByAge(Request $request, int $area_id)
    {
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $age    = [3,18,25,60,-1];
        $end_year = intval(strtotime(date('Y').'-01-01')/86400);
        $sql = '';
        $skip = 0;
        foreach ($age as $key => $val) {
            $begin_year = intval((time() - 365 * 86400 * $val)/86400);
            $sql .= empty($sql) ? '' : ' union all ';
            if($val == -1) {
                $sql .= "select count(1) tatol_members, '{$skip}以上' age  from members m 
                            left join areas a on m.area_id = a.id 
                         where m.birthday < {$end_year} and a.oid between {$limit->_skip} and {$limit->_limit}";
            } else {
                $sql .= "select count(1) tatol_members, '{$skip}-{$val}岁' age  from members m
                            left join areas a on m.area_id = a.id 
                         where birthday < {$end_year} and birthday > {$begin_year} and a.oid between {$limit->_skip} and {$limit->_limit}";
            }
            $skip       = $val;
            $end_year   = $begin_year;
        }
        $data = DB::select($sql);
        $sum  = 0;
        $max  = 0;
        $newArray = [];
        foreach ($data as $key => $val) {
            $max = $val->tatol_members > $max ? $val->tatol_members : $max;
            $sum += $val->tatol_members;
            $newArray['data'][$val->age] = $val->tatol_members;
        }
        $newArray['max'] = $max;
        $newArray['sum'] = $sum;
        return response()->json($newArray, 200);
    }

    /**
     * 按年龄段统计符合上学学生和辍学学生 学前：4-6岁，小学：7-12岁，13-15岁，16-18岁，19岁大专以上
     */
    public function getStudentsByAge(Request $request, int $area_id)
    {
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $age    =  [['id' => 6,'name'=>'4-6学前教育'],
                    ['id' => 12,'name'=>'7-12小学阶段'],
                    ['id' => 15,'name'=>'13-15初中阶段'],
                    ['id' => 18,'name'=>'16-18高中阶段'],
                    ['id' => -1,'name'=>'19岁以上']];
        $byear = date('Y')-4;
        $end_year = intval(strtotime($byear.'-'.date('m-d'))/86400);            
        $sql = '';
        $skip = 4;
        $year = date('Y');
        foreach ($age as $key => $val) {
            $byear = date('Y')-$val['id'];
            $begin_year = intval(strtotime($byear.'-'.date('m-d'))/86400);
            $sql .= empty($sql) ? '' : ' union all ';
            if($val['id'] == -1) {
                $sql .= "select mm.tatol_members, rr.total_students, mm.age, mm.`year` from (
                            select count(1) tatol_members, '".$val['name']."' age, {$year} `year` from members m 
                                left join areas a on m.area_id = a.id 
                            where birthday < {$end_year} and a.oid between {$limit->_skip} and {$limit->_limit} and m.year = {$year}
                        ) mm  left join (
                            select count(r.id) total_students, {$year} `year` from edu_records r 
                                left join members m on r.member_id = m.id
                                left join areas a   on m.area_id = a.id
                            where m.birthday < {$end_year} and a.oid between {$limit->_skip} and {$limit->_limit} and r.`year` = {$year}
                        ) rr on mm.`year` = rr.`year`";
            } else {
                $sql .= "select mm.tatol_members, rr.total_students, mm.age, mm.`year` from (
                            select count(1) tatol_members, '".$val['name']."' age, {$year} `year` from members m 
                                left join areas a on m.area_id = a.id 
                            where birthday < {$end_year} and birthday > {$begin_year} and a.oid between {$limit->_skip} and {$limit->_limit} and m.year = {$year}
                        ) mm  left join (
                            select count(r.id) total_students, {$year} `year` from edu_records r 
                                left join members m on r.member_id = m.id
                                left join areas a   on m.area_id = a.id
                            where m.birthday < {$end_year} and m.birthday > {$begin_year} and a.oid between {$limit->_skip} and {$limit->_limit} and r.`year` = {$year}
                        ) rr on mm.`year` = rr.`year`";    
            }
            $skip       = $val['id'];
            $end_year   = $begin_year;
        }
        $data = DB::select($sql);
        // return $data;
        $sum  = 0;
        $max  = 0;
        $newArray = [];
        foreach ($data as $key => $val) {
            $max = $val->total_students > $max ? $val->total_students : $max;
            $sum += $val->total_students;
            $newArray['data'][$val->age] = $val->total_students;
        }
        $newArray['max'] = $max;
        $newArray['sum'] = $sum;
        return response()->json($newArray, 200);
    }

    
    /**
     * 按年龄段统计符合上学学生和辍学学生 学前：4-6岁，小学：7-12岁，13-15岁，16-18岁，19岁大专以上
     */
    public function getStudentsDropByAge(Request $request, int $area_id)
    {
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $age    =  [['id' => 6,'name'=>'4-6岁','begin_age'=>4,'end_age'=>6],
                    ['id' => 12,'name'=>'7-12岁','begin_age'=>7,'end_age'=>12],
                    ['id' => 15,'name'=>'13-15岁','begin_age'=>13,'end_age'=>15],
                    ['id' => 18,'name'=>'16-18岁','begin_age'=>16,'end_age'=>18]];
              
        // $end_year = intval(strtotime($byear.'-'.date('m-d'))/86400);  
        $end_year=ceil(time()/86400 - 365*3);   
        $sql = '';
        $year = date('Y');
        
        foreach ($age as $key => $val) {
            $sql .= empty($sql) ? '' : ' union all ';
            // $begin_year = intval(strtotime($byear.'-'.date('m-d'))/86400);
            $begin_year = ceil(time()/86400 - 365*$val['id']);   
            $sql.="select '".$val['name']."'name,count(*) value, ".$val['begin_age']." begin_age,".$val['end_age']." end_age from members m
            left join areas a on m.area_id=a.id
            where m.birthday < {$end_year} and m.birthday > {$begin_year} and a.oid between {$limit->_skip} and {$limit->_limit} and m.`year` = {$year}
                           and m.edu_status=0
            ";
            // return $sql;
            $end_year   = $begin_year;  
        }
    //    return $sql;         
        $data = DB::select($sql);
        // return $data;
        $sum  = 0;
        $max  = 0;
        
        foreach ($data as $key => $val) {
            $max = $val->value > $max ? $val->value : $max;
            $sum += $val->value;
            $val->value="{$val->value}";
        }
        $data = ['total'=>$sum, 'max'=>$max, 'data'=>$data];
        return response()->json($data, 200);
    }
    /**
     * 按教育阶段划分学生人数
     */
    public function getStudentsByGradeNew(Request $request, int $area_id)
    {
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
            $phase  = (object)[['id'=>3,   'name'=>'学前教育'],
                        ['id'=>4,   'name'=>'小学'],
                        ['id'=>5,   'name'=>'初中'],
                        ['id'=>6,   'name'=>'高中'],
                        ['id'=>7,   'name'=>'大学专科'],
                        ['id'=>8,   'name'=>'大学本科'],
                        ['id'=>9,   'name'=>'硕士研究生'],
                        ['id'=>10,   'name'=>'博士研究生'],
                        ['id'=>11,   'name'=>'特殊教育'],
                        ['id'=>47,   'name'=>'中职'],
                        ['id'=>51,   'name'=>'高职']
                    ];     
        $phase  = json_decode(json_encode($phase));
        $year = date('Y');
        $sql = '';
        foreach ($phase as $key => $val) {
            
           
            $arr=array(7,8,9,10,11,51);
            if(!in_array($val->id,$arr)){
                $sql .= empty($sql) ? '' : ' union all ';
                $sql.="select ".$val->id." grade_id , '".$val->name."' name , count(1) value from members m
                left join (select * FROM edu_records rr where not exists(select 1 from edu_records where rr.member_id = member_id and rr.id<id))r
                on r.member_id=m.id
                left join areas a on m.area_id=a.id
                where r.phase_id={$val->id} and a.oid between {$limit->_skip} and {$limit->_limit} and m.`year` = {$year} and m.edu_status=1
                ";
            }
        }
        $sql .= empty($sql) ? '' : ' union all ';
        $sql.="select '100' grade_id,'大学及以上' name,count(1) value from members m
        left join (select * FROM edu_records rr where not exists(select 1 from edu_records where rr.member_id = member_id and rr.id<id))r
        on r.member_id=m.id
        left join areas a on m.area_id=a.id
        where r.phase_id in (7,8,9,10,11,51) and a.oid between {$limit->_skip} and {$limit->_limit} and m.`year` = {$year} and m.edu_status=1
        ";
        // return $sql;
        $data = DB::select($sql);
        $sum  = 0;
        $max  = 0;
        
        foreach ($data as $key => $val) {
            $max = $val->value > $max ? $val->value : $max;
            $sum += $val->value;
            $val->value="{$val->value}";
        }
        $data = ['total'=>$sum, 'max'=>$max, 'data'=>$data];
        return response()->json($data, 200);
    }

    /**
     * 按贫困户状态获取人口分布
     */
    public function getMembersByPoorStatus(Request $request, int $area_id)
    {
        $area   = DB::select('SELECT * FROM areas WHERE id=?', [$area_id]);
        if(!isset($area[0])) return response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $sql = "select count(1) total_families, sum(f.members) total_members, '未脱贫' `status` from families f
                        left join areas a on f.area_id = a.id 
                    where f.poor_status = 1 and a.oid between {$limit->_skip} and {$limit->_limit} union ALL
                    select count(1) total_families, sum(f.members) total_members, '预脱贫' `status` from families f
                        left join areas a on f.area_id = a.id 
                    where f.poor_status = 2 and a.oid between {$limit->_skip} and {$limit->_limit} union ALL
                    select count(1) total_families, sum(f.members) total_members, '脱贫' `status` from families f
                        left join areas a on f.area_id = a.id 
                    where f.poor_status = 3 and a.oid between {$limit->_skip} and {$limit->_limit} union ALL
                    select count(1) total_families, sum(f.members) total_members, '返贫' `status` from families f
                        left join areas a on f.area_id = a.id 
                    where f.poor_status = 4 and a.oid between {$limit->_skip} and {$limit->_limit}";
        $data = DB::select($sql);
        $sum  = 0;
        $max  = 0;
        $newArray = [];
        foreach ($data as $key => $val) {
            $max = $val->total_families > $max ? $val->total_families : $max;
            $sum += $val->total_families;
            $newArray['data'][$val->status] = $val->total_families;
        }
        $newArray['max'] = $max;
        $newArray['sum'] = $sum;
        return response()->json($newArray, 200);
    }   

    public function getNotices()
    {
        $data1 = DB::select("SELECT c.id, c.title, c.author, c.content, c.source, c.status, c.published_at, cc.name category_name FROM cms_contents c
                    LEFT JOIN cms_categorys cc ON c.category_id = cc.id 
                WHERE c.status = 2 and c.category_id =1 limit 6");
        $data2 = DB::select("SELECT c.id, c.title, c.author, c.content, c.source, c.status, c.published_at, cc.name category_name FROM cms_contents c
                    LEFT JOIN cms_categorys cc ON c.category_id = cc.id 
                WHERE c.status = 2 and c.category_id =2 limit 6");
        $data3 = DB::select("SELECT c.id, c.title, c.author, c.content, c.source, c.status, c.published_at, cc.name category_name FROM cms_contents c
                    LEFT JOIN cms_categorys cc ON c.category_id = cc.id 
                WHERE c.status = 2 and c.category_id =3 limit 6");
        return response()->json(['data1' => $data1, 'data2' => $data2, 'data3' => $data3], 200);
    }
/*大表哥的显示 */
    public function getStuentsGlobalByArea(int $area_id)
    {

        $year   = date('Y');
        $area   = DB::select('SELECT `oid`,`level` FROM areas where id = ?', [$area_id]);

        if(empty($area))  response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        
        $vlevel = $area[0]->level == 1 ? 3 : ($area[0]->level + 1);
        //$sql='select * from areas where oid BETWEEN '.$limit->_skip.' and '.$limit->_limit.' and `level` between '.$area[0]->level.' and '.$vlevel.' order by oid';
        
        $areas  = DB::select('select * from areas where oid BETWEEN ? and ? and `level` between '.$area[0]->level.' and '.$vlevel.' order by oid', [$limit->_skip, $limit->_limit]);
        // return $areas;
        if(empty($areas))  response()->json([], 200);
        $age    = [['id' => 6,'name'=>'4-6学前教育'],
                    ['id' => 12,'name'=>'7-12小学阶段'],
                    ['id' => 15,'name'=>'13-15初中阶段'],
                    ['id' => 18,'name'=>'16-18高中阶段']];
        $age    = json_decode(json_encode($age));
        $phase  = (object)[['id'=>3,   'name'=>'学前教育'],
                    ['id'=>4,   'name'=>'小学'],
                    ['id'=>5,   'name'=>'初中'],
                    ['id'=>6,   'name'=>'高中'],
                    ['id'=>7,   'name'=>'大学专科'],
                    ['id'=>8,   'name'=>'大学本科'],
                    ['id'=>9,   'name'=>'硕士研究生'],
                    ['id'=>10,   'name'=>'博士研究生'],
                    ['id'=>11,   'name'=>'特殊教育'],
                    ['id'=>47,   'name'=>'中职'],
                    ['id'=>51,   'name'=>'高职']
                ];

        $phase  = json_decode(json_encode($phase));
 
        $sql = '';
        foreach ($areas as $k => $v) {
            // return $v->id;
            $limit  = $this->getAreasRangeByOid($v->oid,$v->level);
            $byear = date('Y')-4;
           // $end_year = intval(strtotime($byear.'-'.date('m-d'))/86400);
            $end_year=ceil(time()/86400 - 365*3);
            $skip = 4;
            $sql .= empty($sql) ? '' : ' union all ';

            $sql .= "select {$v->id} area_id , '{$v->name}' area_name, '{$v->level}' area_level, 
                    (members_6 + members_12 + members_15 + members_18) sum_members, members_6,members_12, members_15, members_18,
                    (students_3 + students_4 + students_5 + students_6 + students_7 + students_8 + students_9 + students_10 + students_11 + students_47 + students_51) sum_students,students_3,students_4, students_5, students_6,students_47 students_7,
                    (students_7 + students_8 + students_9 + students_10 + students_11 + students_51) students_8,
                    (dropout_6 + dropout_12 + dropout_15 + dropout_18) sum_dropout, dropout_6,dropout_12, dropout_15, dropout_18
                    from areas a ";
            foreach ($age as $key => $val) {
                $byear = date('Y')-$val->id;
//                $begin_year = intval(strtotime($byear.'-'.date('m-d'))/86400);
                $begin_year=ceil(time()/86400 - 365*$val->id);
                $sql .= " left join (";
                $sql .= "select mm.members members_{$val->id}, rr.dropout dropout_{$val->id}, {$v->id} area_id from (
                            select count(1) members, {$year} `year` from members m 
                                left join areas a on m.area_id = a.id 
                            where birthday < {$end_year} and birthday > {$begin_year} and a.oid between {$limit->_skip} and {$limit->_limit} and m.year = {$year} and m.family_id != 0
                        ) mm  left join (
                            select count(2) dropout, {$year} `year` from members m
                                
                                left join areas a on m.area_id = a.id 
                            where m.birthday < {$end_year} and m.birthday > {$begin_year} and a.oid between {$limit->_skip} and {$limit->_limit} and m.`year` = {$year} and m.edu_status=0 and m.family_id != 0
                        ) rr on mm.`year` = rr.`year`";
                $sql .= ") m{$val->id} on a.id = m{$val->id}.area_id ";
            //    return $sql;
                $skip       = $val->id;
                $end_year   = $begin_year;
            }
                // return $phase;
                // $sql='';
            foreach ($phase as $key => $val) {
                $sql .= " left join (";
                $sql .= "
                        select count({$val->id}) students_{$val->id}, {$v->id} area_id from members m
                        left join areas a on m.area_id=a.id
                        left join (select * FROM edu_records rr where not exists(select 1 from edu_records where rr.member_id = member_id and rr.id<id))r
                        on r.member_id=m.id
                        where m.edu_status=1 and r.phase_id = ".$val->id." and a.oid between ".$limit->_skip." and  ".$limit->_limit;
                $sql .= ") s{$val->id} on a.id = s{$val->id}.area_id ";                    
            }
        // $sql .= ' where a.oid between '.$limit->_skip.' and  '.$limit->_limit.' and students_3 is not null';
        $sql .= ' where  students_3 is not null';
          
        //    $sql .= ' where a.id='.$v->id;
        }
    //    return $sql;     
        $data = DB::select($sql);
        $this->writeFile($data, $area_id);
        return $data;
    }
    public function eduPhasesPK(Request $request){
        return 1;
    }

    public function getGlobalByArea(Request $request, int $area_id)
    {

        $fname = 'db_'.date('ymd').'.txt';

        $data = $this->areaFile($fname, $area_id);
        // $data=1;//让其跑sql语句
        if(strlen($data) < 100)
            $data = $this->getStuentsGlobalByArea($area_id);
        else
            $data = json_decode($data, true);
        return response()->json($data, 200);
    }

    public function getGlobalExportByArea(Request $request, int $area_id)
    {
        $fname = 'db_'.date('ymd').'.txt';
        $data = $this->areaFile($fname, $area_id);
        if(strlen($data) < 100){
            $data = $this->getStuentsGlobalByArea($area_id);
        } 
        $data = json_decode($data, true);
        set_time_limit(0);
        ob_end_clean();  
        $name='students_global';  
        header('Cache-control: max-age=0');  
        header('Expires: '.gmdate('D, d M Y H:i:s', time() - 31536000).' GMT');  
        header('Content-Encoding: none');  
        header('Content-Disposition: attachment; filename='.$name.'.csv');  
        header('Content-Type: text/plain');   
        $title = ['地区','年龄段合计','年龄段4-6岁','年龄段7-12岁','年龄段13-15岁','年龄段16-18岁','学阶合计','学前','小学','初中','高中','大学以上','辍学合计','辍学4-6岁','辍学7-12岁','辍学13-15岁','辍学16-18岁'];
        foreach ($title as $key => $val) {
            $title[$key] = mb_convert_encoding($val, 'GB2312', 'UTF-8');
        }
        $handle = fopen("php://output", 'w');  
        fputcsv($handle, $title);
        $tmp = [];
        foreach ($data as $k => $v) {
            $v['area_name'] = mb_convert_encoding($v['area_name'], 'GB2312', 'UTF-8');
            unset($v['area_id']);
            unset($v['area_level']);
            fputcsv($handle, $v);
        } 

        fclose($handle);  
        $output=ob_get_clean();  
        @ob_end_clean(); 
        echo $output;  
        exit(0);
    }

    public function writeFile($data, $area_id)
    {
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'/files/areas/areas_'.$area_id;
        $file       = $dir.'/db_'.date('ymd').'.txt';
        if(!is_dir($dir)) $this->mkdirs($dir);
        $file = fopen($file, "w");
        $flog = fwrite( $file, json_encode($data));
        fclose($file);
        return $flog;
    }

    public function areaFile($fname, $area_id)
    {
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'/files/areas/areas_'.$area_id;

        $file       = $dir.'/'.$fname;
//        return $file;
        if(is_file($file)) {
            $hfile  = fopen($file, "r");
            $data   = fread($hfile, 100000);
            fclose($hfile);
            return $data;
        }
        return false;
    }

    public function getBasicSurveyByarea(Request $request, int $area_id)
    {
        $area   = DB::select('SELECT `oid`,`level` FROM areas where id = ?', [$area_id]);
        if(empty($area))  response()->json([], 200);
        $limit  = $this->getAreasRangeByOid($area[0]->oid,$area[0]->level);
        $year   = date('Y');    //年份参数
        $fyear   = $year -1;    //上一年参数
        //return $fyear;
        $fend_year   = ceil(time()/86400 - 365*intval(6));

        $fbegin_year = ceil(time()/86400 - 365*intval(15));

        // $fend_year   = intval(strtotime(($fyear-6).'-'.date('m').'-01')/86400);
        // $fbegin_year = intval(strtotime(($fyear-14).'-'.date('m').'-01')/86400);
        $sql = "select sum_families, sum_members, sum_funds, sum_students, sum_dropout_students, {$fyear} `year` from areas a 
                left join (
                    select count(1) sum_families, sum(members) sum_members, {$area_id} `area_id` from families f 
                        left join areas a  on f.area_id = a.id 
                    where  f.year = {$fyear} and a.oid BETWEEN {$limit->_skip} and {$limit->_limit})ff on ff.area_id = a.id 
                left join (    
                    select sum(p.funds) sum_funds, {$area_id} `area_id` from edu_records_policies rp 
                        left join epa_policies p on rp.epa_policy_id = p.id
                        left join edu_records r  on rp.edu_record_id = r.id
                        inner join areas a       on rp.area_id       = a.id
                    where r.year = {$fyear} and a.oid BETWEEN {$limit->_skip} and {$limit->_limit})fp on fp.area_id = a.id 
                left join (   
                    select count(1) sum_students, {$area_id} `area_id` from members m
                        inner join areas a       on m.area_id = a.id
                    where m.year = {$fyear} and a.oid BETWEEN {$limit->_skip} and {$limit->_limit} and m.edu_status=1)ss on ss.area_id = a.id
                left join (   
                    select count(1) sum_dropout_students, {$area_id} `area_id` from members m
                        left join areas a       on m.area_id   = a.id
                    where a.oid BETWEEN {$limit->_skip} and {$limit->_limit} and m.birthday > {$fbegin_year} and m.birthday < {$fend_year} and m.edu_status=0
                    )dd on dd.area_id = a.id
                where a.id = {$area_id}
                union all 
                select sum_families, sum_members, sum_funds, sum_students, sum_dropout_students, {$year} `year` from areas a 
                left join (
                    select count(1) sum_families, sum(members) sum_members, {$area_id} `area_id` from families f 
                        left join areas a  on f.area_id = a.id 
                    where  f.year = {$year} and a.oid BETWEEN {$limit->_skip} and {$limit->_limit})ff on ff.area_id = a.id 
                left join(
                    select sum(p.funds) sum_funds, {$area_id} `area_id` from edu_records_policies rp 
                        left join epa_policies p on rp.epa_policy_id = p.id
                        left join edu_records r  on rp.edu_record_id = r.id
                        inner join areas a       on rp.area_id       = a.id
                    where   a.oid BETWEEN {$limit->_skip} and {$limit->_limit})fp on fp.area_id = a.id
                left join (   
                    select count(1) sum_students, {$area_id} `area_id` from members m
                        inner join areas a       on m.area_id   = a.id
                    where m.year=2018 AND  a.oid BETWEEN {$limit->_skip} and {$limit->_limit} and m.edu_status=1 )ee on ee.area_id = a.id
                left join (   
                    select count(1) sum_dropout_students, {$area_id} `area_id` from members m
                        inner join areas a       on m.area_id   = a.id
                    where a.oid BETWEEN {$limit->_skip} and {$limit->_limit} and m.birthday > {$fbegin_year} and m.birthday < {$fend_year} and m.edu_status=0)dd on dd.area_id = a.id
                where a.id = {$area_id}
                ";
//               return $sql;
        $data = DB::select($sql);
        return response()->json($data, 200);
    }
}
