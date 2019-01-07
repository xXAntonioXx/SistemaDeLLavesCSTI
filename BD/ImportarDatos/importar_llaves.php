<?php 
    
    //primer codigo realizado...
    function registrar($argDatos){
        try {
            $conexion = new PDO('mysql:host=localhost;dbname=sistema_llaves','root','Kgmt1709');
            $statement = $conexion->prepare('CALL sp_registrar_llave( :codigo,:numero,:area,:aula)');
            $statement->execute(array(
                ':codigo' => $argDatos[0],
                ':numero' => $argDatos[1],
                ':area'   => $argDatos[2],
                ':aula'   => $argDatos[3]
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
        $destino='archivos/' . date("Y") . date("m") . date("d")  . date("H") . date("i")  . date("s") . '.csv';
        move_uploaded_file($archivo,$destino);
        if (($archivo=fopen($destino,'r')) !==FALSE) {
        //leer archivo linea por linea
            while (($linea = fgetcsv($archivo,10000,",")) !== FALSE) {    
                registrar(array($linea[0],$linea[2],$linea[3],$linea[4]));
                registrar(array($linea[1],$linea[2],$linea[3],$linea[4]));
            }
            fclose($archivo);
        }else{
            echo 'El archivo no existe!';
        }
        
        
    }else{
        echo 'El archivo debe tener exension .csv';
    }
?>