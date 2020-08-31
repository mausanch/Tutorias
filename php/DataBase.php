<?php
class DataBase{	
    private static $Conexion_Alt;
/*-------------------------------------------------Conexión-------------------------------------------------*/
    public static function Conectar() {        
        define('Server', 'localhost');
        define('DataBase', 'Tutorias');
        define('user', 'WebApplication');
        define('password', '123456');					        
        $options = array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8');			
        try{
            $Conexion = new PDO("mysql:host=".Server."; dbname=".DataBase, user, password, $options);			
            return $Conexion;
        }catch (Exception $e){
            die("Hubo un error al conectar: ". $e->getMessage());
        }
    }
/*--------------------------------------------------Views---------------------------------------------------*/
 

/*-------------------------------------------------General--------------------------------------------------*/
    public static function View_Acuses_General ($mysqli){
        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_Acuses_Todos";//Introduzco la consulta
        $result = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $result->execute();  //Ejecuto la consulta
        return ["Acuses_General"=>$result->fetchAll(PDO::FETCH_ASSOC)];//Retorno la matriz en el formato
    }
/*--------------------------------------------------Alumno-------------------------------------------------*/
    public static function View_Adeudos_Alumno($mysqli){
        $Boleta=$_SESSION['USERID']; //De los valores de sesion obtengo el numero de boleta

        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_Adeudos_Alumno where NoBoleta='".$Boleta."'";//Introduzco la consulta
        $Adeudos = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $Adeudos->execute();  //Ejecuto la consulta

        $query="SELECT IdEstado FROM Alumnos where NoBoleta='".$Boleta."' ";//Introduzco la consulta
        $result = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $result->fetchAll(PDO::FETCH_ASSOC);
        
        if ($result[0]['IdEstado']==6){//6 Irregular
            $Situacion_Academica="Regular";
        }
        else{
            $Situacion_Academica="Irregular";
        }

        return [
            "Adeudos_Alumno"=>$Adeudos->fetchAll(PDO::FETCH_ASSOC),
            "Situacion_Academica"=>$Situacion_Academica 
        ];//Retorno la matriz en el formato
    }

    public static function View_TutorActual_Alumno($mysqli){
        $Boleta=$_SESSION['USERID']; //De los valores de sesion obtengo el numero de boleta

        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_TutorActual_Alumno where NoBoleta='".$Boleta."'";//Introduzco la consulta
        $result = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $result->execute();  //Ejecuto la consulta
        return ["TutorActual"=>$result->fetchAll(PDO::FETCH_ASSOC)];//Retorno la matriz en el formato
    }

    public static function View_Historial_Alumno($mysqli){
        $Boleta=$_SESSION['USERID']; //De los valores de sesion obtengo el numero de boleta

        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_Historial_Alumno where NoBoleta='".$Boleta."'";//Introduzco la consulta
        $Historial = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $Historial->execute();  //Ejecuto la consulta

        if ($Historial[0]['FechaT']=="null"){
            $Historial[0]['FechaT']="Sin fecha de termino";
        }
        return [
            "Historial"=>$Historial->fetchAll(PDO::FETCH_ASSOC)           
        ];//Retorno la matriz en el formato
    }

/*--------------------------------------------------Profesor-------------------------------------------------*/

    public static function View_Tutorados_Profesor($mysqli){
        $NoEmpleado=$_SESSION['USERID']; //De los valores de sesion obtengo el numero de boleta

        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_Tutorados_Profesor where NoEmpleado='".$NoEmpleado."' and where IdEstado=11";//Introduzco la consulta
        $Historial = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $Historial->execute();  //Ejecuto la consulta
        return [
            "Tutorados"=>$Historial->fetchAll(PDO::FETCH_ASSOC)           
        ];//Retorno la matriz en el formato
    }

    public static function View_Solicitudes_Profesor($mysqli){
        $NoEmpleado=$_SESSION['USERID']; //De los valores de sesion obtengo el numero de boleta

        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_Solicitudes_Profesor where NoEmpleado='".$NoEmpleado."' and where IdEstado=4";//Introduzco la consulta
        $Historial = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $Historial->execute();  //Ejecuto la consulta
        return [
            "Tutorados"=>$Historial->fetchAll(PDO::FETCH_ASSOC)           
        ];//Retorno la matriz en el formato
    }

    public static function View_TutoradosDetalle_Profesor($mysqli,$IDAlumno){
        $NoEmpleado=$_SESSION['USERID']; //De los valores de sesion obtengo el numero de boleta

        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_TutoradosDetalle_Profesor where NoBoleta='".$IDAlumno."'";//Introduzco la consulta
        $Historial = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $Historial->execute();  //Ejecuto la consulta
        return [
            "TutoradosDetalle"=>$Historial->fetchAll(PDO::FETCH_ASSOC)           
        ];//Retorno la matriz en el formato
    }

/*-----------------------------------------------Administrador----------------------------------------------------*/
    public static function View_Tutores_Administrador($mysqli){
        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_Tutores_Administrador";//Introduzco la consulta
        $Historial = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $Historial->execute();  //Ejecuto la consulta
        return [
            "Tutores"=>$Historial->fetchAll(PDO::FETCH_ASSOC)           
        ];//Retorno la matriz en el formato
    }

    public static function View_Tutorados_Administrador($mysqli){
        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_Tutores_Administrador";//Introduzco la consulta
        $Historial = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $Historial->execute();  //Ejecuto la consulta
        return [
            "Tutorados"=>$Historial->fetchAll(PDO::FETCH_ASSOC)           
        ];//Retorno la matriz en el formato
    }

    public static function View_TutoradosByTutor_Administrador($mysqli,$IDTutor){

        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_Tutores_Administrador where NoEmpleado='".$IDTutor."' ";//Introduzco la consulta
        $Historial = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $Historial->execute();  //Ejecuto la consulta
        return [
            "Tutorados"=>$Historial->fetchAll(PDO::FETCH_ASSOC)           
        ];//Retorno la matriz en el formato
    }
/*----------------------------------------------Insercciones------------------------------------------------ */

    public static function Crear_Alumno ($mysqli,$Nombre, $Apellido_Paterno, $Apellido_Materno, $Fecha_Nacimiento, $Ciudad, $Pais, $Oficio, $Contacto_Telefono, $Nivel_Educativo, $Situacion_Familiar, $Causa_Migracion, $Llave){

        $Estado_Por_Defecto= 1;
        $PuntoDeControl=$_SESSION['POINTID'];
        $Comida_Por_Defecto=0;
        try {
            $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
            $Conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $query="insert into Migrante values (
            NULL,
            '".$Nombre."',
            '".$Apellido_Paterno."',
            '".$Apellido_Materno."',
            '".$Ciudad."',
            '".$Pais."',
            '".$Oficio."',
            '".$Fecha_Nacimiento."',
            NULL,
            '".$Contacto_Telefono."',
            '".$Nivel_Educativo."',
            '".$Situacion_Familiar."',
            '".$Llave."',
            '".$Causa_Migracion."',
            '".$Estado_Por_Defecto."');";
            $Migrante = $Conexion->prepare($query); 
            $Migrante->execute();  //Ejecuto la consulta

            $result  = $Conexion->prepare($query); //
            $result->execute();
            return ["POST"=>"Correcto, insertado correctamente"];
         }catch(PDOException $e){
             return ["POST"=>$e->getMessage()];
         }

    }



/*----------------------------------------------Modificaciones------------------------------------------------ */

public static function Modificar_Alumno ($mysqli,$id, $Nombre, $Apellido_Paterno, $Apellido_Materno, $Fecha_Nacimiento, $Ciudad, $Pais, $Oficio, $Contacto_Telefono, $Nivel_Educativo, $Situacion_Familiar, $Causa_Migracion,$llave){

    $Estado_Por_Defecto= 1;
    $Tabla='Alumno';
    try {
        //$Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        if(!isset(DataBase::$Conexion_Alt)){
            DataBase::$Conexion_Alt=DataBase::Conectar();
        }else{
            $Conexion=DataBase::$Conexion_Alt;
        }

        $Conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $query="
        UPDATE ".$Tabla."
        SET 
        Nombre='".$Nombre."', 
        Apellido_Paterno='".$Apellido_Paterno."', 
        Apellido_Materno='".$Apellido_Materno."', 
        Ciudad='".$Ciudad."',
        Id_Pais='".$Pais."', 
        Oficio='".$Oficio."', 
        Fecha_Nacimiento='".$Fecha_Nacimiento."', 
         
        Telefono_Contacto='".$Contacto_Telefono."',
        Id_Nivel='".$Nivel_Educativo."',
        Id_Famlia='".$Situacion_Familiar."',
        
        Id_Causa='".$Causa_Migracion."',
        Id_Estado='".$Estado_Por_Defecto."'
        WHERE Id_Migrante=".$id.";";
        $Funcionario = $Conexion->prepare($query); 
        $Funcionario->execute();  //Ejecuto la consulta
        return ["PUT"=>"Correcto, Modificado correctamente"];
     }catch(PDOException $e){
         return ["PUT"=>$e->getMessage()];
     }

}

/*--------------------------------------------------Borrado de registros----------------------------------------*/

public static function Eliminar_Alumno($mysqli,$id){
   
    try {
        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $Conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $query="DELETE FROM migrante WHERE Id_Migrante = '".$id."';";
        $Funcionario = $Conexion->prepare($query); 
        $Funcionario->execute();  //Ejecuto la consulta
        return ["DELETE"=>"Correcto, Eliminado correctamente"];
     }catch(PDOException $e){
         return ["DELETE"=>$e->getMessage()];
     }
}


/*------------------------------------------------Sesiones--------------------------------------------------*/
    public static function IniciarSesion ($mysqli,$User, $Pass){
        
        try{
            if (empty($User) || empty ($Pass)){
            
                echo '
                        <script type="text/javascript">	
                        alert("Por favor llene ambos campos");
                        window.history.back();
                        </script>';
            }   
            else {
                $Conexion = $mysqli ->Conectar();
                $query="SELECT Id_Funcionario, Nombre,Apellido_Paterno,Apellido_Materno,Correo_Electronico,Contrasenia,Id_Punto_Control FROM Funcionario where Correo_Electronico='".$User."'";//Introduzco la consulta
                $result  = $Conexion->prepare($query); //
                $result->execute();
                $res=$result->fetchAll(PDO::FETCH_ASSOC);
                if (!empty($res)){//Verifico la existencia de un usuario funcinoario -----------Comprobar funcionamiento    
                    
                    if (password_verify($Pass,$res[0]["Contrasenia"])) {              
                        session_start(); /*Inicializamos los valores de la sesión*/
                        $_SESSION['USERNAME']=$res[0]["Nombre"];
                        $_SESSION['USERID']=$res[0]["Id_Funcionario"];
                        $_SESSION['POINTID']=$res[0]["Id_Punto_Control"];

                        //Agregado por Mau GTZ:
                        try{
                        $Point=$res[0]["Id_Punto_Control"];
                        $ControlPointName=$Conexion->prepare("SELECT Nombre FROM Puntos_De_Control WHERE Id_Punto_Control='".$Point."'");
                        $ControlPointName->execute();
                        $ControlPointName=$ControlPointName->fetchAll(PDO::FETCH_ASSOC);
                        $_SESSION['POINTNAME']=$ControlPointName[0]['Nombre'];
                        
                        }catch (PDOException $e){
                            return ["error"=>e.getMessage()];
                            
                        }

                        header("location:http://localhost/IngenieriaWeb/migrantes.html"); 
                        
                        
                        //header('Content-Type: text/html; charset=utf-8');
                        //header("Location: "."../../migrantes.html");  
                    }            
                }else {//Si no existe un usuario funcionario, lo verifico con un usuario Administrador 
                    $query="SELECT Id_Administrador,Nombre,Apellido_Paterno,Apellido_Materno,Correo_Electronico,Contraseña FROM Administrador where Correo_Electronico='".$User."'";//Introduzco la consulta
                    $result  = $Conexion->prepare($query); //
                    $result->execute();
                    $res=$result->fetchAll(PDO::FETCH_ASSOC);
                    //var_dump($res);
                    if (!empty($res)){
                        if(password_verify($Pass,$res[0]["Contraseña"])){
                            session_start(); /*Inicializamos los valores de la sesión*/
                            $_SESSION['USERNAME']=$res[0]["Nombre"];
                            $_SESSION['USERID']=$res[0]["Id_Administrador"];
                            $_SESSION['POINTID']=0;
                            $_SESSION['ADMIN']=1;
                            header("location:http://localhost/IngenieriaWeb/Administrador.html");  
                        }

                    }
                    
                }

            }
        }catch(Exception $e){
            $result=["Error: "=>$e->getMessage()];
        }

    }

}

?>