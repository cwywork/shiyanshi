<?php
/**
* @name karren
* @author 金蟾软件(www.w3cyun.com)
*/
namespace App\Http\Controllers;
use Validator;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Firebase\JWT\JWT;

class Passport extends Controller
{
    public $user;
    public function __construct()
    {
        $this->user = app('user');
    }
    
	public function signin (Request $request)
	{
        #return $request;
       
		$rules = [
            'mobile' 	=> ['required', 'regex:/^1\d{10}$/'],
            'password' 	=> 'required_without:smic|min:6|max:32',
            'smic'      => 'required_without:password|numeric'
        ];

        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'min'               => 'ERR_PARAM_:attribute_INVALID',
            'max'               => 'ERR_PARAM_:attribute_INVALID',
            'required_without'  => 'ERR_PARAM_:attribute_REQUIRED',
            'regex'             => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'mobile'    => 'MOBILE',
            'password'  => 'PASSWORD',
            'smic'      => 'SMIC'
        ];
        
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = $request->only('mobile', 'password','smic');
        $params = array_filter($params);
        //登录
        $users = DB::table('users')->where('mobile', $params['mobile'])->first();
        if(!$users) 
        return response()->json(['code' =>'ERR_MOBILE_NOT_EXIST'], 400);
        $flag = false;
        if(isset($params['password']) && strlen($params['password']) >= 4){
            if(!Hash::check($params['password'], $users->password)) 
            return response()->json(['code' =>'ERR_PASSWORD_INVALID'], 400);
            $flag = true;
        }elseif(isset($params['smic']) && strlen($params['smic']) == 4) {
            $verfy = $this->readFile($params['mobile']);
            $ctime = time() - $verfy->utime;
            if(!$verfy || $verfy->code != $params['smic'])
            return response()->json(['code' => 'ERR_SMIC_INVALID'], 400);
            $flag = true;
        }
        if(!$flag) return response()->json(['code' =>'ERR_LOGIN_FAILED'], 400);    
    
        //获取用户权限
        $sql = "SELECT distinct(a.id) id, a.oid, a.name, a.level from rbac_grants rg 
                    LEFT JOIN areas a on rg.area_id = a.id 
                WHERE rg.user_id={$users->id} order by rg.area_id asc ";
        $data  = DB::select($sql);
        $sql = '';
        foreach ($data as $key => $val) {
            if($val->id > 0){
                $sql = "SELECT rs.alias FROM rbac_grants rg 
                            LEFT JOIN rbac_tasks rs on rg.task_id = rs.id 
                        WHERE rg.area_id={$val->id} and rg.user_id={$users->id}"; 
                    $tasks = DB::select($sql);
                    $tmp = [];
                    foreach ($tasks as $k => $v) {
                        $tmp[] = $v->alias;
                    }
                $data[$key]->tasks = $tmp;
            }
        }
        if(count($data) > 0){
            $payload = array(
                        'user'  => ['id'=>$users->id, 'realname'=>$users->realname],
                        'areas' => $data);
        } else {
            $payload = array(
                        'user'  => ['id'=>$users->id, 'realname'=>$users->realname],
                        'areas' => []);
        }
        
        $TOKEN = JWT::encode($payload, config('jwt.secret'));
        $log['realname']    =  $users->realname;
        $log['mobile']      =  $users->mobile;
        $this->createLog(1, $users->id, json_encode($log, JSON_UNESCAPED_UNICODE),'Passport@'.__FUNCTION__);
        return response()->json(['token' => $TOKEN], 200);
	}

    public function setEthnics(Request $request)
    {
        $data = DB::select('select * from ethnics');
        return response()->json($data, 200);
    }

}
