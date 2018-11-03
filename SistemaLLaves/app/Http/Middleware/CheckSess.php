<?php

namespace App\Http\Middleware;

use Closure;

class CheckSess
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {   
        session_start();
        if($_SESSION['nombre']){
            return $next($request);
        }
        session_destroy();
        return redirect('/');
    }
}
