<?php 
namespace App\Http\Controllers;
use Validator;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Firebase\JWT\JWT;

class Rbac extends Controller
{
    protected $user;
    public function __construct()
    {
        $this->user = app('user');
    }

    public function getTasks(Request $request) 
    {
        $params = (object)$request->only('area_id');
        $grant  = DB::select('SELECT id,level FROM areas WHERE id = ?', [$params->area_id]);
        if(empty($grant)) return response()->json(['code'=>'ERR_NO_AREA'], 404);
        $parent = DB::select('select a.level from rbac_grants rg 
                                    left join areas a on rg.area_id = a.id 
                                    left join users u on rg.user_id = u.id
                                where rg.user_id= ? and rg.area_id= ? and rg.task_id = 1', [$this->user->id, $this->user->area_id]);
        if(empty($parent)) return response()->json([], 200);
        if($grant[0]->level > $parent[0]->level) {
            $data = DB::select('SELECT * FROM rbac_whitelist WHERE area_level=?', [$grant[0]->level]);
        } elseif($grant[0]->level == $parent[0]->level) {
            $data = DB::select('SELECT * FROM rbac_whitelist WHERE area_level=? and rbac_task_id <> 1', [$grant[0]->level]);
        } else {
            $data = [];
        }
        $code = empty($data) ? 200 : 200;
        return response()->json($data, $code);
    }

    public function setTasks(Request $request, int $id)
    {
        $super_admin_id = env('SUPER_ADMIN_ID');

        $find = DB::table('users')->where('id', $id)->count();
        if(!$find) return response()->json(['code' => 'ERR_PARAM_ARERID_REQUIRED'], 400);
        //超级管理员
        $parent_id  = $this->user->id;
        $params     = (object)$request->only('area_id', 'tasks');
        $arr        = [];
        if(intval($super_admin_id) == $id and $params->area_id == 1){
            $params->tasks[] = 1;
        }
            
        $tasks      = array_unique($params->tasks);
        foreach ($tasks as $key => $val) {
            if( $val > 0 ) {
                $arr[$key]['user_id']       = $id;
                $arr[$key]['area_id']       = $params->area_id;
                $arr[$key]['task_id']       = $val;
                $arr[$key]['granted_at']    = time();
                $arr[$key]['granted_by']    = $parent_id;
            }
        }

        DB::beginTransaction();
        try {
            DB::table('rbac_grants')->where(['user_id'=>$id,'area_id'=>$params->area_id])->delete();
            DB::table('rbac_grants')->insert($arr);
            DB::commit();
            $flog = true;
        } catch (PDOException $ex) {
            DB::rollback();
        }
        return response()->json([], 200);
    }

    public function setLock(Request $request)
    {
        $params = (object)$request->only('locked');
        $tag = false;
        if($params->locked){
            $tag = $this->cLocked();
        } else {
            $tag = $this->dLocked();
        }
        $arr['locked'] = $tag ? true : false;
        return response()->json($arr, 200);
    }

    public function getLock()
    {
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'/files';
        $file       = $dir.'/epa.lock';
        $arr['locked'] = is_file($file) ? true : false;
        return response()->json($arr, 200);
    }
    public function dLocked()
    {
        
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'/files';
        $file       = $dir.'/epa.lock';
        $tag        = false;
        if(is_file($file)) {
            $tag = unlink($file) ? false : true;
            return $tag;
        }
        return $tag;
    }
    public function cLocked()
    {
        
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'/files';
        $file       = $dir.'/epa.lock';
        if(!is_dir($dir)) $this->mkdirs($dir);
        $file = fopen($file, "w");
        $flog = fwrite( $file, json_encode([]));
        fclose($file);
        return $flog;
    }


    public function suoDin(Request $request){
        $params = (object)$request->only('locked');
        // return $params->locked;
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'test';
        $file       = $dir.'/epa.lock';
        $str = file_get_contents($file);
        // return $params->locked;
        if($params->locked == "true"){
            $myfile = fopen($file, "w") or die("Unable to open file!");
            $dbclose = "true";
            $ss=fwrite($myfile, $dbclose);
            fclose($myfile);
            $arr['locked'] = true;
            return response()->json($arr, 200);
        }else{
            $myfile = fopen($file, "w") or die("Unable to open file!");
            $dbclose = "false";
            $ss=fwrite($myfile, $dbclose);
            fclose($myfile);
            $arr['locked'] = false;
            return response()->json($arr, 200);
        }
        
    }

    public function getSuo(){
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'test';
        $file       = $dir.'/epa.lock';
        $str = file_get_contents($file);
        // return $str;
        if($str == "true"){
            $arr['locked'] = true;
        }else{
            $arr['locked'] = false;
        }
       
        return response()->json($arr, 200);
    }
}
