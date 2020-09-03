<?php

require_once('DataBase.php');

$method=$_SERVER['REQUEST_METHOD']; //Capturar método utilizado
$uri=$_SERVER['REQUEST_URI'];       //Capturar URI utilizada
$result = "";


function res_get($id_specified){
    //USO: Pasar un único argumento entero id si se va a aplicar la acción a un elemento específico
    //Si no, no es necesario pasar argumentos.
    $args=func_get_args();
    $conexion= new Database();


return $result;
}

function Get_Opciones_Todos(){
    //USO: Pasar un único argumento entero id si se va a aplicar la acción a un elemento específico
    //Si no, no es necesario pasar argumentos.
    $args=func_get_args();
    $conexion= new Database();

        $result=$conexion->View_Opciones_General($conexion);          

return $result;
}


function res_post(){

    if($json=file_get_contents('php://input')){
        $data=json_decode($json);
        $conexion= new Database();

        $result = $conexion->Crear_Alumno (
        $conexion,
        $data->Nombres,
        $data->Apellido_Paterno, 
        $data->Apellido_Materno, 
        $data->Genero, 
        $data->Nacimiento,
        $data->Hobby, 
        $data->Boleta,
        $data->Carrera,
        $data->Semestre,
        $data->SituacionAcademica,
        $data->Telefono_Fijo,
        $data->Telefono_Celular,
        $data->Email,  
        $data->Password
        );


    }else{
        $result = ["Error"=>"No se enviaron todos los parametros correctamente"];
        header('HTTP/1.1 400 Bad Request');
        return;
    }

    return $result;

}

$uri=explode("/",$uri);
$uri=array_slice($uri,3); //Elimina las primeras tres partes irrelevantes de la uri (""/"projectfolder"/"php")
if($uri[0] == 'res_General.php'){
    if($uri=array_slice($uri,1)){ //Si después de eliminar el primer elemento ("res_alumnos.php"), el array no está vacío, entonces
        if($uri[0]==""){ //Si no se especificó un id pero si se puso un slash al final de la uri ("...nos.php/")
            header('HTTP/1.1 400 Bad Request');
            return;
        } else { //Si se especificó un id en la uri ("...nos.php/1")
            $id=$uri[0];
            $id_specified=TRUE;   
        }
    }else{ //Si no se especificó un id en la uri ("...nos.php")
       $id_specified=FALSE;
    }
    
    switch($method){
        case 'GET':                     /* SI                           NO */
                $id_specified ? $result=Get_Opciones_Todos() : $result=res_get($id_specified);
        break;
        case 'POST':
                $id_specified ? ($result = res_post()): ($result = res_post());
        break;
        default:
                header('HTTP/1.1 405 Method not allowed');
                header('Allow: GET, POST, PUT, DELETE');
        break;
    }
        
} else {
    // Sólo se aceptan resources desde 'clients'
    header('HTTP/1.1 404 Not Found');
}

echo json_encode(($result),JSON_UNESCAPED_UNICODE);

?>