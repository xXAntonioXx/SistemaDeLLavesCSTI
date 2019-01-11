<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Seleccion de archivo csv</title>
</head>
<body>
    <form name="enviar_archivo_frm" method="POST" action="importar_llaves.php" enctype="multipart/form-data">
        <input type="file" name="archivo_fls"/>
        <input type="submit" name="enviar" value="Cargar Archivo"/>
    </form>

    <br><br>
    <hr>
    <br><br>

    <form name="enviar_archivo_frm" method="POST" action="importar_horarios.php" enctype="multipart/form-data">
        <label for="ciclo">Seleccione un ciclo:</label>
        <select name="ciclo">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
        </select>
        <br>
        <br>
        <label for="year">Seleccione el año:</label>
        <select name="year">
            <?php
                for($i=0; $i<4; $i++){
                $var=date("Y")+$i;
                echo '<option value="'. $var .'">'. $var .'</option>';
                }
            ?>
        </select>
        <br><br>
        <label for="file">Seleccione un archivo Para cargar a la Base de Datos:</label><br>
        <br>
        <input type="file" name="archivo_fls"/>
        <input type="submit" name="enviar" value="Cargar Archivo"/>
    </form>
</body>
</html>