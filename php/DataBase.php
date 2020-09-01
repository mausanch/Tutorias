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

    public static function View_Opciones_General ($mysqli){
        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        
        $query="SELECT * FROM Genero";//Introduzco la consulta
        $result = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $result->execute();  //Ejecuto la consulta
        $OpcionesByGenero=$result->fetchAll(PDO::FETCH_ASSOC);

        $query="SELECT * FROM Carreras";//Introduzco la consulta
        $result = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $result->execute();  //Ejecuto la consulta
        $OpcionesCarreras=$result->fetchAll(PDO::FETCH_ASSOC);

        $query="SELECT * FROM View_OpcionesByEstadoAdeudo_General";
        $result = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $result->execute();  //Ejecuto la consulta
        $OpcionesByEstadoAdeudo=$result->fetchAll(PDO::FETCH_ASSOC);

        $query="SELECT * FROM View_OpcionesBySituacionAcademica_General";
        $result = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $result->execute();  //Ejecuto la consulta
        $OpcionesBySituacionAcademica=$result->fetchAll(PDO::FETCH_ASSOC);


        return ["OpcionesByGenero"=>$OpcionesByGenero,
                "OpcionesCarreras"=>$OpcionesCarreras,
                "OpcionesByEstadoAdeudo"=>$OpcionesByEstadoAdeudo,
                "OpcionesBySituacionAcademica"=>$OpcionesBySituacionAcademica];//Retorno la matriz en el formato
    }
    
    
/*--------------------------------------------------Alumno-------------------------------------------------*/
   
    public static function View_DatosByPersonales_Alumno($mysqli){
    $Boleta=$_SESSION['USERID']; //De los valores de sesion obtengo el numero de boleta

    $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
    $query="SELECT * FROM View_DatosByPersonales_Alumno where NoBoleta='".$Boleta."'";//Introduzco la consulta
    $result = $Conexion->prepare($query); //Agrego variables (Si es el caso)
    $result->execute();  //Ejecuto la consulta
    return ["TutorActual"=>$result->fetchAll(PDO::FETCH_ASSOC)];//Retorno la matriz en el formato
    }

    public static function View_DatosByAcademicos_Alumno($mysqli){
        $Boleta=$_SESSION['USERID']; //De los valores de sesion obtengo el numero de boleta
    
        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_DatosByPersonales_Alumno where NoBoleta='".$Boleta."'";//Introduzco la consulta
        $result = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $result->execute();  //Ejecuto la consulta
        return ["TutorActual"=>$result->fetchAll(PDO::FETCH_ASSOC)];//Retorno la matriz en el formato
    }

    public static function View_DatosByContacto_Alumno($mysqli){
        $Boleta=$_SESSION['USERID']; //De los valores de sesion obtengo el numero de boleta
    
        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_DatosByPersonales_Alumno where NoBoleta='".$Boleta."'";//Introduzco la consulta
        $result = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $result->execute();  //Ejecuto la consulta
        return ["TutorActual"=>$result->fetchAll(PDO::FETCH_ASSOC)];//Retorno la matriz en el formato
    }

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

    public static function View_TutoradosByDetalle_Profesor($mysqli,$IDAlumno){
        $NoEmpleado=$_SESSION['USERID']; //De los valores de sesion obtengo el numero de boleta

        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_TutoradosDetalle_Profesor where NoBoleta='".$IDAlumno."'";//Introduzco la consulta
        $Historial = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $Historial->execute();  //Ejecuto la consulta
        return [
            "TutoradosDetalle"=>$Historial->fetchAll(PDO::FETCH_ASSOC)           
        ];
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

    public static function View_TutoresByDetalle_Administrador($mysqli,$IDProfesor){
        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_TutoresByDetalle_Administrador";//Introduzco la consulta
        $Historial = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $Historial->execute();  //Ejecuto la consulta
        return [
            "TutoresByDetalle"=>$Historial->fetchAll(PDO::FETCH_ASSOC)           
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

    public static function View_TutoradosByDetalle_Administrador($mysqli,$IDAlumno){
        $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
        $query="SELECT * FROM View_TutoresByDetalle_Administrador where IDAlumno='".$IDAlumno."'";//Introduzco la consulta
        $Historial = $Conexion->prepare($query); //Agrego variables (Si es el caso)
        $Historial->execute();  //Ejecuto la consulta
        return [
            "TutoradosByDetalle"=>$Historial->fetchAll(PDO::FETCH_ASSOC)           
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

    public static function Insert_Alumno_Alumno ($mysqli,$Nombre, $Apellido_Paterno, $Apellido_Materno,
                                                 $Genero, $Fecha_Nacimiento, $Hobby, $Boleta, $Carrera, 
                                                 $Semestre, $Situacion_Academica, $Telefono_Fijo, $Telefono_Celular, 
                                                 $Email,$Contrasenia){


        try {
            $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
            $Conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $query="insert into Alumnos values (
            ".$Boleta.",
            ".$Contrasenia.",
            '".$Nombre."',
            '".$Paterno."',
            '".$Carrera."',
            '".$Semestre."',
            '".$Genero."',
            '".$Oficio."',
            '".$Fecha_Nacimiento."',
            '".$Telefono_Fijo."',
            '".$Telefono_Celular."',
            '".$Email."',
            '".$Hobby."',
            '".$Situacion_Academica."'
            );";
            $Alumno = $Conexion->prepare($query); 
            $Alumno->execute();  //Ejecuto la consulta

            return ["POST"=>"Correcto, insertado correctamente"];
         }catch(PDOException $e){
             return ["POST"=>$e->getMessage()];
         }

    }

    public static function Insert_Tutor_Administrador ($mysqli,$NoEmpleado,$Nombre, $Apellido_Paterno, $Apellido_Materno,
                                                 $Genero, $Academia, $Turno, $Email,$Password)
                                                 {
    $Estado_Por_Defecto=1;
    $permitted_chars = '123456789abcdefghijklmnpqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ';
    $Clave_Aceptacion=substr(str_shuffle($permitted_chars), 0, 8);
    try {
            $Conexion = $mysqli ->Conectar(); //Me conecto a la base de datos
            $Conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $query="insert into Alumnos values (
            ".$NoEmpleado.",
            ".$Contrasenia.",
            '".$Nombre."',
            '".$Paterno."',
            '".$Carrera."',
            '".$Semestre."',
            '".$Genero."',
            '".$Academia."',
            '".$Turno."',
            '".$Clave_Aceptacion."'
            '".$Estado_Por_Defecto."'
            );";
            $Alumno = $Conexion->prepare($query); 
            $Alumno->execute();  //Ejecuto la consulta

            return [
                "POST"=>"Correcto, insertado correctamente",
                "Clave"=>$Clave_Aceptacion
            ];
         }catch(PDOException $e){
             return ["POST"=>$e->getMessage()];
         }

    }


/*----------------------------------------------Modificaciones------------------------------------------------ */

public static function Update_DatosByPersonales_Alumno ($mysqli,$id,$Nombre, $Apellido_Paterno, $Apellido_Materno, 
                                                        $Genero,$Fecha_Nacimiento, $Hobby)
                                                        {


    $Tabla='Alumnos';
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
        Paterno='".$Apellido_Paterno."', 
        Materno='".$Apellido_Materno."', 
        Genero='".$Ciudad."',
        FechaNacimiento='".$Pais."', 
        Hobby='".$Oficio."' 
        WHERE NoBoleta=".$id.";";
        $Funcionario = $Conexion->prepare($query); 
        $Funcionario->execute();  //Ejecuto la consulta
        return ["PUT"=>"Correcto, Modificado correctamente"];
     }catch(PDOException $e){
         return ["PUT"=>$e->getMessage()];
     }
}

public static function Update_DatosByAcademicos_Alumno ($mysqli,$id,$Carrera, $Semestre, $Situacion_Academica)
                                                        {

    $Tabla='Alumnos';
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
        IdCarrera='".$Nombre."', 
        Semestre='".$Apellido_Paterno."', 
        IdEstado='".$Apellido_Materno."'
        WHERE NoBoleta=".$id.";";
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
        $query="DELETE FROM Alumnos WHERE NoBoleta = '".$id."';";
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

            
        }catch(Exception $e){
            $result=["Error: "=>$e->getMessage()];
        }

    }

}

?>