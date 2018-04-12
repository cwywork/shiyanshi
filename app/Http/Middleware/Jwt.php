<?php
namespace App\Http\Middleware;

use Closure;
use Firebase\JWT\JWT as JWT2;

class Jwt
{
    public function handle($request, Closure $next, $action = null)
    {
        
        $jwt     = $request->header('Authorization');
        
        $area_id = $request->header('Area');
        
        if(empty($jwt)) {
            
            return response()->json(['code'=>'ERR_UNAUTHORIZED'], 401);
        } 
        
        if(!preg_match("/^Bearer\s(.+)$/i", $jwt, $matches)) {
            return response()->json(['code'=>'ERR_UNAUTHORIZED'], 401);
        }
        
        try{
            $payload = JWT2::decode($matches[1], config('jwt.secret'), ['HS256']);
            $user    = app('user');
            $user->set('id',        $payload->user->id);
            $user->set('area_id',   $area_id);
            $user->set('areas',     $payload->areas);
            return $next($request);
        } catch (\Exception $e) {
            return response()->json(['code'=>'ERR_UNAUTHORIZED'], 401);
        }
    }

}
