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

    <form name="enviar_archivo_frm" method="POST" action="importar_horarios.php" enctype="multipart/form-data">
        <input type="file" name="archivo_fls"/>
        <input type="submit" name="enviar" value="Cargar Archivo"/>
    </form>
</body>
</html>