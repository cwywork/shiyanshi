<?php 

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;
use StdClass;

class Controller extends BaseController
{
    public function verify(string $action, array $tasks)
    {
        $action_lists = [   'Rbac@getTasks',        'Rbac@setTasks',        'Epa@getMajors',        'User@getUsers',                'User@getUsersOne', 
                            'User@insertUser',      'User@updatePassword',  'Epa@insertFamily',     'Epa@memberPutFamily',          'Epa@insertMember', 
                            'Epa@insertVes',        'Epa@deleteVes',        'Epa@getFamilies',      'Epa@getMembers',               'Epa@getMemberOne', 
                            'Epa@getPhases',        'Epa@getEduRecords',    'Epa@insertEduRecord',  'Policy@getByRecordPolicies',   'Policy@getByPhasesPolicy', 
                            'Epa@getFamilyOne',     'Epa@getIDCode',        'Epa@getFamilies',      'Epa@getVes',                   'Epa@updateMember', 
                            'Epa@updateEduRecord',  'Epa@deleteEduRecord',  'Epa@updateFamily',     'Epa@removePutFamily',          'Epa@deleteMember', 
                            'Epa@deleteFamily',     'Policy@deletePolicy',  'Policy@getPolicies',   'Policy@getPolicyOne',          'Policy@insertPolicy', 
                            'Policy@updatePolicy',  'Epa@getDropOut',       'Epa@insertDropOut',    'User@setInfo',                 'Logs@getLogs', 
                            'Notice@getNotices',    'Notice@insertNotice',  'Notice@publishNotice', 'Notice@updateNotice',          'Notice@deleteNotice'];
        $action_name = explode('Controllers', $action)[1]??null;
        $action_name = substr($action_name, 1);
        //判断权限白名单是否存在
        $flag        = in_array($action_name, $action_lists);
        $tmp         = true;
        if($flag) {
            $sql = "select t.alias task_alias from rbac_tasks t
                        inner join rbac_assigns rs on t.id = rs.task_id
                        inner join rbac_actions rc on rs.action_id = rc.id
                    where rc.alias = ?";
            $task = DB::select($sql, [$action_name]);
            if(isset($task[0])) {
                $flag = in_array($task[0]->task_alias, $tasks);
                $tmp  = $flag ? true : false;
            } else {
                $tmp  = false;
            }
        }
        return $tmp ? true : false;
    }

    public function createLogFields(array $fields, array $params, array $fds)
    {
        $new_arr = [];
        foreach ($params as $key => $val) {
            foreach ($fields as $k => $v) {
                if($key == $k){
                    if($val != $v) $new_arr[$key] = [$val, $v];
                }
            }
        }
        foreach ($fds as $val) {
            $new_arr[$val] = $fields->$val;
        }
        return $new_arr;
    }

    public function validIdCard($str)
    {
        if (! preg_match("/^(^\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/", $str))
        {
            return FALSE;
        }
        //如果是15位身份证，先升级到18位
        if (strlen($str) == 15)
        {
            $str = $this->idcard_15to18($str);
        }
        //验证18位身份证
        if (strlen($str) == 18)
        {
            return $this->idcard_checksum18($str);
        }
        return FALSE;
    }

    private function idcard_15to18($idcard)
    {
        if (strlen($idcard) != 15)
        {
            return FALSE;
        }else
        {
            // 如果身份证顺序码是996 997 998 999，这些是为百岁以上老人的特殊编码
            if (array_search(substr($idcard, 12, 3), array('996','997','998','999')) !== FALSE)
            {
                $idcard = substr($idcard, 0, 6).'18'.substr($idcard, 6, 9);
            }else
            {
                $idcard = substr($idcard, 0, 6).'19'.substr($idcard, 6, 9);
            }
        }   
        $idcard = $idcard . $this->idcard_verify_number($idcard);  
        return $idcard;
    }
    
    private function idcard_checksum18($idcard)
    {
        if (strlen($idcard) != 18)
        {
            return FALSE;
        }
        $idcard_base = substr($idcard, 0, 17);
        if ($this->idcard_verify_number($idcard_base) != strtoupper(substr($idcard, 17, 1)))
        {
            return FALSE;
        }else 
        {
            return TRUE;
        }
    }
    private function idcard_verify_number($idcard_base)
    {
        if (strlen($idcard_base) != 17) 
        {
            return FALSE;
        }
        
        //加权因子
        $factor = array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
        //效验码对应值
        $verify_number_list = array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
        $checksum = 0;
        for ($i=0; $i < strlen($idcard_base); $i++)
        {
            $checksum += substr($idcard_base, $i, 1) * $factor[$i];
        }
        $mod = $checksum % 11;
        $verify_number = $verify_number_list[$mod];
        return $verify_number;
    }

    /**
     * 获取或创建验证码
     */
    public function findFile($mobile)
    {
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'/files/sms_folder';
        $file       = $dir.'/sms_'.$mobile.'.txt';
        if(!is_dir($dir)) $this->mkdirs($dir);
        if(is_file($file)) {
            $hfile  = fopen($file, "r");
            $djson  = fread($hfile, 100);
            $arr    = json_decode($djson);
            $ctime  = time() - $arr->utime;
            if($ctime < 600){
                return $arr->code;
            }
        }
        $nArr['code']    = rand(1000, 9999);
        $nArr['mobile']  = $mobile;
        $nArr['utime']   = time();
        $file = fopen($file, "w");
        $flog = fwrite( $file, json_encode($nArr));
        fclose($file);
        return $flog ? $nArr['code'] : false;
    }

    /**
     * 获取验证码数据
     */
    public function readFile($mobile)
    {
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'/files/sms_folder';
        $file       = $dir.'/sms_'.$mobile.'.txt';
        if(is_file($file)) {
            $hfile  = fopen($file, "r");
            $djson  = fread($hfile, 100);
            fclose($hfile);
            return json_decode($djson);
        }
        return false;
    }

    /**
     * 创建多级目录
     */
    public function mkdirs($dir)
    {
        if(!is_dir($dir))
        {
            if(!$this->mkdirs(dirname($dir))){
                return false;
            }
            if(!mkdir($dir,0777, true)){
                return false;
            }
        }
        return true;
    }


    public function getAreasRange(int $area_id)
    {
        $find = DB::select('SELECT `oid`,level FROM areas WHERE id =?', [$area_id]);
        if(!$find) return false;
        $arr['_skip']     = $find[0]->oid;
        $tmp              = substr($arr['_skip'], 0, 2*$find[0]->level-1);
      
        $arr['_limit']    = str_pad($tmp, 9, 9,STR_PAD_RIGHT);
        return $arr;
    }

    public function getAreasRangeByOid(int $oid, int $level)
    {
        if(!$oid) return false;
        $obj = new StdClass();
        $obj->_skip         = $oid;
        $tmp                = substr($obj->_skip, 0, 2 * $level-1);
        $obj->_limit        = str_pad($tmp, 9, 9,STR_PAD_RIGHT);
        return $obj;
    }


    public function createLog($category_id, $user_id, $str_json, $action)
    {
        $sql = "select {$category_id} category_id, {$user_id} user_id, id action_id, `name` log, ".time()." posted_at, '{$str_json}' str_json 
                        from rbac_actions where alias = ?";
        $find = DB::select($sql, [$action]);
        if(isset($find[0])){
            $data = json_decode(json_encode($find[0]), true);
            return DB::table('logs')->insert($data);
        }
        return false;
    }

    public function getNextLevel(int $area_id, string $fields)
    {
        $find = DB::select('SELECT `oid`,level FROM areas WHERE id =?', [$area_id]);
        if(!$find) return false;
        $idSkip     = $find[0]->oid;
        $tmp        = substr($idSkip, 0, 2*$find[0]->level-1);
        $idLimit    = str_pad($tmp, 9, 9,STR_PAD_RIGHT);
        $level      = $find[0]->level + 1;

        //获取行政地区列表
        $sql = "SELECT {$fields} FROM areas WHERE `oid` between ".$idSkip." AND ".$idLimit." and level = ".$level;
        return DB::select($sql);   
    }

    public function sendSMS($mobile,$content)
    {
        $encode             = "UTF-8";
        $username           = "18682922529";  //用户名
        $password_md5       = "b49cc906c7098273a2519dd5ab0c4c21";  //密码  qcys098qhdx
        $apikey             = "b4972c380705302fbf1b4207864d2922";  //apikey秘钥（请登录 http://m.5c.com.cn 短信平台-->账号管理-->我的信息 中复制apikey）
        $url                = 'http://m.5c.com.cn/api/send/index.php';
        $contentUrlEncode   = urldecode($content);
        $data = array(
            'username'      => $username, 
            'password_md5'  => $password_md5, 
            'mobile'        => $mobile, 
            'apikey'        => $apikey, 
            'content'       => $contentUrlEncode,
            'encode'        => $encode
        ); 
        $result= $this->curlSMS($url,$data); 
        return $result;
    }

    public function curlSMS($url,$post_fields = array()){
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 3000); //60秒 
        curl_setopt($ch, CURLOPT_HEADER,1);
        curl_setopt($ch, CURLOPT_REFERER,'http://epa.dm.qccld.com');
        curl_setopt($ch, CURLOPT_POST,1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_fields);
        $data = curl_exec($ch);
        curl_close($ch);
        $res = explode("\r\n\r\n",$data);
        return @$res[2];
    }
}
