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
            while (($linea = fgetcsv($archivo,10000,",")) !== FALSE) {    
                $arreglo= array('','','','',''.'','','','','','','');

                if($linea[0]==0 || strlen($linea[0])==0){
                    $arreglo[0]='1';
                }else{
                	$arreglo[0]=$linea[0];
                }

                if(strlen($linea[1])==0){
                   $arreglo[1]='SIN ASIGNAR...';
                }else{
                	$arreglo[1]=$linea[1];
                }

                if(strlen($linea[2])==0){
                    $arreglo[2]='SIN ASIGNAR...';
                }else{
                	$arreglo[2]=$linea[2];
                }

                $arreglo[3]=$linea[4];

                $arreglo[4]=$linea[5];


                for ($i=6; $i <12 ; $i++) {
                	

                	list($entrada2,$salida2) = split("-",$linea[$i]); 
                	if($entrada != $entrada2 or $salida != $salida2){
                		$igual=0;
                	}
                }


                echo $arreglo[0] . ',' . $arreglo[1] . ',' . $arreglo[2];

                echo '<br/>';









            }
            fclose($archivo);
        }else{
            echo 'El archivo no existe!';
        }
        
        
    }else{
        echo 'El archivo debe tener exension .csv';
    }


?>