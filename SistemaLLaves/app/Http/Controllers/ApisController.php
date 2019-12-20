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

    public function RegistrarUsuario(Request $req){

        $this->validate($req,[
            'NewUserName'=>'required',
            'userPass'=>'required',
            'rol'=>'required|integer'
        ]);

        $nombre = $req['NewUserName'];
        $contraseña = $req['userPass'];
        $rol = $req['rol'];
        $PASS=password_hash($contraseña,PASSWORD_DEFAULT);
        $consulta = "INSERT INTO tusuarios(nombre,contrasena,rol) VALUES('{$nombre}','{$PASS}',{$rol})";
        $stmt=$this->conexion->query($consulta);
        if (!$stmt) {
            return response()->json(['message'=> $this->conexion->errorInfo()],400);
        }
        return response()->json(['message'=> 'El usuario se registro con éxito.'],200);
        
    }

    public function getUsuarios(){
        $query = "SELECT id,nombre,rol,estado FROM tusuarios";
        $usuarios = $this->conexion->query($query)->fetchAll();
        return $usuarios;
    }

    public function getLlaves() {
        $query = "SELECT tllaves.id,codigo,numero,CONCAT(area,'-',aula) as aula FROM tllaves INNER JOIN taulas ON tllaves.id_aula=taulas.id";
        $llaves = $this->conexion->query($query)->fetchAll();
        return $llaves;
    }

    public function getObjetos() {
        $query = "SELECT * FROM tobjetos";
        $objetos = $this->conexion->query($query)->fetchAll();
        return $objetos;
    }

    public function updateUser(Request $req){
        $id = $req['id'];
        $contraseña = !$req['contraseña'] ?  null:password_hash($req['contraseña'],PASSWORD_DEFAULT);
        $rol = $req['rol'];
        $update = "call UpdateUser({$id},'{$contraseña}',{$rol})";
        $stmt=$this->conexion->query($update);
        if (!$stmt) {
            return response()->json(['message'=> $this->conexion->errorInfo()],400);
        }
        return response()->json(['message'=>'Datos actualizados con éxito.'],200);
    }

    public function addObject(Request $req) {
        $this->validate($req,[
            'nombre'=>'required',
            'marca'=>'required',
            'descripcion'=>'required',
            'cantidad'=>'required'
        ]);

        $nombre = $req['nombre'];
        $marca = $req['marca'];
        $descripcion = $req['descripcion'];
        $cantidad = $req['cantidad'];
        $query= 'CALL sp_registrar_objeto(\''.$nombre.'\',\''.$marca.'\',\''.$descripcion.'\','.$cantidad.')';
        $stmt = $this->conexion->query($query)->fetchAll();
        if (!$stmt) {
            return response()->json(['message'=> $this->conexion->errorInfo()],400);
        }
        return response()->json(['message'=> 'El objeto se registró con éxito.']);
    }


    public function AgregarLlave(Request $req){
        $this->validate($req,[
            'codigo'=>'required',
            'num'=>'required',
            'area'=>'required',
            'aula'=>'required'
        ]);

        $codigo = $req['codigo'];
        $numaula = $req['num'];
        $area = $req['area'];
        $aula = $req['aula'];
        $stmt = $this->conexion->query('CALL sp_registrar_llave('.$codigo.','.$numaula.',\''.$area.'\',\''.$aula.'\')')->fetchAll();
        if (!$stmt) {
            return response()->json(['message'=> $this->conexion->errorInfo()],400);
        }
        return response()->json(['message'=> 'La llave se registró con éxito.']);
    }

    /**
     * Función para agregar llaves a la base de datos por medio de un archivo csv
     * 
     * @param Request $req Solicitud por parte del cliente, la cual debe contener un archivo con extensión csv.
     * @return Response $json Devuelve un json con el código resultante de la acción, devuelve 200-OK si todo salío bien.
     */
    public function AgregarLlavescsv(Request $req) {
        if($req->hasFile('archivo_fls')) {
            $file = $req->file('archivo_fls');
            $fileName =  $file->getClientOriginalName();
            if (preg_match("/.csv$/",$fileName)) {
                $fileName = 'll' . time() . '.csv';
                $file->move('../storage/app/public',$fileName);
                if (($archivo=fopen('../storage/app/public/'.$fileName,'r')) !==FALSE) {
                    //leer archivo linea por linea
                    while (($linea = fgetcsv($archivo,10000,",")) !== FALSE) {

                        // Registro de la primer llave del aula.
                        $stmt1 = $this->conexion->query('CALL sp_registrar_llave('.$linea[0].','.$linea[2].',\''.$linea[3].'\',\''.$linea[4].'\')')->fetchAll();
                        if (!$stmt1) {
                            fclose($archivo);
                            return response()->json(['message'=> $this->conexion->errorInfo()],400);
                        }

                        //Registro de la segunda llave del aula.
                        $stmt2 = $this->conexion->query('CALL sp_registrar_llave('.$linea[1].','.$linea[2].',\''.$linea[3].'\',\''.$linea[4].'\')')->fetchAll();
                        if (!$stmt2) {
                            fclose($archivo);
                            return response()->json(['message'=> $this->conexion->errorInfo()],400);
                        }

                    }
                    fclose($archivo);
                    return response()->json(['message'=>'Las llaves fueron registradas con éxito'],200);;
                }
                return response()->json(['message'=>'El archivo no se sguardó correctamente!'],500);
            }
        }else{
            return response()->json(['message'=>'Solo se permiten arcivos con extensiónnn csv'],400);;
        }
        return response()->json(['message'=>'Solo se permiten arcivos con extensión csv'],400);;
    }

}
