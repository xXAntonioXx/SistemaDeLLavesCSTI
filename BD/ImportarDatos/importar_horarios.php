<?php
    //Funcion para hacer la inserccion en la Base de Datos
    function registrar($argDatos,$cont){
        try {
            $conexion = new PDO('mysql:host=localhost;dbname=sistema_llaves','root','Kgmt1709');
            /*$statement = $conexion->prepare('CALL sp_registrar_horario(:num_emp,":nombre_maestro",":nombre_mat",:num_aula,":programa_mat",":dias",":hora_inicio",":hora_fin",:year,:ciclo)');
            $statement->execute(array(
                ':num_emp' => $argDatos[0],
                ':nombre_maestro' => $argDatos[1],
                ':nombre_mat'   => $argDatos[2],
                ':num_aula'     => $argDatos[3],
                ':programa_mat' => $argDatos[4],
                ':dias'         => $argDatos[5],
                ':hora_inicio'  => $argDatos[6],
                ':hora_fin'     => $argDatos[7],
                ':year'         => $argDatos[8],
                ':ciclo'        => $argDatos[9]
            ));*/
            $statement = $conexion->query("CALL sp_registrar_horario( $argDatos[0],'$argDatos[1]','$argDatos[2]',$argDatos[3],'$argDatos[4]','$argDatos[5]','$argDatos[6]','$argDatos[7]',$argDatos[8],$argDatos[9])");
            
        } catch (PDOException $e) {
            echo "error: " . $e->getMessage();
        }
    }
   
    //INFORMACION DE DE LA PAGINA
    echo 'Datos recavados...<br/><br/>';
    echo 'AÑO: ' . $_POST["year"] . '<br/>';
    echo 'CICLO: ' . $_POST["ciclo"] . '<br/>';
    echo 'NOMBRE DEL ARCHIVO: ' . $_FILES["archivo_fls"]["name"] . '<br/>';
    echo 'TYPO DE ARCHIVO: ' . $_FILES["archivo_fls"]["type"] . '<br/>';
    echo 'TAMAÑO DE ARCHIVO: ' . $_FILES["archivo_fls"]["size"] . 'kb' . '<br/>';
    echo 'ERROR: ' . $_FILES["archivo_fls"]["error"] . '<br/><br/>';
    
    
    
    
    $error='';
    $insercciones = array();
    $archivo=$_FILES["archivo_fls"]["name"];
    if (preg_match("/.csv$/",$archivo)) {
        $archivo=$_FILES["archivo_fls"]["tmp_name"];
        $destino='archivos/ho' . date("Y") . date("m") . date("d")  . date("H") . date("i")  . date("s") . '.csv';
        move_uploaded_file($archivo,$destino);
        if (($archivo=fopen($destino,'r')) !==FALSE) {
            //leer archivo linea por linea
            $cont=1;
            while ((($linea = fgetcsv($archivo,10000,",")) !== FALSE) and strlen($error)==0) {    
                $arreglo= array('','','','',''.'','','','','','','');

                //verificar si el numEmpleado es 0 o vacío
                //En caso de ser vacio o 0 se le asigna un numero de empleado por defecto
                //En caso contrario se asigna el numero de empleado del archivo.
                if($linea[0]==0 || strlen($linea[0])==0){
                    $arreglo[0]=1;
                }else{
                	$arreglo[0]=$linea[0];
                }

                //Verificar si el nombre del maestro esta vacío.
                //En caso de estar vacío se le asigna el nombre por defecto del maestro.
                //En caso contrario se asigna el nombre que viene en el archivo.
                if(strlen($linea[1])==0){
                   $arreglo[1]='SIN ASIGNAR...';
                }else{
                	$arreglo[1]=$linea[1];
                }

                //Verificar si el nombre de la materia esta vacío.
                //En caso de estar vacío se le asigna el nombte por defecto de la materia.
                //En caso contrario se asigna el nombre que viene en el archivo.
                if(strlen($linea[2])==0){
                    $arreglo[2]='SIN ASIGNAR...';
                }else{
                	$arreglo[2]=$linea[2];
                }

                //Asignar el numero del aula.
                $arreglo[3]=$linea[4];
                
                //Asignar el plan de estudio de la materia.
                $arreglo[4]=$linea[5];
                $argdias= array();
                //Definir los dias de la clase
                for ($i=6; $i <12 ; $i++) {
                	if (strlen($linea[$i]) !=0){
                        switch ($i) {
                            case 6:
                                $argdias[]= array(6,'LUNES');
                                break;
                            case 7:
                                $argdias[]= array(7,'MARTES');
                                break;
                            case 8:
                                $argdias[]= array(8,'MIERCOLES');
                                break;
                            case 9:
                                $argdias[]= array(9,'JUEVES');
                                break;
                            case 10:
                                $argdias[]= array(10,'VIERNES');
                                break;
                            case 11:
                                $argdias[]= array(11,'SABADO');
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
                foreach ($insercciones as $key => $value) {
                   registrar($insercciones[$key],$contador1);
                   $contador1++;
                }
                
            }else{
                echo $error;
            }
        }else{
            echo 'El archivo no existe!';
        }
        
    }else{
        echo 'El archivo debe tener exension .csv';
    }


?>