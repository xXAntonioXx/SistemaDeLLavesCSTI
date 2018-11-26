<?php

namespace App\Http\Middleware;

use Closure;

class alreadyStartSession
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
        if($request->session()->get('estado')){
            return redirect('/main');
        }
        return $next($request);
    }
}
