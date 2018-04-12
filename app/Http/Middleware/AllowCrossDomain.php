<?php
namespace App\Http\Middleware;

use Closure;

class AllowCrossDomain
{
    public function handle($request, Closure $next, $guard = null)
    {
        if($this->findLock() == "false"){
            $tmp = $request->server();
            if(!$this->checkRequestMethod($tmp)){
                return response()->json(['code'=>'ERR_LOCKED'], 444);
            }
        }
        $response = $next($request);
        $response->header('Access-Control-Allow-Origin', '*');
        $response->header('Access-Control-Allow-Headers', 'Authorization, Accept-Encoding,  Content-Type');
        $response->header('Access-Control-Allow-Methods', 'OPTIONS, POST, PUT, PATCH, GET, DELETE');
        return $response;
    }

    private function checkRequestMethod($req)
    {
        $url    = $req['REQUEST_URI'];
        $action = explode('/', $url);
        $mothed = $req['REQUEST_METHOD'];
        if($mothed != 'GET'){
            switch ($action[1]) {
                case 'smics':
                    return true;
                case 'sessions':
                    return true;
                case 'mobile':
                    return true;
                case 'password':
                    return true;
                case 'suo-din':
                    return true;        
                default:
                    break;
            }
            return false;
        }
        return true;
    }

    private function findLock()
    {
        // $root   = explode('app', __DIR__);
        // return is_file($root[0].'files/epa.lock') ? true : false;
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'test';
        $file       = $dir.'/epa.lock';
        return file_get_contents($file);
    }
}
