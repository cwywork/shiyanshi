<?php 
namespace App\Http\Controllers;
use Validator;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Firebase\JWT\JWT;

class Policy extends Controller
{
    protected $user;

    public function __construct()
    {
        $this->user = app('user');
    }

	public function getPolicies(Request $request)
    {
		$rules = [
            'area_id'           => 'required|numeric',
            'skip'              => 'required|numeric',
            'limit'             => 'required|numeric',
            'keywords'          => ''
        ];

        $messages = [
            'required'  => 'ERR_PARAM_:attribute_REQUIRED',
            'regex'     => 'ERR_PARAM_:attribute_INVALID',
            'numeric'   => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'area_id'      => 'AREAID',
            'skip'         => 'SKIP',
            'limit'        => 'LIMIT',
            'keywords'     => 'KEYWORDS'
        ];

        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }

        $params = $request->only('keywords', 'skip' , 'limit', 'area_id');
        $params = (object)array_filter($params, function($v){return !is_null($v);});
        
        //整合查询条件
        $area_id = $this->user->areas[0]->id;
        $parea_id = intval($params->area_id);
        if(intval($params->area_id) > 0) $area_id = intval($params->area_id);
        $area = (object)$this->getAreasRange($area_id);
        $where  = "a.oid between ? and ?";
        $wValue = [$area->_skip, $area->_limit];
        $params->keywords = trim($params->keywords);
        if(!empty($params->keywords)) {
            $keywords = trim($params->keywords);
            $keywords = mb_substr($keywords, 0, 18, 'utf-8');
            $where   .= " and ep.title like ? ";
            $wValue[] = "%{$params->keywords}%";
        }
        $sqlc = "SELECT count(ep.id) jcount FROM epa_policies ep 
                    LEFT JOIN areas a ON ep.area_id = a.id 
                    LEFT JOIN users u ON ep.posted_by = a.id
                WHERE ".$where.' group by ep.id';
        //获取总条数
        $total = DB::select($sqlc, $wValue);
        if(!isset($total[0])) return response()->json(['total' =>0, 'data'=>[]], 200);
        //获取贫困户列表
        $sqld = "SELECT ep.*, u.realname, a.`name` area_name FROM epa_policies ep
                    LEFT JOIN areas a ON ep.area_id = a.id 
                    LEFT JOIN users u ON ep.posted_by = a.id
                WHERE ".$where." group by ep.id order by ep.id desc limit ".$params->skip." , ".$params->limit;
        $data   = DB::select($sqld, $wValue);
        $data   = array(
                        'total' => count(json_decode(json_encode($total), true)),
                        'data'  => $data);
        return response()->json($data, 200);
	}

    public function getPolicyOne(Request $request, int $id)
    {
        $record = $this->getPolicy($id);
        if(!$record[0]) return response()->json([], 404);
        return response()->json($record[0], 200);
    }
   /**
     * 新增一条扶贫政策
     */
    public function insertPolicy(Request $request) 
    {
        $rules = [
            'title'         => 'required',
            'content'       => '',
            'funds'         => 'required|numeric',
            'area_id'       => 'required|numeric'
        ];

        $messages = [
            'required'  => 'ERR_PARAM_:attribute_REQUIRED',
            'regex'     => 'ERR_PARAM_:attribute_INVALID',
            'numeric'   => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'title'         => 'TITLE',
            'content'       => 'CONTENT',
            'funds'         => 'FUNDS',
            'area_id'       => 'AREAID'
        ];

        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = (object)$request->only('title', 'content', 'funds', 'area_id');
        $params->posted_at       =  time();
        $params->posted_by       =  $this->user->id;
        $params->funds           =  floatval($params->funds);
        $params->content         =  empty($params->content) ? '' : $params->content;
        //判断家庭成方是否存在
        $data   = json_decode(json_encode($params), true);
        $epa_policies = $request->only('phases')['phases'];
        DB::beginTransaction();
        try {
            $newId  = DB::table('epa_policies')->insertGetId($data);
            if(count($epa_policies) > 0 ){
                $sql = '';
                foreach ($epa_policies as $key => $val) {
                    if(intval($val) > 0) {
                        $sql .= empty($sql) ? "({$newId},{$val})":",({$newId},{$val})";
                    }
                }
                $sql = 'INSERT INTO epa_policies_phases (epa_policy_id, edu_phase_id) VALUES '.$sql;            
                DB::insert($sql);
            }
            DB::commit();
            $flog = true;
        } catch (PDOException $ex) {
            DB::rollback();
        }
        $record = $this->getPolicy($newId);
        return response()->json($record[0], 200);
    }

    /**
     * 修改一条扶贫政策
     */
    public function updatePolicy(Request $request, int $id) 
    {
        $rules = [
            'status'        => 'in:1,2',
            'title'         => '',
            'content'       => '',
            'funds'         => 'numeric',
            'area_id'       => 'numeric'
        ];

        $messages = [
            'required'      => 'ERR_PARAM_:attribute_REQUIRED',
            'regex'         => 'ERR_PARAM_:attribute_INVALID',
            'in'            => 'ERR_PARAM_:attribute_INVALID',
            'numeric'       => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'status'        => 'STATUS',
            'title'         => 'TITLE',
            'content'       => 'CONTENT',
            'funds'         => 'FUNDS',
            'area_id'       => 'AREAID'
        ];

        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = $request->only('status','title', 'content', 'funds', 'area_id');
        $params = (object)array_filter($params, function($v){return !is_null($v);});
        //判断政策是否存在
        $find = DB::table('epa_policies')->where('id', $id)->count();
        if(!$find) return response()->json(['code' => 'ERR_POLICY_NOT_EXISTS'], 404);
        $data   = json_decode(json_encode($params), true);
        $phases = $request->only('phases')['phases'];
        DB::beginTransaction();
        try {
            if(!empty($data)) DB::table('epa_policies')->where('id', $id)->update($data);
            if(count($phases) > 0) {
                DB::table('epa_policies_phases')->where('epa_policy_id', $id)->delete();
                $sql = '';
                foreach ($phases as $key => $val) {
                    if(intval($val) > 0) {
                        $sql .= empty($sql) ? "({$id},{$val})" : ",({$id},{$val})";
                    }
                }
                $sql = 'INSERT INTO epa_policies_phases (epa_policy_id,edu_phase_id) VALUES '.$sql;            
                DB::insert($sql);
            }
            DB::commit();
        } catch (PDOException $ex) {
            DB::rollback();
        }
        $record = $this->getPolicy($id);
        return response()->json($record[0], 200);
    }

    /**
     * 删除一条扶贫政策
     */
    public function deletePolicy(Request $request, int $id) 
    {
        $flog = false;
        DB::beginTransaction();
        try {
            DB::table('epa_policies')->where('id', $id)->delete();
            DB::table('epa_policies_phases')->where('epa_policy_id', $id)->delete();
            DB::commit();
            $flog = true;
        } catch (PDOException $ex) {
            DB::rollback();
        }
        $code   = $flog ? 200 : 500;
        return response()->json([], $code);
    }

    public function getPolicy(int $id)
    {
        if($id <= 0) return false;
        $policies   = DB::select('SELECT * FROM epa_policies WHERE id =?', [$id]);
        $phases     = DB::select('SELECT * FROM epa_policies_phases WHERE epa_policy_id = ?', [$id]);
        if($policies) {
            $arr = [];
            foreach ($phases as $k => $v) {
                $arr[] = $v->edu_phase_id; 
            }
            $policies[0]->phases = $arr;
            return $policies;
        }
        return false;
    }


    public function getByPhasesPolicy(Request $request, int $id) 
    {
        $params = $request->only('areas');
        $area_ids = explode(',', $params['areas']);
        $area_str = '';
        if(count($area_ids) > 0){
            foreach ($area_ids as $k => $v) {
                if(intval($v) > 0){
                    $area_str .= empty($area_str) ? '':' or ';
                    $area_str .= " c.area_id={$v} ";
                }
            }
            $area_str = empty($area_str) ? '': " and ({$area_str})";
        }
        $sql = "select DISTINCT(c.id) id, c.title from epa_policies_phases ep 
                    left join edu_phases p on ep.edu_phase_id=p.id 
                    left join epa_policies c on ep.epa_policy_id = c.id 
                where p.id = {$id} {$area_str} and title is not null";
                // return $sql;
        $data = DB::select($sql);
        return response()->json($data, 200);
    }

    /**
     * 通过record id 获取政策记录
     */
    public function getByRecordPolicies(Request $request, int $id)
    {
        $sql = "select * from edu_records_policies rp left join epa_policies p on rp.epa_policy_id = p.id where rp.edu_record_id = ?";
        $data = DB::select($sql, [$id]);
        return response()->json($data, 200);
    }
}
