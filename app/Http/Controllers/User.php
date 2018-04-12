<?php 
namespace App\Http\Controllers;
use Validator;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Firebase\JWT\JWT;
use App\Http\Controllers\Controller;

class User extends Controller
{
    protected $user;

    public function __construct()
    {
        $this->user = app('user');
        
    }

    /**
     * 修改个人密码
     */
    public function setPassword(Request $request)
    {
        $rules = [
            'password'      => 'required',
            'smic'          => 'required|numeric'
        ];

        $messages = [
            'required'      => 'ERR_PARAM_:attribute_REQUIRED',
            'numeric'       => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'password'      => 'PASSWORD',
            'smic'          => 'SMIC'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = (object)$request->only('password', 'smic');
        $userInfo = DB::select('SELECT mobile FROM users WHERE id=?', [$this->user->id]);
        if(empty($userInfo)) response()->json(['code' => 'ERR_MOBILE_NOT_EXISTS'], 400);
        $verfy = $this->readfile($userInfo[0]->mobile);
        $ctime = time() - $verfy->utime;

        if(!$verfy ||  $ctime > 600 || $verfy->code != $params->smic) return response()->json(['code' => 'ERR_PARAM_SMIC_INVALID'], 400);
        $arr['password'] = Hash::make($params->password);
        $flog = DB::table('users')->where('id', $this->user->id)->update($arr);
        $code = $flog ? 200 : 500;  
        $msg = "您新密码{$params->password}已发送到您手机，请查看您的手机短信！如果非本人操作，请尽快修改平台登录密码，此服务免费。";
        $this->sendSMS($userInfo[0]->mobile, $msg);
        return response()->json([], $code);
    }


    /**
     * 修改个人信息
     */
    public function setInfo(Request $request)
    {
        $rules = [
            'realname'  => '',
            'gender'    => 'in:1,2',
            'email'     => 'email|max:128'
        ];

        $messages = [
            'in'       => 'ERR_PARAM_:attribute_INVALID',
            'email'    => 'ERR_PARAM_:attribute_INVALID',
            'max'      => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'realname'  => 'REALNAME',
            'gender'    => 'GENDER',
            'email'     => 'EMAIL'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $arr = $request->only('realname','gender', 'email');
        $data = array_filter($arr, function($v){return !is_null($v);});
        if(count($data) == 0) return response()->json([], 200);
        $tmp    = DB::table('users')
                ->where('id', $this->user->id)
                ->update($data);
         return response()->json([], 200);
    }

    public function getInfo()
    {
        
        $info = DB::select('SELECT id,realname,gender,mobile,email FROM users where id = ?', [$this->user->id]);
        return response()->json($info[0], 200);
    }

    /**
     * 检测手机号存在
     */
    public function getMobile(Request $request, string $id) 
    {
        $find = DB::select('SELECT id FROM users WHERE mobile = ?', [$id]);
        // if($find) return response()->json(['code' => 'ERR_USER_MOBILE_EXISTS'], 404);
        // return response()->json([], 200);
        return $find 
        ? response()->json(current($find), 200)
        : response()->json(['code'=>'ERR_MOBILE_NOT_EXISTS'], 404);
    }

    /**
     * 提交修改个人手机号
     */
    public function setMobile(Request $request) 
    {
        $rules = [
            'mobile'    => ['required', 'regex:/^1\d{10}$/'],
            'smic'      => 'required|numeric'
        ];

        $messages = [
            'required'  => 'ERR_PARAM_:attribute_REQUIRED',
            'regex'     => 'ERR_PARAM_:attribute_INVALID',
            'numeric'   => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'mobile'    => 'MOBILE',
            'smic'     => 'SMIC'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $arr    = $request->only('mobile', 'smic');
        $find   = DB::table('users')->where('mobile', $arr['mobile'])->count();
        if($find) return response()->json(['code' => 'ERR_MOBILE_EXISTS'], 400);
        $code   = $this->findFile($arr['mobile']);
        if($code == $arr['smic']) {
            DB::table('users')->where('id', $this->user->id)->update(['mobile'=>$arr['mobile']]);
            return response()->json([], 200);
        }else{
             return response()->json(['code' => 'ERR_PARAM_SMIC_INVALID'], 400);
        }
    }

    public function getUsers(Request $request) 
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
        //整合查询条件
        $area_id = $this->user->areas[0]->id;
        $parea_id = intval($params->area_id);
        if(intval($params->area_id) > 0) $area_id = intval($params->area_id);
        $area = (object)$this->getAreasRange($area_id);
        $where  = "a.oid between ? and ?";
        $wValue = [$area->_skip, $area->_limit];
        if(!empty($params->keywords)) {
            $keywords = trim($params->keywords);
            $keywords = mb_substr($keywords, 0, 18, 'utf-8');
            $where   .= " and (u.realname like ? OR u.mobile like ? )";
            $wValue[] = "%{$params->keywords}%";
            $wValue[] = "%{$params->keywords}%";
        } 
        //获取贫困户列表
      
        $sql = "SELECT count(1) jcount FROM users u 
                    LEFT JOIN rbac_grants g ON u.id = g.user_id
                    LEFT JOIN areas a       ON g.area_id = a.id 
                WHERE ".$where." group by g.area_id, g.user_id ";
        //获取总条数
        $total = DB::select($sql, $wValue);
        if(!$total) return response()->json(['total'=>0,'data'=>[]], 200);
        $fields = "u.id, a.id area_id, a.name area_name, u.status, u.realname, u.gender, u.mobile, u.email, u.posted_at";
        $sql    = " SELECT {$fields} FROM users u 
                    LEFT JOIN rbac_grants g ON u.id = g.user_id
                    LEFT JOIN areas a       ON g.area_id = a.id 
                WHERE ".$where." group by g.area_id, g.user_id limit {$params->skip} , {$params->limit}";
        $data   = DB::select($sql, $wValue);
        $data   = $this->getGranTasks($data);
        $data   = array(
                        'total' => count($total),
                        'data'  => $data);
        return response()->json($data, 200);
    }

    public function getGranTasks($data)
    {
        $sql = '';
        if(isset($data[0])){
            foreach ($data as $k => $v) {
                $sql .= empty($sql) ? '' : ' union all ';
                $sql .= "SELECT task_id, user_id, area_id from rbac_grants where user_id = {$v->id} and area_id = {$v->area_id}";
            }
            $task = DB::select($sql);
            foreach ($data as $key => $val) {
                $tmp = [];
                foreach ($task as $k => $v) {
                    if($val->id == $v->user_id && $val->area_id == $v->area_id) {
                        $tmp[] = $v->task_id;
                    }
                }
                $data[$key]->tasks = $tmp;
            }
            return $data;
        }
        return array();
    }

    /**
     * 按手机号获取单条账号
     */
    public function getUsersOne(Request $request)
    {   
        $rules = [
            'mobile'            => ['required', 'regex:/^1\d{10}$/']
        ];

        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'regex'             => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'mobile'            => 'MOBILE'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = (object)$request->only('mobile');
        $find = DB::select('select id, realname, gender, mobile, email from users where mobile = ?', [$params->mobile]);
        return response()->json($find, 200);
    }
    /**
     * 新增一个账号
     */
    public function insertUser(Request $request) 
    {
        $rules = [
            'realname'          => ['required', 'regex:/^[\x{4e00}-\x{9fa5}\w·]{2,16}$/u'],
            'gender'            => 'required|min:1|max:2',
            'mobile'            => ['required', 'regex:/^1\d{10}$/'],
            'email'             => ['required', 'regex:/^([\w_-])+@([\w_-])+(.[\w_-])+/']
        ];

        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'min'               => 'ERR_PARAM_:attribute_INVALID',
            'max'               => 'ERR_PARAM_:attribute_INVALID',
            'regex'             => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'realname'          => 'REALNAME',
            'gender'            => 'GENDER',
            'mobile'            => 'MOBILE',
            'email'             => 'EMAIL'
        ];

        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = (object)$request->only('realname', 'gender', 'mobile', 'email');
        //判断贫困户表是否有户主的ID
        $find = DB::select('SELECT 1 from users where mobile = ?', [$params->mobile]);
        if($find) return response()->json(['code' => 'ERR_MOBILE_EXISTS'], 400);
        $params->posted_by = $this->user->id;
        $params->password  = Hash::make('666666');
        $params->posted_at = time();
        $data = json_decode(json_encode($params), true);
        //插入贫困户数据
        $newId = DB::table('users')->insertGetId($data);
        $data['id'] = $newId;
        //修改户主贫困户成员表户ID
        return response()->json(['id'=>$newId], 200);
    }

    public function updatePassword(Request $request, int $id) 
    {
        $find = DB::select('SELECT mobile from users where id=?',[$id]);
        if(empty($find)) response()->json([], 404);
        $arr['password'] = Hash::make('666666');
        DB::table('users')->where('id', $id)->update($arr);
        $msg = "您新密码666666已发送到您手机，请查看您的手机短信！如果非本人操作，请尽快修改平台登录密码，此服务免费。";
        $this->sendSMS($find[0]->mobile, $msg);
        return response()->json([], 200);
    }
}
