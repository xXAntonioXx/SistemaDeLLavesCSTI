<?php
    function registrar($argDatos){
        try {
            $conexion = new PDO('mysql:host=localhost;dbname=sistema_llaves','root','Kgmt1709');
            $statement = $conexion->prepare('CALL sp_registrar_horario( :num_emp,:nombre_maestro,:nombre_mat,:num_aula,:programa_mat,:dias,:hora_inicio,:hora_fin,:year,:ciclo)');
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
            ));
        } catch (PDOException $e) {
            echo "error: " . $e->getMessage();
        }
    }

    foreach ($_FILES["archivo_fls"] as $key => $value) {
        echo "Propiedad: $key ----> valor: $value <br/>";
    }
    $archivo=$_FILES["archivo_fls"]["name"];
    if (preg_match("/.csv$/",$archivo)) {
        $archivo=$_FILES["archivo_fls"]["tmp_name"];
        $destino='archivos/ho' . date("Y") . date("m") . date("d")  . date("H") . date("i")  . date("s") . '.csv';
        move_uploaded_file($archivo,$destino);
        if (($archivo=fopen($destino,'r')) !==FALSE) {
        //leer archivo linea por linea
        $cont=1;
            while (($linea = fgetcsv($archivo,10000,",")) !== FALSE) {    
                $arreglo= array('','','','',''.'','','','','','','');

                //verificar si el numEmpleado es 0 o vacío
                //En caso de ser vacio o 0 se le asigna un numero de empleado por defecto
                //En caso contrario se asigna el numero de empleado del archivo.
                if($linea[0]==0 || strlen($linea[0])==0){
                    $arreglo[0]='1';
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

                //Definir los dias de la clase
                for ($i=6; $i <12 ; $i++) {
                	if (strlen($linea[$i]) !=0){
                        switch ($i) {
                            case 6:
                                $arreglo[5]= $arreglo[5] . 'LUNES,';
                                break;
                            case 7:
                                $arreglo[5]= $arreglo[5] . 'MARTES,';
                                break;
                            case 8:
                                $arreglo[5]= $arreglo[5] . 'MIERCOLES,';
                                break;
                            case 9:
                                $arreglo[5]= $arreglo[5] . 'JUEVES,';
                                break;
                            case 10:
                                $arreglo[5]= $arreglo[5] . 'VIERNES,';
                                break;
                            case 11:
                                $arreglo[5]= $arreglo[5] . 'SABADO,';
                                break;
                            default:
                                
                                break;
                        }
                    }
                }

                //Quitar la ultima coma en los dias
                $arreglo[5] = substr($arreglo[5],0,-1);


                //Comparar si todas las horas del horario coinciden.
                $varTemp1 = $arreglo[5];
                echo $varTemp1 . '<br/>';
                if (strpos($varTemp1,',')!==TRUE) {
                    $varTemp2 = substr($varTemp1,0,strpos($varTemp1,','));
                    $varTemp1 = substr($varTemp1,strpos($varTemp1,',')+1,strlen($varTemp1));
                    echo $varTemp2 . '<br/>';
                    echo $varTemp1 . '<br/>';
                }
                

                /*
                list($entrada2,$salida2) = split("-",$linea[$i]); 
                	if($entrada != $entrada2 or $salida != $salida2){
                		$igual=0;
                	}
                */
                echo '' . $cont . '--' .$arreglo[5];
                echo '<br/>';
                $cont++;








            }
            fclose($archivo);
        }else{
            echo 'El archivo no existe!';
        }
        
        
    }else{
        echo 'El archivo debe tener exension .csv';
    }


?>