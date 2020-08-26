<?php
include 'Conexion.php';
//var_dump($_POST);
$Boleta1= $_POST['Boleta'];
$Nombres1 = $_POST['Nombre'];
$AP1 = $_POST['Apellido_Paterno'];
$AM1 =$_POST['Apellido_Materno'];
$Carrera1= $_POST['Carrera'];
$Semestre1=$_POST['Semestre'];
$Gen1 =$_POST['Genero'];
$Date1=$_POST['Fecha_Nacimiento'];
$TF1 =$_POST['Telefono_Fijo'];
$TC1 =$_POST['Telefono_Celular'];
$Hobby1 =$_POST['Hobby'];

$Pass1 =$_POST['Password'];
$Email1 =$_POST['Email'];
$Estado1= 7;
 echo 'ANTEDS DEL SQL ';
$Boleta1 = (int) $Boleta1;
$Gen1=(int) $Gen1;
$Semestre1=(int) $Semestre1;
$Carrera1 =(int) $Carrera1;

$sql = "INSERT INTO  Alumnos(NoBoleta, Contraseña, Nombre, APaterno, AMaterno, IdCarrera, Semestre, idsexo, FechaNacimiento, TelFijo, Celular, CorreoElectronico,Hobby,EstadoA) 
       VALUES ('$Boleta1','$Pass1','$Nombres1','$AP1','$AM1','$Carrera1','$Semestre1','$Gen1','$Date1','$TF1','$TC1','$Email1','$Hobby1','$Estado1')";
$resultado=mysqli_query($conexion,$sql);
    echo mysqli_error($conexion);
//echo 'holaaaaaaaaaaaaaaa';

if(!$resultado)
{
    
    echo 'Error de registro';
    echo mysqli_error($conexion);
    
}else   
{
  
    header("location:../Login.html");
   
    
}
            

?>