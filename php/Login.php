<?php
include 'Conexion.php' ;

$Usuario1= $_POST['Usuario'];
$Clave1= $_POST['Clave'];

$consulta="SELECT * FROM  Alumnos WHERE NoBoleta='$Usuario1' and Contraseña='$Clave1'";

$Res_Cons = mysqli_query($conexion , $consulta); 
$filas=mysqli_num_rows($Res_Cons);

if ($filas>0)
{

header("location:../Alumno.html");
       
}
else
{
    echo "Error En la Autentificacion";
}

  mysqli_free_result($Res_Cons);
//mysql_close($conexion);
?>
    