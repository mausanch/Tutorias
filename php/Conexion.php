    <?php


$conexion= mysqli_connect("localhost","root","123456","ProyectoTutoriasFinal");

if(!$conexion)
      
{
    echo 'Error al conectar ala base de datos ';
    
}
else
{
    
    echo 'conexion correcta ';
}

?>