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
                echo $linea[0] . ',' . $linea[1]. ',' . $linea[2];
                if($linea[0]==0 || strlen($linea[0])==0){
                    echo '----El Empleado no esta asignado';
                }
                if(strlen($linea[1])==0){
                    echo '----No hay nombre del maestro';
                }

                if(strlen($linea[2])==0){
                    echo '----No hay Materia';
                }

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