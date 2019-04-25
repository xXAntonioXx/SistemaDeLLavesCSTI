<?php

namespace App\Http\Middleware;

use Closure;

class adminCheckSess
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
        if($request->session()->get('rol')==1){
            return $next($request);
        }
        return redirect('/')->header('Cache-Control','nocache, no-store, max-age=0, must-revalidate')
        ->header('Pragma','no-cache')
        ->header('Expires','Sun, 02 Jan 1990 00:00:00 GMT');
    }
}
