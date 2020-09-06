import {datatable_consultar_todos} from './Modules.js';

/*------------------------------------------------Tablas------------------------------------------------------*/

/*------------------------------------------------Adeudos-----------------------------------------------------*/
const thead_Adeudo = document.getElementById('thead_Adeudos');
const tbody_Adeudo = document.getElementById("tbody_Adeudos");

const thead_Alumno = document.getElementById('thead_Alumno');
const tbody_Alumno = document.getElementById("tbody_Alumno");
/*--------------------------------------------------Forms-----------------------------------------------------*/
const form_Alumno_registrar = document.getElementById('Form_RegistrarAlumno_General');
const form_Alumno_submit = document.getElementById('f_Alumno_submit');
const form_Alumno_action = document.getElementById('f_Alumno_action');

/*---------------------------------------------Definicion de Mensajes-----------------------------------------*/
const Message_Personales_Alumno=1;
const Message_Academicos_Datos_Alumno=2;
const Message_Contacto_Alumno=3;
const Message_Academicos_Adeudos_Alumno=4;
const Message_Tutor_Alumno=5;
const Message_Historial_Alumno=6;
/*-----------------------------------------------------Titulos------------------------------------------------*/
const Title_Personales_Alumno="Datos Personales del Alumno";
const Title_Academicos_Datos_Alumno="Datos Academicos del Alumno";
const Title_Academicos_Adeudos_Alumno="Adeudos del Alumno";
const Title_Contacto_Alumno="Datos de Contacto del Alumno";
const Title_Tutor_Alumno="Datos de Tutor";
const Title_Historial_Alumno="Historial";

var Message;

var Title=document.getElementsByTagName("TITLE")[0].text;
var Dir="";

switch (Title) {
    case Title_Personales_Alumno:
        Message=Message_Personales_Alumno;
    break;

    case Title_Academicos_Datos_Alumno:
        Message=Message_Academicos_Datos_Alumno;
    break;

    case Title_Academicos_Adeudos_Alumno:
        Message=Message_Academicos_Adeudos_Alumno;
        Dir="../"
    break;

    case Title_Contacto_Alumno:
        Message=Message_Contacto_Alumno;
    break;  

    case Title_Tutor_Alumno:
        Message=Message_Tutor_Alumno;
    break;  

    case Title_Historial_Alumno:
        Message=Message_Historial_Alumno;
    break;  

    default:

      break;
  }

document.addEventListener("DOMContentLoaded", function(event) {

    View_Informacion_Alummno()
    switch (Title){

        case Title_Academicos_Adeudos_Alumno:
            Tabla_Adeudos_Alumno('#t_Adeudos', true)
                .then(datatable=>{
                new $.fn.dataTable.Buttons(datatable, { 
                    buttons: 
                        [
                            {
                                text:"Agregar Adeudo", 
                                attr: {
                                    "data-toggle":"modal",
                                    "data-target":"#modal_Adeudos_Form"
                                },
                                action: ()=>{
                                    console.log("Agregando...");
                                },
                            }
                        ]
                });
                datatable.buttons().container().appendTo( '#datatable_buttons_container' );  

            })
            .catch(
                e=>{console.log(e);
                console.log ('Tabla sin datos');
                }
            );

        break;
    }
});


function View_Informacion_Alummno(){
    console.log(Message);
    fetch(Dir+'../../php/res_Alumnos.php/'+Message, {
        method: 'GET'
    })
    .then(res=>res.json())
    .then(resjson=>{
        console.log("Valores Recibidos");
        console.log(resjson);
        switch (Message) {
            case Message_Personales_Alumno:
                document.getElementById('Nombre').value=resjson.DatosPersonales[0].Nombre;
                document.getElementById('Apellido_Paterno').value = resjson.DatosPersonales[0].Paterno;
                document.getElementById('Apellido_Materno').value = resjson.DatosPersonales[0].Materno;
                document.getElementById('Genero').value = resjson.DatosPersonales[0].Genero;
                document.getElementById('Fecha_Nacimiento').value = resjson.DatosPersonales[0].Nacimiento;
                document.getElementById('Hobby').value = resjson.DatosPersonales[0].Hobbie;
            break;
        
            case Message_Academicos_Datos_Alumno:
                document.getElementById('Boleta').value=resjson.DatosPersonales[0].Boleta;
                document.getElementById('Carrera').value = resjson.DatosPersonales[0].Carrera;
                document.getElementById('Semestre').value = resjson.DatosPersonales[0].Semestre;
                document.getElementById('SituacionAcademica').value = resjson.DatosPersonales[0].SituacionAcademica;
            break;

            case Message_Academicos_Adeudos_Alumno:
                document.getElementById('label_Situacion_Academica_Alumno').textContent = resjson.Situacion_Academica;
            break;
        
            case Title_Contacto_Alumno:
                document.getElementById('Telefono_Fijo').value=resjson.DatosPersonales[0].Telefono_Fijo;
                document.getElementById('Telefono_Celular').value = resjson.DatosPersonales[0].Telefono_Celular;
                document.getElementById('Email').value = resjson.DatosPersonales[0].Email;
            break;          
            default:
                
        
              break;
          }


    })
    .catch(e=>{
        e=>console.log(e);
        console.log("Error");
    }) 
}

function Tabla_Adeudos_Alumno(table, init){  //thead_migrantes, tbody_migrantes
    return new Promise((resolve, reject)=>{
        datatable_consultar_todos("../../../php/res_Alumnos.php/"+Message, "Adeudos", table, init, {
            'Identificador de materia' : "Identificador de materia",
            'Materia':'Materia', 
            'Estado':'Estado'
        })
        .then(datatable=>{
            resolve(datatable)
        })
        .catch(e=>{reject(e)})
    })
}

/*
form_Alumno_registrar.onsubmit = function(e){
    e.preventDefault();
    let formData = new FormData(form_laborales_registrar);
    let formJson = JSON.stringify(Object.fromEntries(formData));
    console.log(formJson);
}*/
