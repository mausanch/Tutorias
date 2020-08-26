var GetData =function (){
	var Nombres= document.getElementById("Nombres").value;
	var Apellido_Paterno= document.getElementById("Apellido_Paterno").value;
	var Apellido_Materno= document.getElementById("Apellido_Materno").value;
	var Boleta= document.getElementById("Boleta").value;
	var Carrera= document.getElementById("Carrera").value;
	var Semestre= document.getElementById("Semestre").value;
	var Genero= document.getElementById("Genero").value;
	var Telefono_Fijo= document.getElementById("Telefono_Fijo").value;
	var Telefono_Celular= document.getElementById("Telefono_Celular").value;
	var Email= document.getElementById("Email").value;
	var Hobby= document.getElementById("Hobby").value;
	var Clave_Profesor= document.getElementById("Clave_Profesor").value;
	var Password= document.getElementById("Password").value;


	var NewRegistro= new Registro(Nombres,Apellido_Paterno,Apellido_Materno,Boleta,Carrera,Semestre,Genero,Telefono_Fijo,
		Telefono_Celular,Telefono_Celular,Clave_Profesor,Password,Email,Hobby,"php/InsertRegistro.php");
	NewRegistro.NuevoRegistro();
/*	if (Nombres=""){
		Document.getElementById("Nombres").focus();
	} else {
		console.log(Nombres);
		document.getElementById("Nombres").value="";

	}*/



	//
}
