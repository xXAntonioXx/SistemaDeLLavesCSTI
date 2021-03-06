<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Filesystem\Filesystem;

include 'Konect.php';
class AdminController extends Controller
{
    public $conexion;

    //constructor necesario para hacer la conexion con la base de datos
    public function __construct(){
        $this->conexion=conectar();
    }

    public function Cargar(){
        return view('adminPanel');
    }

    public function NuevoUsuario(){
        return view('nuevoUsuario');
    }

    public function CargarHorarios(){
        return view('cargarHorarios');
    }

    public function CargarLlaves() {
        return view('CargarLlaves');
    }

   
    /**
     * Función para registrar los horarios de un ciclo escolar por medio de un archivo csv.
     * 
     * @param Rquest $req Solicitud por parte del cliente, la cual debe contener un archivo con extensión csv.
     * @return Response $json Devuelve un json con el mensaje correspondiente a la acción y un código de estado, devuelve 200-OK si tidi salío bien.
     */
    public function AgregarHorario(Request $req) {

        //$req->file('archivo_fls')->store('public');
        if($req->hasFile('archivo_fls')) {
            $file = $req->file('archivo_fls');
            $fileName =  $file->getClientOriginalName();
            if (preg_match("/.csv$/",$fileName)) {
                $fileName = 'ho' . time() . '.csv';
                $file->move('../storage/app/public',$fileName);

                $error='';
                $insercciones = array();
                if (($archivo=fopen('../storage/app/public/'.$fileName,'r')) !==FALSE) {
                    //leer archivo linea por linea
                    $cont=1;
                    while ((($linea = fgetcsv($archivo,10000,",")) !== FALSE) and strlen($error)==0) {    
                        $arreglo= array('','','','',''.'','','','','','','');
        
                        //verificar si el numEmpleado es 0 o vacío
                        //En caso de ser vacio o 0 se le asigna un numero de empleado por defecto
                        //En caso contrario se asigna el numero de empleado del archivo.
                        if($linea[10]==0 || strlen($linea[10])==0){
                            $arreglo[0]=1;
                        }else{
                            $arreglo[0]=$linea[10];
                        }
        
                        //Verificar si el nombre del maestro esta vacío.
                        //En caso de estar vacío se le asigna el nombre por defecto del maestro.
                        //En caso contrario se asigna el nombre que viene en el archivo.
                        if(strlen($linea[0])==0){
                            $arreglo[1]='SIN ASIGNAR...';
                        }else{
                            $arreglo[1]=utf8_encode($linea[0]);
                        }
        
                        //Verificar si el nombre de la materia esta vacío.
                        //En caso de estar vacío se le asigna el nombte por defecto de la materia.
                        //En caso contrario se asigna el nombre que viene en el archivo.
                        if(strlen($linea[1])==0){
                            $arreglo[2]='SIN ASIGNAR...';
                        }else{
                            $arreglo[2]=utf8_encode($linea[1]);
                        }
        
                        //Asignar el número del aula.
                        $arreglo[3]=$linea[3];
                        
                        //Asignar el plan de estudio de la materia.
                        $arreglo[4]=utf8_encode($linea[11]);
                        $argdias= array();

                        //Definir los días de la clase
                        for ($i=4; $i <10 ; $i++) {
                            if (strlen($linea[$i]) !=0){
                                switch ($i) {
                                    case 4:
                                        $argdias[]= array(4,'LUNES');
                                        break;
                                    case 5:
                                        $argdias[]= array(5,'MARTES');
                                        break;
                                    case 6:
                                        $argdias[]= array(6,'MIERCOLES');
                                        break;
                                    case 7:
                                        $argdias[]= array(7,'JUEVES');
                                        break;
                                    case 8:
                                        $argdias[]= array(8,'VIERNES');
                                        break;
                                    case 9:
                                        $argdias[]= array(9,'SABADO');
                                        break;
                                    default:
                                        
                                        break;
                                }
                            }
                        }
        
                        //Realizar cadena con los dias de la semana en que se impartira la clase
                        //Verificar que las horas de los dias coincidan
                        $llave=TRUE;
                        for ($i=0; $i <count($argdias) ; $i++) { 
                            foreach ($argdias[$i] as $key => $value) {
                                if($key==1){
                                    $arreglo[5] = $arreglo[5] . $value .',';
                                }else{
                                    $llave= (strcmp($linea[$argdias[0][0]],$linea[$argdias[$i][0]])===0)? TRUE : FALSE;
                                }
                            }
                        }
                        
                        //Quitar la ultima coma en los dias
                        $arreglo[5] =substr($arreglo[5],0,-1);
        
                        //Asignar la hora entrada y hora salida
                        $arreglo[6]=substr($linea[$argdias[0][0]],0,strpos($linea[$argdias[0][0]],"-")) .":00";
                        $arreglo[7]=substr($linea[$argdias[0][0]],strpos($linea[$argdias[0][0]],"-")+1,strlen($linea[$argdias[0][0]])) . ":00";
                        
                        //Asignar año y ciclo
                        $arreglo[8] = $_POST["year"];
                        $arreglo[9] = $_POST["ciclo"];
        
                        if($llave){
                            $insercciones[]= $arreglo;
                        }else{
                            $error = "Las horas de clase del registro $cont no coinciden.";
                        }                
                        $cont++;
        
                    }
                    fclose($archivo);
                    if(strlen($error)==0){
                        $contador1=1;
                        $query='';
                        foreach ($insercciones as $key => $value) {
                            $query='CALL sp_registrar_horario(' . $insercciones[$key][0]. ',\''. $insercciones[$key][1] . '\',\'' . $insercciones[$key][2] . '\','. $insercciones[$key][3] . ',\'' . $insercciones[$key][4] . '\',\'' . $insercciones[$key][5] . '\',\''. $insercciones[$key][6] . '\',\'' . $insercciones[$key][7] . '\',' . $insercciones[$key][8] . ',' . $insercciones[$key][9] . ')';
                            $stmt = $this->conexion->query($query);
                            if (!$stmt) {
                                return response()->json(['errorInfo'=> $this->conexion->errorInfo()],400);
                            }
                            $stmt->closeCursor();
                            $contador1++;
                        }
                        return view('adminPanel');
                    }else{
                        return response()->json(['message'=>$error],400);
                    }
                }else{
                    return response()->json(['message'=>'El archivo no se sguardó correctamente!'],500);
                }
            }
        }
        return response()->json(['message'=>'Solo se permiten arcivos con extensión csv'],400);;
    }

    public function actualizarHorarios(){
        return view('actualizarHorarios');
    }

    public function procesarArchivoHorarios(Request $req){
        $nombreArchivo = $req->file('Horario_llaves')->storeAs('horarios','NuevoHorario.csv');
        $rutaAbsoluta = storage_path() . '/app/' . $nombreArchivo;

        $ciclo = $req['ciclo'];
        $diasSemana = array(
            0 => "LUNES",
            1 => "MARTES",
            2 => "MIERCOLES",
            3 => "JUEVES",
            4 => "VIERNES",
            5 => "SABADO",
        );

        $lineas = 0;
        $archivoGuardado = fopen($rutaAbsoluta,'r');
        while(($renglonHorario = fgetcsv($archivoGuardado,2000,',')) !== FALSE){
            $numEmp = $renglonHorario[0];
            $nombreMaestro = $renglonHorario[1];
            $nombreMateria = $renglonHorario[2];
            $llave = $renglonHorario[4];
            $programa = $renglonHorario[5];
            $diasAux = "";
            $year = date("Y");
            $hora = [];
            for($i = 0;$i < 6; $i++){
                if($renglonHorario[6 + $i] != ""){
                    $diasAux = $diasAux.$diasSemana[$i].",";
                }
                if($renglonHorario[6 + $i] != "" && count($hora) == 0){
                    $hora = explode("-",$renglonHorario[6 + $i]);
                }
            }
            $dias = substr($diasAux,0,-1);
            $lineas++;  

            $consulta = "CALL sp_registrar_horario({$numEmp},'{$nombreMaestro}','{$nombreMateria}',{$llave},'{$programa}','{$dias}','{$hora[0]}','{$hora[1]}','{$year}','{$ciclo}')";
            $this->conexion->query($consulta);
        }
        
        return view('actualizarHorarios');
    }

    public function descargarEjemplo(){
        $headers = array(
            'Content-Type: text/csv',
          );
        $ejemplo = public_path()."/archivos/HorariosEjemplo.csv";
        return response()->download($ejemplo,"HorariosEjemplo.csv",$headers);
    }
}
