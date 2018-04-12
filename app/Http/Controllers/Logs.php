<?php 
namespace App\Http\Controllers;
use Validator;
//use Illuminate\Support\Facades\Validator;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Firebase\JWT\JWT;

class Logs extends Controller
{
	protected $user;

    public function __construct()
    {
        $this->user = app('user');
    }

    /**
     * 获取文章列表
     */
    public function getLogs(Request $request)
    {
        
        $rules = [
            'skip'          => 'required|numeric',
            'limit'         => 'required|numeric',
            'area_id'       => 'required',
            'category_id'   => 'required',
            'keywords'      => ''
        ];

        $messages = [
            'required'      => 'ERR_PARAM_:attribute_REQUIRED',
            'regex'         => 'ERR_PARAM_:attribute_INVALID',
            'numeric'       => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'skip'          => 'SKIP',
            'limit'         => 'LIMIT',
            'area_id'       => 'AREAID',
            'category_id'   => 'COTEGORYID',
            'keywords'      => 'KEYWORDS'
        ];

        $validator  = Validator::make($request->all(), $rules, $messages, $attributes);


        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }

        $params     = $request->only('keywords', 'skip', 'limit', 'area_id', 'category_id');

        $params     = (object)array_filter($params, function($v){return !is_null($v);});
        // $params->category_id=1;


        $area = (object)$this->getAreasRange(intval($params->area_id));

        //整合查询条件
        $where      = " a.oid between {$area->_skip} and {$area->_limit} and category_id={$params->category_id} ";
//        return $where;
//        $where      = " a.oid between 1 and 10 and category_id=1 ";
        $wValue     = [];
        $keywords   = trim($params->keywords);
        if(!empty($keywords)) {
            $keywords = mb_substr($keywords, 0, 18, 'utf-8');
            $where   .= " and ll.log like  "."'".$keywords."'";
//            $wValue[] = "%{$params->keywords}%";
        }
    

        $sqlc = "select count(1) jcount from logs ll 
                    left join users u on ll.user_id = u.id 
                    left join rbac_grants r on u.id = r.user_id
                    left join rbac_actions ra on ll.action_id = ra.id 
                    left join areas a on r.area_id = a.id
                WHERE ".$where.' group by ll.id ';
        //获取总条数
    //    return $sqlc;
        $total = DB::select($sqlc);
//        return $total;
        if(!$total) return response()->json(['total' =>0, 'data'=>[]], 200);
        //获取贫困户列表
        // return $wValue;
        $sqld = "select ll.id, ll.category_id, u.realname, ll.action_id, ll.log, ll.str_json, a.name area_name, ra.`name` action_name, ll.posted_at from logs ll 
                    left join users u on ll.user_id = u.id 
                    left join rbac_grants r on u.id = r.user_id
                    left join rbac_actions ra on ll.action_id = ra.id 
                    left join areas a on r.area_id = a.id
                where ".$where." group by ll.id order by ll.id desc limit ".$params->skip." , ".$params->limit;
        
        
        $data   = DB::select($sqld, $wValue);

        $data   = array(
                        'total' => count($total),
                        'data'  => $data);
        return response()->json($data, 200);
    }

    public function getLogOne(Request $request)
    {
                                      
    }
}
