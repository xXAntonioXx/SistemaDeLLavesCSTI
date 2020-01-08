# SistemaDeLLavesCSTI
![Logo UNISON](http://elconstructor10.mx/wp-content/uploads/2019/03/logouson-1080x269.jpg)

Proyecto colaborativo de un sistema web para la gestión de llaves de aulas de clase de la Universidad de Sonora.

## Laravel App:
Una vez ya bajado el repositorio entrar a la carpeta de la aplicacion y usar los siguientes comandos:
- php composer update(o install)
(suponiendo que ya hiciste los cambios al .env)
- php artisan key:generate
- php artisan serve


## Usando Docker:
### Instalar dependencias javascript usando docker:

> Asumimos que usted ya tiene instalado e iniciado docker en su equipo.

Para poder instalar estas dependencias es necesario abrir una terminal y ubicarnos en la carpeta *SistemaLLaves* que se encuentra dentro del proyecto.
Una vez ubicados en la carpeta mencionada es necesario ejecutar el siguiente comando...

    docker-compose -f docker-compose.builder.yml run --rm add-dep

Si node le arroja algún error en las dependencias, usted tendrá que instalar manualmente las dependencias. Para instalar manualmente las dependencias podemos abrir el archivo *docker-compose.builder.yml* y en el bloque que tiene la instrucción `npm install` debemos colocar individualmente cada dependencia y después ejecutar el comando mencionado anteriormente.

### Ejecutar el proyecto para demostración utilizando docker:
> El proyecto solo puede ser ejecutado con docker para demostración ya que actualmente los archivos creados, no se encuentran optimizados para poder usar docker para un ambiente productivo.

Primero debemos dirigirnos en una terminal a la raíz del proyecto, una vez ahí procedemos a dirigirnos a la carpeta BD.
Cuando nos encontremos dentro de la carpeta BD del proyecto podremos ejecutar el siguiente comando:

    docker build -t dbllaves .
Una vez terminado de construir la imagen de la base de datos, podremos regresar a la raíz del proyecto en la terminal y ejecutar el siguiente comando:

>Antes de ejecutar el siguiente comando debera solicitar los archivos faltantes para poder ejecutar el proyecto con docker.
>Si se le proporcionan estos archivos asegúrese de colocarlos en la carpeta raíz.

    docker-compose up

Si el terminal no muestra ningun error, podrá usar el sistema en la dirección http://localhost:8000 utilizando las credenciales *user: admin pass: mario123*
