function Registro (Boleta,Nombres,Apellido_Paterno,Apellido_Materno,Carrera,Semestre,Genero,Fecha_Nacimiento,Telefono_Fijo,Telefono_Celular,Clave_Profesor,Password,Email,Hobby,Action){

this.Boleta=Boleta;
this.Nombres=Nombres;
this.Apellido_Paterno=Apellido_Paterno;
this.Apellido_Materno=Apellido_Materno;
this.Carrera=Carrera;
this.Semestre=Semestre;
this.Genero=Genero;
this.Fecha_Nacimiento=Fecha_Nacimiento;
this.Telefono_Fijo=Telefono_Fijo;
this.Telefono_Fijo=Telefono_Celular;
this.Clave_Profesor=Clave_Profesor;
this.Password=Password;
this.Email=Email;
this.Hobby=Hobby;
this.Action=Action;
}

Registro.prototype.NuevoRegistro =function (){
    $.ajax({
        type: "POST",
        url: this.action,
        data:{
            Boleta: this.Boleta, Nombres: this.Nombres,Apellido_Paterno: this.Apellido_Paterno, Apellido_Materno:
            this.Apellido_Materno,Carrera: this.Carrera,Semestre: this.Semestre,Genero: this.Genero,
            Fecha_Nacimiento: this.Fecha_Nacimiento,Telefono_Fijo:this.Telefono_Fijo, Telefono_Celular: this.Telefono_Celular,
            Clave_Profesor: this.Clave_Profesor,Password: this.Password, Email: this.Email, Hobby: this.Hobby
        },
        success : function (Response){
            alert (Response);
        }



    });


}