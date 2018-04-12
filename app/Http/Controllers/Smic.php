<?php 
/**
 * 通行证管理api 包括  短信验证、登录、
 */
namespace App\Http\Controllers;
use Validator;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;

class Smic extends Controller
{
	public function send (Request $request) 
	{
        //判断手机号码最新发送时间 小于10分钟不启用新随机数，修改发送时间，负责生成6位随机数
        $rules      = [
            'mobile' => ['required', 'regex:/^1\d{10}$/'],
            'model'  => 'required|alpha_dash'
        ];

        $messages   = [
            'required'   => 'ERR_PARAM_:attribute_REQUIRED',
            'alpha_dash' => 'ERR_PARAM_:attribute_INVALID',
            'regex'      => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'mobile' => 'MOBILE',
            'model'  => 'MODEL'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }

        $params     = (object)$request->only('mobile', 'model');
        $find       = DB::table('users')->where('mobile',$params->mobile)->count();

        $code       = $this->findFile($params->mobile);
        
        $smsContent = '';
		if($code) {
            switch ($params->model) {
                case 'post-sessions':
                    if(!$find) return response()->json([], 200);
                    $smsContent = '您正在登录，验证码 '.$code.'，请在10分钟内按页面提示提交验证码，切勿将验证码泄露与他人，此服务免费。';
                    break;
                case 'put-password':
                    if(!$find) return response()->json([], 200);
                    $smsContent = '您正在修改密码，验证码 '.$code.'，请在10分钟内按页面提示提交验证码，切勿将验证码泄露与他人，此服务免费。';
                    break;
                case 'put-mobile':
                    $smsContent = '您正在更改手机号，验证码 '.$code.'，请在10分钟内按页面提示提交验证码，切勿将验证码泄露与他人，此服务免费。';
                    break;
                default:
                    if(!$find) return response()->json([], 200);
                    $smsContent = '您的操作验证码 '.$code.'，请在10分钟内按页面提示提交验证码，切勿将验证码泄露与他人，此服务免费。';
                    break;
            }
            $this->sendSMS($params->mobile, $smsContent);
        }
        
        return response()->json([], 200);
	}
}
