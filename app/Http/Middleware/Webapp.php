<?php
namespace App\Http\Middleware;

use Closure;

class Webapp
{
    public function handle($request, Closure $next, $action = null)
    {
        return $next($request);
        switch ($request->header('Content-Type')) {
            case 'application/json':
            case 'multipart/form-data':
                return $next($request);
            case 'text/html':
            default:
                if(in_array($request->path(), ['data-export','areas-global-export'])) return $next($request);
                return response(file_get_contents(__DIR__.'/../../../public/index.html'), 200)->header('Content-Type', 'text/html');
        }
    }
}
