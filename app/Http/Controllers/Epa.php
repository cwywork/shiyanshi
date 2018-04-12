<?php
namespace App\Http\Controllers;
use Validator;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Firebase\JWT\JWT;

class Epa extends Controller
{
    protected $user;

    public function __construct(){
        $this->user = app('user');
    }

    /* ===================================== 贫困户 begin =================================================== */
    public function getFamilies(Request $request) 
    {
        


        $rules = [
            'keywords'  => '',
            'skip'      => 'required|numeric|min:0',
            'limit'     => 'required|numeric|max:50',
            'area_id'   => 'numeric'
        ];

        $messages = [
            'required'  => 'ERR_PARAM_:attribute_REQUIRED',
            'min'       => 'ERR_PARAM_:attribute_INVALID',
            'max'       => 'ERR_PARAM_:attribute_INVALID',
            'regex'     => 'ERR_PARAM_:attribute_INVALID',
            'numeric'   => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'keywords'  => 'KEYWORDS',
            'skip'      => 'SKIP',
            'limit'     => 'LIMIT',
            'area_id'   => 'AREAID'
        ];

        
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }

        $params = $request->only('keywords', 'skip' , 'limit', 'area_id');
        $params = (object)array_filter($params, function($v){return !is_null($v);});
        if(isset($params->keywords)){
            $params->keywords = trim($params->keywords);
        }
        //整合查询条件
        $area_id = $this->user->areas[0]->id;
        $parea_id = intval($params->area_id);
        if(intval($params->area_id) > 0) $area_id = intval($params->area_id);
        $area = (object)$this->getAreasRange($area_id);
        $where  = "a.oid between ? and ?";
        $wVaule = [$area->_skip, $area->_limit];
        $has_join = '';
        $has_group = '';
        if(!empty($params->keywords)) {
            $keywords = mb_substr($params->keywords, 0, 18, 'utf-8');
            $has_join   = ' inner join members m on m.family_id = f.id ';
            $has_group  = ' group by f.id ';
            $where .= " and (m.realname like "."'%{$params->keywords}%' OR m.id_code like '%{$params->keywords}%' OR m.mobile like '%{$params->keywords}%' )";
            // $wVaule[] = "'"."%{$params->keywords}%"."'";
            // $wVaule[] = "'"."%{$params->keywords}%"."'";
            // $wVaule[] = "'"."%{$params->keywords}%"."'";
        } 
        //获取贫困户列表
        $sql = "SELECT count(1) jcount, sum(members) total_members FROM families f 
                    {$has_join}
                    inner join members hm on f.holder_id = hm.id
                    LEFT JOIN areas a   ON f.area_id = a.id 
                WHERE {$where} {$has_group}";
        //获取总条数
        // return $sql;
        $total = DB::select($sql, $wVaule);
        // return $total;
        if(!$total) return response()->json(['total' => 0, 'data'  => []], 200);
//        date("Y-m-d",$unixtime)
        $fields = "f.import_data, hm.id_code, (hm.birthday*3600*24) age, f.id, f.verify, f.members,f.area_id,f.members, f.poor_status,f.poor_standard, f.poor_type, f.poor_causes_id, f.verify, hm.profile, hm.realname holder_realname, hm.id_code holder_id_code, a.name area_name, hm.mobile holder_mobile ";
        $sql = " SELECT {$fields} FROM families f 
                    {$has_join}
                    inner join members hm on f.holder_id = hm.id
                    LEFT JOIN areas a   ON f.area_id = a.id 
                WHERE ".$where." {$has_group} order by f.posted_at desc, f.id desc limit {$params->skip} , {$params->limit}";
                // return $sql;
        $data   = DB::select($sql, $wVaule);
    //    return $data;
        $sql = '';
        if(isset($data[0])) {
            foreach ($data as $k => $v) {
                $v->age=ceil((time()- $v->age)/365/24/3600);
                $sql .= empty($sql) ? '': ' union all ';
                $sql .= "select count(1) std_count, family_id from members where family_id = {$v->id} and edu_status = 1 ";
            }
            $std_num = DB::select($sql);

            foreach ($data as $key => $val) {
                $tmp = 0;
                foreach ($std_num as $k => $v) {
                    if($val->id == $v->family_id) {
                        $tmp = $v->std_count;
                    }
                }
                $data[$key]->std_count = $tmp;
            }
        }
        $data   = array('total'         => empty($params->keywords) ? $total[0]->jcount         : count($total),
                        'total_members' => empty($params->keywords) ? $total[0]->total_members  : $this->membersAcc($total),
                        'data'          => $data);
        return response()->json($data, 200);
    }
    /* ===================================== 贫困学生列表=================================================== */
    public function getDropStudents(Request $request) {
        $rules = [
            'begin_age'  => 'numeric',
            'end_age'  => 'numeric',
            'skip'      => 'required|numeric|min:0',
            'limit'     => 'required|numeric|max:50',
            'area_id'   => 'numeric'
        ];
        $messages = [
            'required'  => 'ERR_PARAM_:attribute_REQUIRED',
            'min'       => 'ERR_PARAM_:attribute_INVALID',
            'max'       => 'ERR_PARAM_:attribute_INVALID',
            'regex'     => 'ERR_PARAM_:attribute_INVALID',
            'numeric'   => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'begin_age'  => 'BEGINAGE',
            'end_age'  => 'ENDAGE',
            'skip'      => 'SKIP',
            'limit'     => 'LIMIT',
            'area_id'   => 'AREAID'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }

        $params = $request->only('begin_age','end_age', 'skip' , 'limit', 'area_id');
        $params = (object)array_filter($params, function($v){return !is_null($v);});
        $area_id = $this->user->areas[0]->id;
        $parea_id = intval($params->area_id);
        if(intval($params->area_id) > 0) $area_id = intval($params->area_id);
        $limit = (object)$this->getAreasRange($area_id);
        // return $area->_limit ;
        $begin_year=ceil(time()/86400 - 365*$params->end_age);
        $end_year=ceil(time()/86400 - 365*($params->begin_age-1));
        $sql = "select count(*) total_students from members m
        left join areas a on m.area_id=a.id
        where m.birthday < {$end_year} and m.birthday > {$begin_year} and a.oid between {$limit->_skip} and {$limit->_limit}
                       and m.edu_status=0";
        //获取总条数
        // return $sql;
        $total = DB::select($sql);
        $sql="";
        // return $total;
        if(!$total) return response()->json(['total' => 0, 'data'  => []], 200);
        $fields = "m.id,m.gender, m.realname,e.name mingzu,m.birthday,m.id_code,m.mobile,p.name jiaoyu,pp.name wenhua,ppp.name grade,a.name area";
        $sql="select {$fields} from members m
        left join ethnics e on m.ethnic=e.id
        left join edu_records r on m.edu_records_id=r.id
        left join edu_phases p on r.phase_id=p.id
        left join edu_phases pp on m.edu_phases_id=pp.id
        left join edu_phases ppp on r.grade=ppp.id
        left join areas a on m.area_id=a.id
        where m.birthday < {$end_year} and m.birthday > {$begin_year} and a.oid between {$limit->_skip} and {$limit->_limit}
        and m.edu_status=0 limit {$params->skip} , {$params->limit}
        ";
        $data = DB::select($sql);
        $data   = array('total_members' => $total[0]->total_students,'data'=> $data);
        return response()->json($data, 200);

    }

    public function getGradeStudents(Request $request) {
        $rules = [
            'skip'      => 'required|numeric|min:0',
            'limit'     => 'required|numeric|max:50',
            'area_id'   => 'numeric'
        ];
        $messages = [
            'required'  => 'ERR_PARAM_:attribute_REQUIRED',
            'min'       => 'ERR_PARAM_:attribute_INVALID',
            'max'       => 'ERR_PARAM_:attribute_INVALID',
            'regex'     => 'ERR_PARAM_:attribute_INVALID',
            'numeric'   => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'skip'      => 'SKIP',
            'limit'     => 'LIMIT',
            'area_id'   => 'AREAID'
        ];
        
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }

        $params = $request->only('grade_id', 'skip' , 'limit', 'area_id');
        $params = (object)array_filter($params, function($v){return !is_null($v);});
        $area_id = $this->user->areas[0]->id;
        $parea_id = intval($params->area_id);
        if(intval($params->area_id) > 0) $area_id = intval($params->area_id);
        $limit = (object)$this->getAreasRange($area_id);
        if($params->grade_id == 100){
            $params->grade_id = "'"."7,8,9,10,11,51"."'";
        }
        $sql="";
        $sql.="select count(*) total_students from members m
        left join (select * FROM edu_records rr where not exists(select 1 from edu_records where rr.member_id = member_id and rr.id<id))r
        on r.member_id=m.id
        left join areas a on m.area_id=a.id
        where  FIND_IN_SET(r.phase_id, $params->grade_id) and a.oid between {$limit->_skip} and {$limit->_limit} and m.edu_status=1 and m.family_id != 0";


        //获取总条数
        // return $sql;
        $total = DB::select($sql);
       
        if(!$total) return response()->json(['total' => 0, 'data'  => []], 200);

        $sql="";


        $fields = "m.id,m.gender,m.realname,e.name mingzu,m.birthday,m.id_code,m.mobile,p.name jiaoyu,pp.name wenhua,ppp.name grade,a.name area";
        $sql="select {$fields} from members m
        left join ethnics e on m.ethnic=e.id
        left join (select * FROM edu_records rr 
        where not exists(select 1 from edu_records where rr.member_id = member_id and rr.id<id))r
        on m.edu_records_id=r.id
        left join edu_phases p on r.phase_id=p.id
        left join edu_phases pp on m.edu_phases_id=pp.id
        left join edu_phases ppp on r.grade=ppp.id
        left join areas a on m.area_id=a.id
        where  FIND_IN_SET(r.phase_id, $params->grade_id) and a.oid between {$limit->_skip} and {$limit->_limit}
        limit {$params->skip} , {$params->limit}
        ";
        $data = DB::select($sql);
        $data   = array('total_members' => $total[0]->total_students,'data'=> $data);
        return response()->json($data, 200);
    }

    private function membersAcc($data)
    {
        if(empty($data)) return 0;
        $acc = 0;
        foreach ($data as $k => $v) {
            $acc += $v->total_members;
        }
        return $acc;
    }

    /**
     * 获取单条贫困户信息，包括户基本信息和贫困户成员信息
     */
    public function getFamilyOne(Request $request, $id) 
    {

        $id     = intval($id);
        $holder = DB::select("SELECT * from families WHERE id = ".$id);
        if(empty($holder)) return response()->json(['code' => 'ERR_NOT_FOUND'], 404);
        $members = DB::select("select id, year, id_code, relationship, area_id, realname, gender, profile, (birthday*86400) birthday, ethnic, mobile, edu_status, edu_phases_id, edu_records_id, posted_at ,import_data from members where family_id = {$id} order by relationship");
        foreach ($members as $k => $v) {
            
            // $members[$k]->age= date('Y')-date('Y',$members[$k]->birthday);
            $members[$k]->age= ceil((time()-$members[$k]->birthday)/3600/24/365);
        }
        $family  = $holder[0];
        $family->_members = $members;
        return response()->json($family, 200);
    }

    /**
     * 新增一个贫困户
     */
    public function insertFamily(Request $request) 
    {
        $rules = [
            'holder_id'         => 'required|numeric',
            'area_id'           => 'required|numeric',
            'poor_status'       => 'required|min:1|max:4',
            'poor_standard'     => 'required|min:1|max:3',
            'poor_type'         => 'required|min:1|max:3',
            'poor_causes_id'    => 'required|numeric'
        ];

        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'min'               => 'ERR_PARAM_:attribute_INVALID',
            'max'               => 'ERR_PARAM_:attribute_INVALID',
            'numeric'           => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'holder_id'         => 'HOLDERID',
            'area_id'           => 'AREAID',
            'poor_status'       => 'POORSTATUS',
            'poor_standard'     => 'POORSTANDARD',
            'poor_type'         => 'POORTYPE',
            'poor_causes_id'    => 'POORCAUSEID'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = (object)$request->only('holder_id', 'area_id', 'poor_status', 'poor_standard', 'poor_type', 'poor_causes_id', 'remark');
        //判断贫困户表是否有户主的ID
        $find = DB::select('SELECT 1 from families where holder_id = ?', [$params->holder_id]);
        if(!empty($find)) return response()->json(['code' => 'ERR_HOLDER_EXISTS'], 400);
        $params->remark     =" ";
        $params->year       = date('Y');
        $params->members    = 1;
        $params->posted_by  = $this->user->id;
        $params->posted_at  = time();
        $data = json_decode(json_encode($params), true);
        //插入贫困户数据
        $id = DB::table('families')->insertGetId($data);
        //修改户主贫困户成员表户ID
        DB::update('UPDATE members set family_id=? where id = ?',[$id, $params->holder_id]);
        $data = DB::select('SELECT f.id family_id, m.realname holder_name, m.id_code from families f left join members m on f.holder_id = m.id where f.id = ?',[$id]);
        if(!empty($data)) $this->createLog(2, $this->user->id, json_encode($data[0], JSON_UNESCAPED_UNICODE), 'Epa@'.__FUNCTION__);
        return response()->json(['id' => $id], 200);
    }

    /**
     * 更新一个贫困户
     */
    public function updateFamily(Request $request, int $id)
    {
        $rules = [
            'poor_status'       => 'min:1|max:4',
            'poor_standard'     => 'min:1|max:3',
            'poor_type'         => 'min:1|max:3',
            'verify'            => 'in:0,1',
            'poor_causes_id'    => 'numeric'
        ];

        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'min'               => 'ERR_PARAM_:attribute_INVALID',
            'max'               => 'ERR_PARAM_:attribute_INVALID',
            'numeric'           => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'poor_status'       => 'POORSTATUS',
            'poor_standard'     => 'POORSTANDARD',
            'poor_type'         => 'POORTYPE',
            'verify'            => 'VERIFY',
            'poor_causes_id'    => 'POORCAUSEID'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        
        $params = $request->only('poor_status', 'poor_standard', 'poor_type', 'verify', 'poor_causes_id', 'remark');
        // return $params;
        $params = (object)array_filter($params, function($v){return !is_null($v);});
        if(!get_object_vars($params)) return $this->getFamilyOne($request, $id);

        $find = DB::select('SELECT f.id family_id, m.realname holder_name, m.id_code 
                            from families f left join members m on f.holder_id = m.id where f.id = ?', [$id]);
        if(empty($find)) return response()->json(['code' => 'ERR_NOT_FOUND'], 404);
        $setData = json_decode(json_encode($params), true);
        
        //更新贫困户数据
        DB::table('families')->where('id', $id)->update($setData);
        $params->family_id      = $find[0]->family_id;
        $params->holder_name    = $find[0]->holder_name;
        $params->id_code        = $find[0]->id_code;
        $this->createLog(2, $this->user->id, json_encode($params, JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        return $this->getFamilyOne($request, $id);
    }

    /**
     * 删除一个贫困户
     */
    public function deleteFamily(Request $request, int $id)
    {
        $find = DB::select('SELECT f.id family_id,m.realname holder_name,m.id_code from families f left join members m on f.holder_id = m.id where f.id = ?', [$id]);
        if(empty($find)) return response()->json(['code' => 'ERR_NOT_FOUND'], 404);
        //解散贫困户
        DB::beginTransaction();
        try {
            DB::update('UPDATE members set family_id=?, area_id = ? where family_id = ?', [0, 0, $id]);
            $num=DB::delete('DELETE from families where id = ?',[$id]);
            DB::commit();
        } catch (PDOException $ex) {
            DB::rollback();
        }
        $this->createLog(2, $this->user->id, json_encode($find[0], JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        return response()->json(['family_id' => $id], 200);
    }

    /**
     * 添加一成员到贫困户
     */
    public function memberPutFamily(Request $request, int $id)
    {
        //判断户是否存在
        $find = DB::select('SELECT id from families where id = ?', [$id]);
        if(!$find) return response()->json(['code' => 'ERR_NOT_FOUND_FAMILY'], 404);
        $params = (object)$request->only('member_id');

        if(intval($params->member_id) <= 0) return response()->json(['code' => 'ERR_PARAM_MEMBER_ID'], 400);
        //判断加入成员是否在其他户中
        $member = DB::select('SELECT family_id from members where id = ?', [$params->member_id]);
        if($member[0]->family_id) {
            $holder = DB::select('select f.id,f.area_id, m.realname, m.mobile,m.gender from families f 
                                    left join members m on f.holder_id = m.id where f.id=?', [$member[0]->family_id]);
            $holder = empty($holder) ? [] : $holder[0];
            return response()->json($holder, 409);
        }
        $flog = false;
        DB::beginTransaction();
        try {
            DB::update('UPDATE members set family_id=? where id = ?', [$id, $params->member_id]);
            $num = DB::table('members')->where('family_id',$id)->count('id');
            DB::update('UPDATE families set members=? where id = ?', [$num, $id]);
            DB::commit();
            $flog = true;
        } catch (PDOException $ex) {
            DB::rollback();
        }
        $params->family_id = $id;
        $sql =" select mm.family_id, mm.realname holder_name,mm.id_code holder_code, m.realname, m.id_code from members m 
                    inner join families f on m.family_id = f.id
                    inner join members mm on f.holder_id = mm.id 
                where m.id={$params->member_id}";
        $data = DB::select($sql);
        if(!empty($data)) $this->createLog(2, $this->user->id, json_encode($data[0], JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        return response()->json([], 200);
    }

    /**
     * 移除一成员到买个贫困户 members 表中family_id 设置为0 area_id 设置为0
     */
    public function removePutFamily(Request $request, int $id, $mid)
    {
        //判断户是否存在
        $find = DB::select('SELECT holder_id from families where id = ?', [$id]);
        if(empty($find)) return response()->json(['code' => 'ERR_NOT_FOUND_FAMILY'], 400);
        if($find[0]->holder_id == $mid) return response()->json(['code' => 'ERR_MEMBER_IS_HOLDER'], 400);
        //判断加入成员是否在其他户中
        $sql =" select mm.family_id, mm.realname holder_name,mm.id_code holder_code, m.realname, m.id_code from members m 
                    inner join families f on m.family_id = f.id
                    inner join members mm on f.holder_id = mm.id 
                where m.id={$mid}";
        $member = DB::select($sql);
        if(empty($member)) return response()->json(['code' => 'ERR_NOT_FOUND_MEMBER'], 404);
        $flog = false;
        DB::beginTransaction();
        try {
            // DB::update('UPDATE members set family_id=?, area_id = ? where id = ?', [0, 0, $mid]);
            DB::delete('DELETE FROM members WHERE id=?', [$mid]);
            DB::delete('DELETE FROM edu_records WHERE member_id=?', [$mid]);
            $num = DB::table('members')->where('family_id',$id)->count('id');
            DB::update('UPDATE families set members=? where id = ?', [$num, $id]);
            DB::commit();
            $flog = true;
        } catch (PDOException $ex) {
            DB::rollback();
        }
        $this->createLog(2, $this->user->id, json_encode($member[0], JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        return response()->json([], 200);
    }


    /**
     * 高级检索贫困户成员
     */
    public function searchMembers(Request $request)
    {
        //3.21日添加学校是否省内has_local 是否提供住宿has_boarding
        $rules = [
            'skip'              => 'required',
            'limit'             => 'required',
            'age_begin'         => 'numeric',
            'area_id'           => 'required|numeric',
            'age_begin'         => 'numeric',
            'age_end'           => 'numeric',
            'edu_status'        => 'in:0,1',
            'phase_id'          => 'numeric',
            'grade'             => 'numeric',
            'edu_phases_id'     => 'numeric',
            'has_major'         => 'in:0,1',
            //'dropout_causes'    => 'numeric'
            'has_local'         => 'in:1,2',
            'has_boarding'      => 'in:1,2',
            'school_id'            => 'numeric',
        ];


        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'in'                => 'ERR_PARAM_:attribute_INVALID',
            'numeric'           => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'skip'              => 'SKIP',
            'limit'             => 'LIMIT',
            'area_id'           => 'AREAID',
            'age_begin'         => 'AGEBEGIN',
            'age_end'           => 'AGEEND',
            'edu_status'        => 'EDUSTATUS',
            'phase_id'          => 'PHASEID',
            'grade'             => 'GRADE',
            'edu_phases_id'     => 'EDUPHASESID',
            'has_major'         => 'HASMAJOR',
            //'dropout_causes'    => 'DROPOUTCAUSE'
            'has_local'         => 'HASLOCAL',
            'has_boarding'         => 'HASBOARDING',
            'school_id'            =>'SCHOOLID',

        ];
      
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }

        $params = $request->only('skip', 'limit','area_id', 'age_begin', 'age_end', 'edu_status', 'phase_id', 'grade', 'edu_phases_id', 'has_major', 'dropout_causes','has_local','has_boarding','school_id');
       
        $params = (object)array_filter($params, function($v){return !is_null($v);});
        $where  = ' 1=1 ';
        $vWhere = [];
        if(isset($params->area_id) && intval($params->area_id) > 0){
            $limit = $this->getAreasRange($params->area_id);
            $where .= " and a.oid between ? and ? "; 
            $vWhere[] = $limit['_skip'];
            $vWhere[] = $limit['_limit'];
        }
        if(isset($params->age_begin) && intval($params->age_begin) > 0) {
            $tday       =  ceil(time()/86400 - 365*intval($params->age_begin-1));
            $where     .= " and m.birthday < ? ";
            $vWhere[]   = $tday;

        }

        if(isset($params->age_end) && intval($params->age_end) > 0) {
            $tday       = ceil(time()/86400 - 365*intval($params->age_end));
            $where     .= " and m.birthday > ? ";
            $vWhere[]   = $tday;
        }
//        return $vWhere;
        if(isset($params->edu_status)) {
            $where .= " and m.edu_status = ? ";
            $vWhere[] = intval($params->edu_status);
        }
        if(isset($params->edu_phases_id) && intval($params->edu_phases_id) > 0) {
            $where .= " and m.edu_phases_id = ? ";
            $vWhere[] = intval($params->edu_phases_id);
        }
        if(isset($params->grade) && intval($params->grade) > 0) {
            $where .= " and r.grade = ? ";
            $vWhere[] = intval($params->grade);
        }

        //3.21日添加学校是否省内has_local 是否提供住宿has_boarding
        if(isset($params->has_local) && intval($params->has_local) > 0) {
            $where .= " and r.has_local = ? ";
            $vWhere[] = intval($params->has_local);
        }
        if(isset($params->has_boarding) && intval($params->has_boarding) > 0) {
            $where .= " and r.has_boarding = ? ";
            $vWhere[] = intval($params->has_boarding);
        }
        if(isset($params->school_id) && intval($params->school_id) > 0) {
            $where .= " and r.school_id = ? ";
            $vWhere[] = intval($params->school_id);
        }
        if(isset($params->phase_id) && intval($params->phase_id) > 0) {
            $where .= " and r.phase_id = ? ";
            $vWhere[] = intval($params->phase_id);
        }
        if(isset($params->has_major)) {
            if($params->has_major == 0){
                $where .= " and v.edu_major_id is null ";
            }else{
                $where .= " and v.edu_major_id > 0 ";
            }
           
        }

        if(isset($params->dropout_causes) && strlen($params->dropout_causes) > 0) {
            $tmp = explode(',', $params->dropout_causes);
            $sw     = '';
            foreach ($tmp as $k => $v) {
                if(intval($v) > 0 ) {
                    $sw .= empty($sw) ? '' : ' or ';
                    $sw .= ' r.dropout_causes_id='. intval($v);
                }
            }
            // return $sw;
            $where .= 'and ('.$sw.')';
        }
        $fields = 'm.id, m.realname, m.gender, m.ethnic, m.id_code, substring(m.id_code,7,8) shenri, m.mobile, m.edu_status, m.edu_phases_id,a.name area_name, (m.birthday*86400) birthday, r.phase_id, r.grade,r.has_local,r.school_id ,s.sch_name,ep.name,eep.name jiaoyu';
        $sqlt = "select count(1) jcount from areas a 
                    left join members m on m.area_id = a.id 
                    left join (SELECT r.member_id, r.status, r.dropout_causes_id, r.grade, r.has_local,r.has_boarding,r.school_id,r.phase_id FROM edu_records r WHERE not EXISTS (SELECT 1 FROM edu_records where r.member_id = member_id AND r.id < id )) r on r.member_id = m.id
                 left join edu_ves v on v.member_id = m.id
                where {$where} and m.area_id is not null and m.family_id != 0";
//        return $vWhere;
//        return $sqlt;
        $sqld = "select {$fields} from members m 
                    left join edu_phases ep on m.edu_phases_id=ep.id
                    left join areas a on m.area_id = a.id 
                    left join (SELECT r.id, r.member_id, r.status, r.dropout_causes_id, r.grade, r.has_local,r.has_boarding,r.school_id,r.phase_id FROM edu_records r WHERE not EXISTS (SELECT 1 FROM edu_records where r.member_id = member_id AND r.id < id)) r on r.member_id = m.id
                    left join edu_phases eep on eep.id=r.phase_id
                    left join schools s on s.id=r.school_id 
                    left join edu_ves v on v.member_id = m.id
                where {$where} and m.area_id is not null and m.family_id != 0 limit {$params->skip} , {$params->limit}";
//        return $sqlt;
        $total = DB::select($sqlt, $vWhere);
        $data  = DB::select($sqld, $vWhere); 

        return response()->json(['total'=> empty($total) ? 0 : $total[0]->jcount, 'data'=>$data], 200);
    }

    public function searchMemberCounts(Request $request)
    {
        $rules = [
            'area_id'           => 'required|numeric',
            'age_begin'         => 'numeric',
            'age_end'           => 'numeric',
            'edu_status'        => 'in:0,1',
            'phase_id'          => 'numeric',
            'grade'             => 'numeric',
            'edu_phases_id'     => 'numeric',
            'has_major'         => 'in:0,1',
            //'dropout_causes' => 'numeric'
            'has_local'        => 'in:1,2',
            'has_boarding'        => 'in:1,2',
        ];

        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'in'                => 'ERR_PARAM_:attribute_INVALID',
            'numeric'           => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'area_id'           => 'AREAID',
            'age_begin'         => 'AGEBEGIN',
            'age_end'           => 'AGEEND',
            'edu_status'        => 'EDUSTATUS',
            'phase_id'          => 'PHASEID',
            'grade'             => 'GRADE',
            'edu_phases_id'     => 'EDUPHASESID',
            'has_major'         => 'HASMAJOR',
            //'dropout_causes'    => 'DROPOUTCAUSE'
            'has_local'         => 'HASLOCAL',
            'has_boarding'         => 'HASBOARDING',
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = $request->only('skip', 'limit','area_id', 'age_begin', 'age_end', 'edu_status', 'phase_id', 'grade', 'edu_phases_id', 'has_major', 'dropout_causes','has_local','has_boarding','school_id');
     
        $params = (object)array_filter($params, function($v){return !is_null($v);});
        $where  = ' 1=1 ';
        $vWhere = [];
        
        if(isset($params->age_begin) && intval($params->age_begin) > 0) {
            $tday       =  ceil(time()/86400 - 365*intval($params->age_begin-1));
            $where     .= " and m.birthday <= {$tday} ";
        }
        if(isset($params->age_end) && intval($params->age_end) > 0) {
            $tday       = ceil(time()/86400 - 365*intval($params->age_end));
            $where     .= " and m.birthday >= {$tday} ";
        }
        if(isset($params->edu_status)) {
            $where .= " and m.edu_status = {$params->edu_status} ";
        }
        if(isset($params->edu_phases_id) && intval($params->edu_phases_id) > 0) {
            $where .= " and m.edu_phases_id = {$params->edu_phases_id} ";
        }
        if(isset($params->grade) && intval($params->grade) > 0) {
            $where .= " and r.grade = $params->grade ";
        }

        //3.21日添加学校是否省内has_local 是否提供住宿has_boarding
        if(isset($params->has_local) && intval($params->has_local) > 0) {
            $where .= " and r.has_local = $params->has_local ";

        }
        if(isset($params->has_boarding) && intval($params->has_boarding) > 0) {
            $where .= " and r.has_boarding = $params->has_boarding ";

        }
        if(isset($params->school_id) && intval($params->school_id) > 0) {
            $where .= " and r.school_id = $params->school_id ";

        }
//        if(isset($params->has_boarding) && intval($params->has_boarding) > 0) {
//            $where .= " and r.has_boarding = ? ";
//            $vWhere[] = intval($params->has_boarding);
//        }
        if(isset($params->phase_id) && intval($params->phase_id) > 0) {
            $where .= " and r.phase_id = {$params->phase_id} ";
        }
        if(isset($params->has_major)) {
            if($params->has_major == 0){
                $where .= " and v.edu_major_id is null ";
            }else{
                $where .= " and v.edu_major_id > 0 ";
            }
           
        }
        if(isset($params->dropout_causes) && strlen($params->dropout_causes) > 0) {
            $tmp = explode(',', $params->dropout_causes);
            $sw     = '';
            foreach ($tmp as $k => $v) {
                if(intval($v) > 0 ) {
                    $sw .= empty($sw) ? '' : ' or ';
                    $sw .= 'r.dropout_causes_id='. intval($v);
                }
            }
            $where .= 'and ('.$sw.')';
        }
        $data = [];
        $areas = $this->getNextLevel($params->area_id, ' * ');
        if(!isset($areas[0]))       return response()->json([], 200);
        $sql = '';
        foreach ($areas as $val) {
            $limit = $this->getAreasRangeByOid($val->oid, $val->level);
            $sql .= empty($sql) ? '' : ' union all ';
            $sql .= "select count(1) jcount, '{$val->name}' area_name from members m 
                        left join areas a on m.area_id = a.id 
                        left join (SELECT r.member_id, r.status, r.dropout_causes_id, r.grade, r.has_boarding,r.has_local,r.phase_id ,r.school_id FROM edu_records r WHERE not EXISTS (SELECT 1 FROM edu_records where r.member_id = member_id AND r.id < id)) r on r.member_id = m.id
                        left join edu_ves v on v.member_id = m.id
                    where {$where} and m.family_id != 0 and a.oid between {$limit->_skip} and {$limit->_limit}";
        }

        $data  = DB::select($sql, $vWhere);  
        return response()->json($data, 200);
    }

    /**
     * 高级检索贫困户成员导出
     */
    public function exportMembers(Request $request)
    {
        $rules = [
            'area_id'           => 'required|numeric',
            'age_begin'         => 'numeric',
            'age_end'           => 'numeric',
            'edu_status'        => 'in:0,1',
            'phase_id'          => 'numeric',
            'grade'             => 'numeric',
            'edu_phases_id'     => 'numeric',
            'has_major'         => 'in:0,1',
            //'dropout_causes'    => 'numeric'
        ];
        $messages = [
            'in'                => 'ERR_PARAM_:attribute_INVALID',
            'numeric'           => 'ERR_PARAM_:attribute_INVALID'
        ];
        $attributes = [
            'area_id'           => 'AREAID',
            'age_begin'         => 'AGEBEGIN',
            'age_end'           => 'AGEEND',
            'edu_status'        => 'EDUSTATUS',
            'phase_id'          => 'PHASEID',
            'grade'             => 'GRADE',
            'edu_phases_id'     => 'EDUPHASESID',
            'has_major'         => 'HASMAJOR',
            //'dropout_causes'    => 'DROPOUTCAUSE'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = $request->only('skip', 'limit','area_id', 'age_begin', 'age_end', 'edu_status', 'phase_id', 'grade', 'edu_phases_id', 'has_major', 'dropout_causes','has_local','has_boarding','school_id');
        $params = (object)array_filter($params, function($v){return !is_null($v);});
        $where  = ' 1=1 ';
        $vWhere = [];
        if(isset($params->area_id) && intval($params->area_id) > 0){
            $limit = $this->getAreasRange($params->area_id);
            $where .= " and a.oid between ? and ? ";
            $vWhere[] = $limit['_skip'];
            $vWhere[] = $limit['_limit'];
        }
        if(isset($params->age_begin) && intval($params->age_begin) > 0) {
            $tday       =  ceil(time()/86400 - 365*(intval($params->age_begin)-1));
            $where     .= " and m.birthday < ? ";
            $vWhere[]   = $tday;
        }
        if(isset($params->age_end) && intval($params->age_end) > 0) {
            $tday       = ceil(time()/86400 - 365*intval($params->age_end));
            $where     .= " and m.birthday > ? ";
            $vWhere[]   = $tday;
        }
        if(isset($params->edu_status)) {
            $where .= " and m.edu_status = ? ";
            $vWhere[] = intval($params->edu_status);
        }
        if(isset($params->edu_phases_id) && intval($params->edu_phases_id) > 0) {
            $where .= " and m.edu_phases_id = ? ";
            $vWhere[] = intval($params->edu_phases_id);
        } 
        if(isset($params->grade) && intval($params->grade) > 0) {
            $where .= " and r.grade = ? ";
            $vWhere[] = intval($params->grade);
        }
        //3.21日添加学校是否省内has_local 是否提供住宿has_boarding
        if(isset($params->has_local) && intval($params->has_local) > 0) {
            $where .= " and r.has_local = ? ";
            $vWhere[] = intval($params->has_local);            
            
        }
        if(isset($params->has_boarding) && intval($params->has_boarding) > 0) {
            $where .= " and r.has_boarding = ? ";
            $vWhere[] = intval($params->has_boarding);
        }
        if(isset($params->school_id) && intval($params->school_id) > 0) {
            $where .= " and r.school_id = ? ";
            $vWhere[] = intval($params->school_id);
        }

        if(isset($params->phase_id) && intval($params->phase_id) > 0) {
            $where .= " and r.phase_id = ? ";
            $vWhere[] = intval($params->phase_id);
        }
        if(isset($params->has_major)) {
            $where .= " and v.edu_major_id > 0 ";
        }
        if(isset($params->dropout_causes) && strlen($params->dropout_causes) > 0) {
            $tmp = explode(',', $params->dropout_causes);
            $sw     = '';
            foreach ($tmp as $k => $v) {
                if(intval($v) > 0 ) {
                    $sw .= empty($sw) ? '' : ' or ';
                    $sw .= ' r.dropout_causes_id='. intval($v);
                }
            }
            // and r.status = 5 
            $where .= ' and ('.$sw.')';
        }

        $fields = 'h.realname holder_name, h.id_code holder_code, m.relationship, m.realname, m.gender, et.name ethnic, m.id_code, m.mobile, m.edu_status, p.name phases_name, ss.sch_name, m.birthday, pp.name edu_phases_name, gp.name grade_name, a.name village, b.name town, c.name county, d.name city';
        set_time_limit(0);
        ini_set('memory_limit', '2048M');
        ob_end_clean();  
        $name='members';  
        header('Cache-control: max-age=0');  
        header('Expires: '.gmdate('D, d M Y H:i:s', time() - 31536000).' GMT');  
        header('Content-Encoding: none');  
        header('Content-Disposition: attachment; filename='.$name.'.csv');  
        header('Content-Type: text/plain');   
        $title = ['户主','户主身份证','与户主关系','成员姓名','性别','民族','生日','年龄','身份证号','手机号','是否学生','文化程度','教育阶段','学校名称 ','年级','行政区划'];
        foreach ($title as $key => $val) {
            $title[$key] = mb_convert_encoding($val, "UTF-8", "auto");
        }
        $handle = fopen("php://output", 'w');  
        fputcsv($handle, $title);
        $skip = 0;
        $limit = 100000;
        for($i = 0; $i<=10; $i++){
            $skip = $i == 0 ? $i : $i * $limit + 1;
            $sqld = "select {$fields} from members m 
                        left join areas a on m.area_id = a.id
                        left join areas b on a.pid = b.id 
                        left join areas c on b.pid = c.id
                        left join areas d on c.pid = d.id
                        left join (SELECT r.has_boarding, r.has_local, r.id,r.school_id,r.member_id, r.status, r.dropout_causes_id, 
                        r.grade, r.phase_id FROM edu_records r WHERE not EXISTS 
                        (SELECT 1 FROM edu_records where r.member_id = member_id AND r.id < id)) r 
                        on r.member_id = m.id
                        left join schools ss on ss.id=r.school_id
                        left join edu_ves v on v.member_id = m.id
                        left join families f on m.family_id = f.id
                        left join members h on f.holder_id = h.id
                        left join edu_phases p on m.edu_phases_id = p.id
                        left join edu_phases pp on r.phase_id = pp.id
                        left join edu_phases gp on r.grade = gp.id
                        left join ethnics et on m.ethnic = et.id
                    where m.area_id is not null and m.family_id != 0 and {$where} limit {$skip} , {$limit} ";
            $data  = DB::select($sqld, $vWhere); 
            $tmp = [];
            foreach ($data as $k => $v) {              
                $tmp['holder_name'] = mb_convert_encoding($v->holder_name, "UTF-8", "auto");
                $tmp['holder_code'] = $v->holder_code."\n";
                $tmp['relationship']= mb_convert_encoding($this->relationshipZh($v->relationship), "UTF-8", "auto");
                $tmp['realname']    = mb_convert_encoding($v->realname, "UTF-8", "auto");
                $tmp['gender']      = mb_convert_encoding($v->gender == 1 ? '男':'女', "UTF-8", "auto");
                $tmp['ethnic']      = mb_convert_encoding($v->ethnic, "UTF-8", "auto");
                $tmp['birthday']    = date('Y-m-d', (int)($v->birthday * 86400));
                $tmp['age']         = $this->calcAge($tmp['birthday']);
                $tmp['id_code']     = $v->id_code."\n";
                $tmp['mobile']      = '+086 '. $v->mobile;
                $tmp['edu_status']  = mb_convert_encoding($v->edu_status == 1 ? '是':'否', "UTF-8", "auto");
                $tmp['phases_name'] = $v->edu_status == 1 ? '--' : mb_convert_encoding($v->phases_name, "UTF-8", "auto");
                $tmp['edu_phases_name']  = $v->edu_status == 1 ? mb_convert_encoding($v->edu_phases_name, "UTF-8", "auto") : '--';
                $tmp['sch_name'] = mb_convert_encoding($v->sch_name, "UTF-8", "auto");  
                $tmp['grade_name']  = $v->edu_status == 1 ? mb_convert_encoding($v->grade_name, "UTF-8", "auto") : '--';
                $tmp['area_name']   = mb_convert_encoding($v->city.$v->county.$v->town.$v->village, "UTF-8", "auto");
                fputcsv($handle, $tmp);  
            }
        } 

        fclose($handle);  
        $output=ob_get_clean();  
        @ob_end_clean(); 
        echo $output;  
        exit(0);
    }
    private function calcAge($birthday) {  
        $age = 0;  
        if(!empty($birthday)){  
            $age = strtotime($birthday);  
            if($age === false){  
                return 0;  
            }  
              
            list($y1,$m1,$d1) = explode("-",date("Y-m-d", $age));  
              
            list($y2,$m2,$d2) = explode("-",date("Y-m-d"), time());  
              
            $age = $y2 - $y1;  
            if((int)($m2.$d2) < (int)($m1.$d1)){  
                $age -= 1;  
            }  
        }  
        return $age;  
    }
    private function relationshipZh($relate) {  
        switch ($relate) {
            case 1: 
                return '户主';
            case 2: 
                return '配偶';
            case 3: 
                return '之子';
            case 4: 
                return '之女';
            case 5: 
                return '之儿媳';
            case 6: 
                return '之女婿';
            case 7: 
                return '之侄子';
            case 8: 
                return '之侄媳';
            case 9: 
                return '之侄女';
            case 10: 
                return '之侄女婿';
            case 11: 
                return '之孙子';
            case 12: 
                return '之孙女';
            case 13: 
                return '之外孙子';
            case 14: 
                return '之外孙女';
            case 15: 
                return '之父';
            case 16: 
                return '之母';
            case 17: 
                return '之岳父';
            case 18: 
                return '之岳母';
            case 19: 
                return '之公公';
            case 20: 
                return '之婆婆';
            case 21: 
                return '之祖父';
            case 22: 
                return '之祖母';
            case 24: 
                return '之外祖母';
            case 25: 
                return '之兄弟';
            case 26: 
                return '之兄妹';
            case 30: 
                return '其他';
            default:
              return '其他';
        }  
    }
    /* ===================================== 贫困户 end =================================================== */

    /* ===================================== 贫困户成员 begin =================================================== */
    
    /**
     * 获取贫困户家庭成员信息 by family_id
     */
    public function getMembers(Request $request, $id)
    {
        $data  = DB::select('SELECT id, family_id, year, id_code, relationship, area_id, realname, gender, profile, (birthday*86400) birthday, ethnic, mobile, edu_status, edu_phases_id, edu_records_id, posted_at, remark FROM members where family_id =? order by relationship asc', [$id]);
        if(!$data)  return response()->json($resData, 404);
        return response()->json($data, 200);
    }

    /**
     * 获取贫困户成员信息 by member_id
     */
    public function getMemberOne(Request $request, $id)
    {
        $data  = DB::select('SELECT has_neisa, d.title,m.id, family_id, year, id_code, relationship, area_id, realname, gender, profile, (birthday*86400) birthday, ethnic, mobile, edu_status, edu_phases_id, edu_records_id, m.posted_at, remark 
        FROM members m
  
        left join dropout_causes d on m.neisa_causes_id=d.id
        where m.id =?', [$id]);
        // $data[0]->age=ceil((time()-$data[0]->birthday)/3600/24/365);
        $data[0]->age=ceil((time()-$data[0]->birthday)/3600/24/365);
        if(!$data)  return response()->json([], 404);
        return response()->json($data[0], 200);
    }

    /**
     * 判断身份证是否存在，并返回相关数据
     */
    public function getIDCode(Request $request, string $id) 
    {

        // if(strlen($id) < 15) return response()->json(['code' => 'ERR_NOT_FOUND','aa'=>1], 200);
        $sql = "SELECT m.id, m.id_code, m.family_id, m.area_id, m.realname, m.gender, m.ethnic, m.mobile, m.edu_status,m.edu_phases_id, m.edu_records_id, mm.realname holder_name, a.name area_name ,
                ar.name z_name,area.name x_name
                FROM members m 
                    LEFT JOIN families f ON m.family_id = f.id
                    LEFT JOIN areas a    ON m.area_id = a.id
                    LEFT JOIN areas ar    ON a.pid = ar.id
                    LEFT JOIN areas area    ON ar.pid = area.id
                    LEFT JOIN members mm ON f.holder_id = mm.id 
                WHERE m.id_code = ?";
        $member = DB::select($sql, [$id]);
    //    return $member;
        if(!isset($member[0])) return response()->json(['code' => 'ERR_NOT_FOUND','aa'=>1], 200); //如果不存在
        if(!$member[0]->family_id) return response()->json(['data'=>$member[0],'aa'=>1], 200); //如果不存在
        return response()->json(['data'=>$member[0],'aa'=>0], 200);
    }

    /**
     * 新增贫困户成员
     */
    public function insertMember(Request $request) 
    {
        $rules = [
            'family_id'         => 'numeric',
            'area_id'           => 'required|numeric',
            'realname'          => ['required','regex:/^[\x{4e00}-\x{9fa5}\w·]{2,16}$/u'],
            'gender'            => 'required|in:1,2',
            'mobile'            => 'regex:/^1\d{10}$/',
            'ethnic'            => 'required|between:0,100',
            'edu_status'        => 'required|in:0,1',
            'relationship'      => 'between:0,50',
            'edu_phases_id'     => 'between:0,127'
        ];

        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'min'               => 'ERR_PARAM_:attribute_INVALID',
            'max'               => 'ERR_PARAM_:attribute_INVALID',
            'in'                => 'ERR_PARAM_:attribute_INVALID',
            'regex'             => 'ERR_PARAM_:attribute_INVALID',
            'between'           => 'ERR_PARAM_:attribute_INVALID',
            'numeric'           => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'family_id'         => 'FAMILYID',
            'area_id'           => 'AREAID',
            'realname'          => 'REALNAME',
            'gender'            => 'GENDER',
            'mobile'            => 'MOBILE',
            'ethnic'            => 'ETHNIC',
            'edu_status'        => 'EDUSTATUS',
            'relationship'      => 'RELATIONSHIP',
            'edu_phases_id'     => 'EDUPHASESID'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $paramstemp=(object)$request->only('edu_i','edu_y');
        $params = (object)$request->only('id_code', 'family_id', 'area_id' , 'realname', 'gender', 'mobile', 'ethnic', 'edu_status', 'relationship', 'edu_phases_id');
        $id_code = $this->validIdCard($params->id_code);
        if(!$id_code) return response()->json(['code' => 'ERR_PARAM_ID_CODE_INVALID'], 400);
        //身份证唯一性
        $icode = DB::select("SELECT id FROM members WHERE id_code=?",[$params->id_code]);
        //if($icode) return response()->json(['code' => 'ERR_MEMBER_IDCODE_EXISTS'], 400);
        $skip = strlen($params->id_code) == 15 ? 4 : 6;
        $date = substr($params->id_code, $skip, 8);
        $datetime = \DateTime::createFromFormat('Ymd', $date);
        $dtime    = $datetime->format('U');
        $params->id_code        =   $params->id_code;
        $params->birthday       =   $dtime/86400;
        $params->year           =   date('Y');
        $params->posted_at      =   time();
        $params->posted_by      =   $this->user->id;
        $params->has_neisa      =   $paramstemp->edu_i;
        $params->neisa_causes_id      =   $paramstemp->edu_y;
        if(isset($params->relationship))    $params->relationship   = $params->relationship;
        $data = json_decode(json_encode($params), true);
        if($icode){

            DB::beginTransaction();
            try {
                DB::table('members')->where('id',$icode[0]->id)->update($data);
                $data['id'] = $icode[0]->id;
                $num = DB::table('members')->where('family_id', $params->family_id)->count('id');
                DB::update('UPDATE families set members=? where id = ?', [$num, $params->family_id]);
                DB::commit();
            } catch (PDOException $ex) {
                DB::rollback();
            }
            $sql =" select mm.family_id, mm.realname holder_name,mm.id_code holder_code, m.realname, m.id_code from members m 
                        inner join families f on m.family_id = f.id
                        inner join members mm on f.holder_id = mm.id 
                    where m.id=".$data['id'];
            $find = DB::select($sql);
            if(!empty($find)) $this->createLog(2, $this->user->id, json_encode($find[0], JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
            $data['birthday'] = intval($data['birthday'] * 86400);
            return response()->json($data, 200);
        }else{

        

        DB::beginTransaction();
        try {
            $data['id'] = DB::table('members')->insertGetId($data);
            $num = DB::table('members')->where('family_id', $params->family_id)->count('id');
            DB::update('UPDATE families set members=? where id = ?', [$num, $params->family_id]);
            DB::commit();
        } catch (PDOException $ex) {
            DB::rollback();
        }
        $sql =" select mm.family_id, mm.realname holder_name,mm.id_code holder_code, m.realname, m.id_code from members m 
                    inner join families f on m.family_id = f.id
                    inner join members mm on f.holder_id = mm.id 
                where m.id=".$data['id'];
        $find = DB::select($sql);
        if(!empty($find)) $this->createLog(2, $this->user->id, json_encode($find[0], JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        $data['birthday'] = intval($data['birthday'] * 86400);
        return response()->json($data, 200);
    }
}

    /**
     * 修改贫困户成员
     */
    public function updateMember(Request $request, int $id) 
    {
        $rules = [
            'realname'          => 'regex:/^[\x{4e00}-\x{9fa5}\w·]{2,16}$/u',
            'gender'            => 'in:1,2',
            'mobile'            => 'regex:/^1\d{10}$/',
            'ethnic'            => 'between:0,100',
            'edu_status'        => 'in:0,1',
            'relationship'      => 'between:0,50',
            'edu_phases_id'     => 'between:0,127'
        ];

        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'min'               => 'ERR_PARAM_:attribute_INVALID',
            'max'               => 'ERR_PARAM_:attribute_INVALID',
            'in'                => 'ERR_PARAM_:attribute_INVALID',
            'regex'             => 'ERR_PARAM_:attribute_INVALID',
            'between'           => 'ERR_PARAM_:attribute_INVALID',
            'numeric'           => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'realname'          => 'REALNAME',
            'gender'            => 'GENDER',
            'mobile'            => 'MOBILE',
            'ethnic'            => 'ETHNIC',
            'edu_status'        => 'EDUSTATUS',
            'relationship'      => 'RELATIONSHIP',
            'edu_phases_id'     => 'EDUPHASESID'
        ];
        
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = $request->only('has_neisa','neisa_causes_id','id_code', 'realname', 'gender', 'mobile', 'ethnic', 'edu_level', 'edu_status', 'profile', 'relationship', 'edu_phases_id' ,'remark');
        $params = (object)array_filter($params, function($v){return !is_null($v);});
        if(!get_object_vars($params)) return response()->json($params, 200);
        if(isset($params->id_code) && strlen($params->id_code) >=15) {
            $id_code = $this->validIdCard($params->id_code);
            if(!$id_code) return response()->json(['code' => 'ERR_PARAM_ID_CODE_INVALID'], 400);
            //身份证唯一性
            $skip = strlen($params->id_code) == 15 ? 4 : 6;
            $date = substr($params->id_code, $skip, 8);
            $datetime = \DateTime::createFromFormat('Ymd', $date);
            $dtime    = $datetime->format('U');
            $params->id_code        = $params->id_code;
            $params->birthday       = $dtime/86400;
        }
        $data = json_decode(json_encode($params), true);
        DB::table('members')->where('id',$id)->update($data);
        $sql =" select mm.realname holder_name,mm.id_code holder_code, m.realname, m.id_code from members m 
                    inner join families f on m.family_id = f.id
                    inner join members mm on f.holder_id = mm.id 
                where m.id=".$id;
        $find = DB::select($sql);
        if(!empty($find)) {
            foreach ($params as $key => $val) {
                $find[0]->$key = $val;
            }
            $this->createLog(2, $this->user->id, json_encode($find[0], JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        }
        return response()->json($data, 200);
    }

    /**
     * 删除一个贫困户成员
     */
    public function deleteMember(Request $request, int $id)
    {
        $sql =" select mm.family_id, mm.realname holder_name,mm.id_code holder_code, m.realname, m.id_code from members m 
                    inner join families f on m.family_id = f.id
                    inner join members mm on f.holder_id = mm.id 
                where m.id={$id}";
        $find = DB::select($sql);
        if(empty($find)) return response()->json(['code' => 'ERR_NOT_FIND_RECORD'], 404);
        $flog = false;
        DB::beginTransaction();
        try {
            DB::delete('DELETE FROM members WHERE id=?', [$id]);
            $num = DB::table('members')->where('family_id',$find[0]->family_id)->count('id');
            DB::update('UPDATE families set members=? where id = ?', [$num, $find[0]->family_id]);
            DB::commit();
            $flog = true;
        } catch (PDOException $ex) {
            DB::rollback();
        }
        $this->createLog(2, $this->user->id, json_encode($find[0], JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        return response()->json([], 200);
    }

    /**
     * 获取辍学原因列表
     */
    public function getDropOut() 
    {
        $dropOut = DB::select('SELECT id, title FROM dropout_causes where id > 0 order by id');
        return response()->json($dropOut, 200);
    }

    /**
     * 获取辍学原因列表
     */
    public function insertDropOut(Request $request) 
    {
        $rules = [
            'title'     => 'required|min:2|max:32'
        ];

        $messages = [
            'required'  => 'ERR_PARAM_:attribute_REQUIRED',
            'min'       => 'ERR_PARAM_:attribute_INVALID',
            'max'       => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'title'     => 'TITLE'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = (object)$request->only('title');
        $find = DB::table('dropout_causes')->where('title', $params->title)->count();
        if($find) return response()->json(['code' => 'ERR_TITLE_EXISTS'], 400);
        $newId = DB::table('dropout_causes')->insertGetId(['title'=>$params->title, 'posted_at'=>time(), 'posted_by'=>$this->user->id]);
        $this->createLog(2, $this->user->id, json_encode($params, JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        return response()->json(['id'=>$newId], 200);
    }

    /**
     * 获取辍学原因列表
     */
    public function updateDropOut(Request $request, int $id) 
    {
        $rules = [
            'title'     => 'min:2|max:32'
        ];

        $messages = [
            'required'  => 'ERR_PARAM_:attribute_REQUIRED',
            'min'       => 'ERR_PARAM_:attribute_INVALID',
            'max'       => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'title'       => 'TITLE'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $title = $request->only('title')['title'];
        if(empty($title)) return response()->json([], 200);
        $find = DB::select("SELECT title from dropout_causes where title = ?", [$title]);
        if($find) return response()->json(['code' => 'ERR_TITLE_EXISTS'], 400);
        DB::table('dropout_causes')->where('id', $id)->update(['title' => $title]);
        $this->createLog(2, $this->user->id, json_encode(['title' => $title], JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        return response()->json([], 200);
    }

    /* ===================================== 贫困户成员 end ========================================================= */

    /* ===================================== 贫困户成员教育 begin =================================================== */

    /**
     * 获取教育阶段列表
     */
    public function getPhases()
    {
        $data = DB::select('SELECT * FROM edu_phases');
        if(!$data)  return response()->json(['code' => 'ERR_NOT_RECORDS'], 400);
        return response()->json($data, 200);
    }
    /**
     * 判断身份证是否存在，并返回相关数据
     */
    public function getStundy(Request $request, string $id) 
    {
        if(strlen($id) < 15) return response()->json(['code' => 'ERR_IDCODE_NOT_FOUND'], 404);
        $sql = "SELECT m.id, m.id_code, m.realname,m.area_id,mm.realname holder_name from members m 
                    LEFT JOIN families f on m.family_id = f.id
                    LEFT JOIN members mm on f.holder_id = mm.id where m.id_code = ?";
        $member = DB::select($sql, [$id]);
        if(count($member) == 0) return response()->json(['code' => 'ERR_IDCODE_NOT_FOUND'], 404);
        return response()->json($member, 200);
    }

    public function getEduRecords(Request $request)
    {
       
     
        $params = (object)$request->only('member_id');
        $member_id = intval($params->member_id);
        
        if($member_id <= 0) return response()->json([], 200);
        $sql = "SELECT e.* , m.name edu_major_name, s.sch_name from edu_records e 
                    LEFT JOIN edu_majors m  on e.edu_major_id = m.id 
                    LEFT JOIN schools s     on e.school_id = s.id
                    
                    WHERE  member_id=?  
                    group by e.year,e.season
                    order by e.year desc, e.phase_id desc, e.grade desc ";
                   
                   
        $records            = DB::select($sql, [$member_id]);
        
        $records_policies   = DB::select('
                                        SELECT p.id, p.title, p.funds, es.edu_record_id, e.year FROM edu_records e 
                                            LEFT JOIN edu_records_policies es ON e.id = es.edu_record_id
                                            LEFT JOIN epa_policies p          ON es.epa_policy_id = p.id
                                        WHERE e.member_id = ?', [$member_id]);
        if(!$records)       return response()->json([], 200);
        foreach ($records as $key => $val) {
            $tmpArr = [];
            $idArr  = [];
            foreach ($records_policies as $k => $v) {
                if($val->id == $v->edu_record_id) {
                    $tmpArr[$k]['id']     = $v->id;
                    $tmpArr[$k]['title']  = $v->title;
                    $tmpArr[$k]['funds']  = $v->funds;
                    $idArr[]              = $v->id;
                }   
            }
            $records[$key]->_epa_policies = $tmpArr;
            $records[$key]->epa_policies  = $idArr;
        }
        return response()->json($records, 200);
    }

    /**
     * 新增贫困户成员教育阶段
     */
    public function insertEduRecord(Request $request) 
    {
        $rules = [
            'member_id'         => 'required|numeric',
            'phase_id'          => 'required|numeric',
            'year'              => 'required|numeric',
            // 'season'            => 'required|in:1, 3',
//            'school_name'       => 'regex:/^[\x{4e00}-\x{9fa5}\w·]{2,32}$/u',

            'student_no'        => 'regex:/^[\x{4e00}-\x{9fa5}\w·]{2,24}$/u',
            // 'grade'             => 'required|numeric',
            'has_boarding'      => 'required|in:1, 2',
            'has_local'         => 'required|in:1, 2',
            'has_state'         => 'required|in:1, 2',
            'status'            => 'required|between:0, 10'
        ];

        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'in'                => 'ERR_PARAM_:attribute_INVALID',
            'regex'             => 'ERR_PARAM_:attribute_INVALID',
            'between'           => 'ERR_PARAM_:attribute_INVALID',
            'numeric'           => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'member_id'         => 'MEMBERID',
            'phase_id'          => 'PHASEID',
            'year'              => 'YEAR',
            // 'season'            => 'SEASON',
//            'school_name'       => 'SCHOOLNAME',
            'student_no'        => 'STUDENTNO',
            // 'grade'             => 'GRADE',
            'has_boarding'      => 'HASBOARDING',
            'has_local'         => 'HASLOCAL',
            'has_state'         => 'HASSTATE',
            'status'            => 'STATUS'
        ];

        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = $request->only('member_id', 'phase_id', 'year', 'season', 'school_id', 'school_name', 'student_no', 'grade', 'has_boarding', 'has_local', 'has_state', 'dropout_causes_id', 'status','has_neisa','neisa_causes_id');
        $params = (object)array_filter($params, function($v){return !is_null($v);});
        $params->posted_at       =  time();
        $params->posted_by       =  $this->user->id;
        $params->school_id       =  $params->has_local == 1 ? intval($params->school_id) : 0;
        $params->school_name     =  $params->has_local == 1 ? '' : trim($params->school_name);
        if($params->status == 5 and (!isset($params->dropout_causes_id) or $params->dropout_causes_id <= 0)) 
            return response()->json(['code' => 'ERR_PARAM_DROPOUTCAUSEID_INVALID'], 400);
        else
            $params->dropout_causes_id = 0;
        //判断家庭成方是否存在
        $find = DB::select('SELECT area_id, realname, id_code FROM members WHERE id = ?', [$params->member_id]);
        if(empty($find)) return response()->json([], 200);
        if($params->has_local == 1){
            if(!isset($params->school_id) || $params->school_id <= 0 ) return response()->json(['code' => 'ERR_PARAM_SCHOOLID_INVALID'], 400);
        }elseif($params->has_local == 2){
            if(!isset($params->school_name) || empty($params->school_name)) return response()->json(['code' => 'ERR_SCHOOL_NAME_REQUIRED'], 400);
        }
        $area_id         = $find[0]->area_id;
        $data            = json_decode(json_encode($params), true);
        $data['area_id'] = $area_id;
        $epa_policies = $request->only('epa_policies')['epa_policies'];
        $flog = false;
        DB::beginTransaction();
        try {
            $newId  = DB::table('edu_records')->insertGetId($data);
            if(count($epa_policies) > 0){
                $sql = '';
                foreach ($epa_policies as $key => $val) {
                    if(($val = intval($val)) > 0) {
                        $sql .= empty($sql) ? "({$newId}, {$val}, {$area_id})":",({$newId}, {$val}, {$area_id})";
                    }
                }
                $sql = 'INSERT INTO edu_records_policies (edu_record_id, epa_policy_id, area_id) VALUES '.$sql;
                DB::insert($sql);
            }
            DB::commit();
            $flog = true;
        } catch (PDOException $ex) {
            DB::rollback();
        }
        if(!$flog) response()->json([], 500);
        $record = $this->getEduRecord($newId);
        $find[0]->school_name= $params->school_name;
        $find[0]->phase_id   = $params->phase_id;
        $find[0]->grade      = $params->grade;
        unset($find[0]->area_id);
        $this->createLog(2, $this->user->id, json_encode($find[0], JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        return response()->json($record, 200);
    }

    /**
     * 修改贫困户成员教育阶段
     */
    public function updateEduRecord(Request $request, int $id) 
    {
        $rules = [
            'member_id'         => 'numeric',
            'phase_id'          => 'numeric',
            'year'              => 'numeric',
            'season'            => 'numeric',
//            'school_name'       => 'regex:/^[\x{4e00}-\x{9fa5}\w·]{2,32}$/u',
            'student_no'        => 'regex:/^[\x{4e00}-\x{9fa5}\w·]{2,24}$/u',
            'grade'             => 'numeric',
            'has_boarding'      => 'in:1, 2',
            'has_local'         => 'required|in:1, 2',
            'has_state'         => 'in:1, 2',
            'dropout_causes_id'  => 'numeric',
            'status'            => 'between:0, 10'
        ];

        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'in'                => 'ERR_PARAM_:attribute_INVALID',
            'regex'             => 'ERR_PARAM_:attribute_INVALID',
            'between'           => 'ERR_PARAM_:attribute_INVALID',
            'numeric'           => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'member_id'         => 'MEMBERID',
            'phase_id'          => 'PHASEID',
            'year'              => 'YEAR',
            'season'            => 'SEASON',
//            'school_name'       => 'SCHOOLNAME',
            'student_no'        => 'STUDENTNO',
            'grade'             => 'GRADE',
            'has_boarding'      => 'HASBOARDING',
            'has_local'         => 'HASLOCAL',
            'has_state'         => 'HASSTATE',
            'dropout_causes_id'  => 'DROPOUTCAUSEID',
            'status'            => 'STATUS'
        ];

        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }

        $params = $request->only('member_id', 'phase_id', 'year',  'season', 'school_id','school_name', 'student_no', 'grade', 'has_boarding', 'has_local', 'has_state', 'dropout_causes_id', 'status');
        $params = (object)array_filter($params, function($v){return !is_null($v);});
        if(isset($params->status) and $params->status == 5 and (!isset($params->dropout_causes_id) or $params->dropout_causes_id <= 0)) 
            return response()->json(['code' => 'ERR_PARAM_DROPOUTCAUSEID_INVALID'], 400);

        //判断家庭成方是否存在
        $find = DB::select('SELECT r.area_id, r.member_id, m.realname, m.id_code, school_id, school_name, has_local FROM edu_records r left join members m on r.member_id = m.id WHERE r.id = ?', [$id]);
        if(empty($find)) return response()->json(['code' => 'ERR_MEMBER_NOT_EXISTS'], 400);
        $params->member_id      = $find[0]->member_id;
        $area_id                = $find[0]->area_id;
        if($params->has_local == 1){
            // if($params->has_local == $find[0]->has_local){
            //     if(isset($params->school_id) && $params->school_id > 0) {
            //         $params->school_id      = $params->school_id;
            //         $params->school_name    = '';
            //     }
            //     unset($params->has_local);
            // }elseif($params->has_local != $find[0]->has_local){
            //     if(!isset($params->school_name) || empty($params->school_name)) return response()->json(['code' => 'ERR_SCHOOL_NAME_REQUIRED'], 400);
            //     else {
            //         $params->school_id      = 0;
            //         $params->school_name    = trim($params->school_name);
            //         $params->has_local      = $params->has_local;
            //     }
            // }
            $params->school_id      = $params->school_id;
            $params->school_name    = '';
        }elseif($params->has_local == 2){
            // if($params->has_local == $find[0]->has_local){
            //     if(isset($params->school_name) && !empty($params->school_name)) {
            //         $params->school_id      = 0;
            //         $params->school_name    = $params->school_name;
            //     }
            //     unset($params->has_local);
            // }elseif($params->has_local != $find[0]->has_local){
            //     if(!isset($params->school_id) || $params->school_id <= 0) return response()->json(['code' => 'ERR_SCHOOL_ID_REQUIRED'], 400);
            //     else {
            //         $params->school_id      = $params->school_id;
            //         $params->school_name    = '';
            //         $params->has_local      = $params->has_local;
            //     }
            // }
            $params->school_id      = 0;
            $params->school_name    = $params->school_name;
        }
        $data               = json_decode(json_encode($params), true);
        $epa_policies       = $request->only('epa_policies')['epa_policies'];

        DB::beginTransaction();
        try {
            DB::table('edu_records')->where('id', $id)->update($data);
            if(count($epa_policies) > 0){
                DB::table('edu_records_policies')->where('edu_record_id', $id)->delete();
                $sql = '';
                foreach ($epa_policies as $key => $val) {
                    if(($val = intval($val)) > 0) {
                        $sql .= empty($sql) ? "({$id}, {$val}, {$area_id})" : ",({$id}, {$val}, {$area_id})";
                    }
                }
                $sql = 'INSERT INTO edu_records_policies (edu_record_id, epa_policy_id, area_id) VALUES '.$sql;
                DB::insert($sql);
            }
            DB::commit();
            $flog = true;
        } catch (PDOException $ex) {
            DB::rollback();
        }
        if(!$flog) response()->json([], 200);
        $record = $this->getEduRecord($id);
        $params->realname = $find[0]->realname;
        $params->id_code  = $find[0]->id_code;
        $this->createLog(2, $this->user->id, json_encode($params, JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        return response()->json($record, 200);
    }

    /**
     * 删除贫困户成员教育阶段
     */
    public function deleteEduRecord(Request $request, int $id) 
    {
        $find = DB::select('SELECT m.realname, m.id_code, r.phase_id, r.school_name, r.grade from edu_records r left join members m on r.member_id = m.id where r.id = ?',[$id]);
        if(empty($find)) return response()->json([], 404);
        DB::beginTransaction();
        try {
            DB::table('edu_records')->where('id', $id)->delete();
            DB::table('edu_records_policies')->where('edu_record_id', $id)->delete();
            DB::commit();
        } catch (PDOException $ex) {
            DB::rollback();
        }
        $this->createLog(2, $this->user->id, json_encode($find[0], JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        return response()->json([], 200);
    }

    public function getEduRecordOne(Request $request, int $id)
    {
        
        $record = DB::select('SELECT e.*, s.sch_name FROM edu_records e LEFT JOIN schools s ON e.school_id = s.id WHERE e.id =?', [$id]);
        
        if(empty($record)) return response()->json([], 404);
        $find = $record[0];
        $records_policies   = DB::select('
                                        SELECT p.id, p.title, p.funds, es.edu_record_id, e.year FROM edu_records e 
                                            LEFT JOIN edu_records_policies es ON e.id = es.edu_record_id
                                            LEFT JOIN epa_policies p          ON es.epa_policy_id = p.id
                                        WHERE es.edu_record_id = ?', [$find->id]);
        $tmpArr = [];
        $idArr  = [];
        foreach ($records_policies as $k => $v) {
            if($find->id == $v->edu_record_id) {
                $tmpArr[$k]['id']     = $v->id;
                $tmpArr[$k]['title']  = $v->title;
                $tmpArr[$k]['funds']  = $v->funds;
                $idArr[]              = $v->id;
            }   
        }
        $find->_epa_policies = $tmpArr;
        $find->epa_policies  = $idArr;
      
        return response()->json($find, 200);
    }

    public function getEduRecord(int $id)
    {
        if($id <= 0) return false;
        $record = DB::select('SELECT e.*, s.sch_name FROM edu_records e LEFT JOIN schools s ON e.school_id = s.id WHERE e.id =?', [$id]);
        $policy = DB::select('SELECT p.id,p.title,p.funds FROM edu_records_policies ep inner join epa_policies p on ep.epa_policy_id = p.id WHERE ep.edu_record_id = ?', [$id]);
        if($record) {
            $tmp = [];
            foreach ($policy as $key => $val) {
                 $tmp[] = $val->id;
            }
            $record[0]->epa_policies    = $tmp;
            $record[0]->_epa_policies   = $policy;
            return $record[0];
        }
        return false;
    }

    public function getMajors(Request $request)
    {
        $data = DB::select("SELECT * FROM edu_majors");
        return response()->json($data, 200);
    }

    public function getVes(Request $request)
    {
        $params = (object)$request->only('member_id');
        $data   = DB::select('SELECT * FROM edu_ves WHERE member_id = ?', [$params->member_id]);
        return response()->json($data, 200);
    }

    public function getSchools(Request $request)
    {
        $params = (object)$request->only('keywords');
        $vWhere = "%{$params->keywords}%";
        $data   = DB::select('SELECT id,sch_name,sch_province,sch_city, sch_county FROM schools WHERE (sch_name like ? or first_letters like ? or full_letters like ?) limit 30 ', [$vWhere,$vWhere,$vWhere]);
        return response()->json($data, 200);
    }
    public function getSchoolOne(Request $request, $id)
    {
        $data = DB::select('SELECT * FROM schools WHERE id = ?', [$id]);
        $data = empty($data) ? [] : $data[0];
        return response()->json($data, 200);
    }
    public function getSchoolList(Request $request,$id)
    {
//        return $id;
//        $fname = 'db_'.date('ymd').'.txt';
//        $data = $this->areaFile($fname, $id);
//
//        if(strlen($data) < 100){
//            $data=DB::select('SELECT * FROM schools WHERE find_in_set(?,sch_type_id)',[$id]);
//            $data = empty($data) ? [] : $data;
//            $this->writeFile($data, $id);
//            return response()->json($data, 200);
//        }
//
//        else{
//
//            $data = json_decode($data, true);
//            return response()->json($data, 200);
//        }

        $data=DB::select('SELECT * FROM schools WHERE find_in_set(?,sch_type_id)',[$id]);
        //return $data;
        $data = empty($data) ? [] : $data;
        return response()->json($data, 200);
    }

    public function areaFile($fname, $area_id)
    {
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'/files/schools/areas_'.$area_id;

        $file       = $dir.'/'.$fname;
//        return $file;
        if(is_file($file)) {
            $hfile  = fopen($file, "r");
            $data   = fread($hfile, 1000000);
            fclose($hfile);
            return $data;
        }
        return false;
    }

    public function writeFile($data, $area_id)
    {
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'/files/schools/areas_'.$area_id;
        $file       = $dir.'/db_'.date('ymd').'.txt';
        if(!is_dir($dir)) $this->mkdirs($dir);
        $file = fopen($file, "w");
        $flog = fwrite( $file, json_encode($data));
        fclose($file);
        return $flog;
    }


    public function getSchoolAll(Request $request)
    {

        $fname = 'db_'.date('ymd').'.txt';
        $data = $this->areaFile($fname, 1);

        if(strlen($data) < 100){
            $sql="SELECT * FROM schools";
            $data = DB::select($sql);
            $this->writeFile($data, 1);
            return $data;
        }

        else{
            return $data;
            $data = json_decode($data, true);
            return response()->json($data, 200);
        }

    }


    public function insertVes(Request $request)
    {
        $rules = [
            'member_id'         => 'required|numeric',
            'edu_major_id'      => 'required|numeric',
            'collected_at'      => 'required'
        ];

        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'numeric'           => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'member_id'         => 'MEMBERID',
            'edu_major_id'      => 'EDUMAJORSID',
            'collected_at'      => 'COLLECTEDAT'
        ];

        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params         = (object)$request->only('member_id', 'edu_major_id', 'collected_at');
        $find           = DB::table('edu_ves')->where(['edu_major_id'=>$params->edu_major_id, 'member_id'=>$params->member_id])->count();
        if($find)       return response()->json([], 409);
        $params->collected_at = strtotime($params->collected_at);
        $data           = json_decode(json_encode($params), true);
        $params->id     = DB::table('edu_ves')->insertGetId($data);
        $sql            = " select m.realname, m.id_code, j.`name` major_name, v.collected_at from edu_ves v 
                                inner join members m on v.member_id = m.id
                                inner join edu_majors j on v.edu_major_id = j.id
                            where v.id = {$params->id}";
        $data           = DB::select($sql);
        if(!empty($data)) $this->createLog(2, $this->user->id, json_encode($data[0], JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        return response()->json($params, 200);
    }

    public function deleteVes(Request $request, int $id)
    {
        $sql            = " select m.realname, m.id_code, j.`name` major_name, v.collected_at from edu_ves v 
                                inner join members m on v.member_id = m.id
                                inner join edu_majors j on v.edu_major_id = j.id
                            where v.id = {$id}";
        $data           = DB::select($sql);
        if(empty($data)) response()->json([], 404);
        DB::table("edu_ves")->where('id', $id)->delete();
        $this->createLog(2, $this->user->id, json_encode($data[0], JSON_UNESCAPED_UNICODE),'Epa@'.__FUNCTION__);
        return response()->json([], 200);
    }
    /* ===================================== 贫困户成员教育 end =================================================== */
}
