<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;

include 'konect.php';

class ApisController extends Controller
{
    public $conexion;

    public function __construct(){
        $this->conexion=conectar();
    }

    public function registros(){
        //***prototipo del paginado ***

        $registros=$this->conexion->query('select * from tregistros')->fetch();
        //dd($registros);
        $currentPage=LengthAwarePaginator::resolveCurrentPage();
        $perPage = 5;


        $elementoPaginados=new LengthAwarePaginator($registros,1,$perPage,$currentPage);
        return $elementoPaginados;
    }
}
