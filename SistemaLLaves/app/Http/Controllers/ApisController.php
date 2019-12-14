<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
//**********************************************************************************************************************************************************************
/*      Este controlador maneja todas las consultas a la base de datos que sean requeridas por los elementos en las vistas(generalmente hechos con vuejs) que requieran
    consultar informacion por medio de un sistema de api, a pesar de que la principal función de estos endpoints de api es la de traer la informacion tambien se encuentran
    algunos metodos post para hacer la inserciones en la base de datos, con la intención de manejar mayor seguridad todas las consultas estan hechas con procedimientos 
    almacenados en la base de datos.
*/
//********************************************************************************************************************************************************************** */
include 'Konect.php';//traemos una instancia de la conexión a la base de datos

class ApisController extends Controller 
{
    public $conexion;//instanciamos la conexión a la base de datos

    public function __construct(){
        if(!$this->conexion){
            $this->conexion=conectar();//abrimos la conexión a la base de datos
        }
    }

    public function registrosNum(Request $req){//devuelve los registros del dia actual de la base de datos

        $registros=$this->conexion->query('CALL sp_get_llavesPrestadas()')->fetchAll();
        $coleccion=collect($registros);//tomamos todos los JSON devueltos y los colocamos en uno solo(buscar:laravel colecciones)

        return $coleccion;
        
    }

    public function Devolucion_O_Prestamo($codigo){//metodo para revisar si la llave se esta prestando o devolviendo
        //$cadenaConsulta = "CALL sp_get_esdevolucion({$codigo})";
        $resultadoBusqueda = $this->conexion->query("CALL sp_get_esdevolucion({$codigo})")->fetch();
        return $resultadoBusqueda;
    }

    public function ObjetosPrestados($idPrestamo){//obtener objetos prestados para cada registros en particular
        if($idPrestamo=="null"){
            return "";
        }else{
            $objetosPrestados = $this->conexion->query("CALL sp_get_objetos({$idPrestamo});")->fetchAll();
            return json_encode($objetosPrestados);
        }
    }

    public function ObjetosInventario(){//este metodo nos trae los objetos inventariados(disponibles) en la base de datos
        $objetosPrestados = $this->conexion->query("CALL sp_get_objetos(null);")->fetchAll();

        return json_encode($objetosPrestados);
    }

    public function hacerDevolucion(Request $req){//este metodo registra la devolución de una llave que se encuentre en circulación junto con los objetos que se llevo el maestro al solicitar la llave
        $registro = $req["idRegistro"];//id del registro al cual se le asignara la devolución
        $horaDevolucion = $req["horaDevolucion"];//la hora del navegador cliente a la que se registra la devolución
        $idPrestamoObjetos = ($req["idPrestamos"]==null) ? "NULL" : $req["idPrestamos"];//id del prestamo de registros
        $objetosDevueltos = $req["objDevueltos"]=="null"?"":$req["objDevueltos"];//los objetos que se devolvieron junto con la llave
        $llaveDevolver=$req["codigoLLave"];//codigo de la llave que se devuelve

        $UpdateRegistro="CALL sp_set_registro({$llaveDevolver},{$registro},'{$horaDevolucion}',{$idPrestamoObjetos},'{$objetosDevueltos}')";
        $this->conexion->query($UpdateRegistro);
        return $UpdateRegistro;
    }

    public function buscarHorario($codigo,$hora){//buscamos el horario en base al codigo de la llave y la hora
        $consulta="CALL sp_get_frmPrestamo({$codigo},'{$hora}')";
        $horario=$this->conexion->query($consulta)->fetch();
        if($horario){//solo en caso de que exista el horario se retornara en forma de JSON
            return $horario;    
        }
        return null;//de lo contrario se devuelve un false
    }

    public function nuevoRegistro(Request $req){//ya generado un prestamo generamos un registro de de que la llave de cierto salon fue tomado a determinada hora por determinado maestro segun el horario
        $llave=$req["llave"];
        $hora=$req["fechaHora"];
        $idHorario=$req["idHorario"];
        $idUsuario=$req->session()->get('id');//obtenemos el identificador de la sercretaria/usuario que registro la llave
        $objetos=$req["objList"];
        
        $registrar="CALL sp_registrar_registro({$llave},'{$hora}',{$idHorario},{$idUsuario},'{$objetos}')";
        $this->conexion->query($registrar);
        return $registrar;
    }

    public function getUsuarios(){
        $query = "SELECT id,nombre,rol,estado FROM tusuarios";
        $usuarios = $this->conexion->query($query)->fetchAll();
        return $usuarios;
    }

    public function updateUser(Request $req){
        $id = $req['id'];
        $contraseña = !$req['contraseña'] ?  null:password_hash($req['contraseña'],PASSWORD_DEFAULT);
        $rol = $req['rol'];
        $update = "call UpdateUser({$id},'{$contraseña}',{$rol})";
        $this->conexion->query($update);
        
    }
}
