
import {table_registrar,llenar_opciones_selector} 
from './modules.js';
//Definimos los elementos del DOM
/*-------------------------------------------Forms------------------------------------------*/
const form_RegistrarAlumno_General = document.getElementById('Form_RegistrarAlumno_General');
const form_Alumno_submit = document.getElementById('SubmitButton_RegistrarAlumno_General');
const form_Alumno_action = document.getElementById('f_Alumno_action');

document.addEventListener("DOMContentLoaded", function(event) {

    llenar_opciones_selector(            [
        'Genero',
        'Carrera',
        'Adeudos',
        'SituacionAcademica'
    ])


});



form_RegistrarAlumno_General.onsubmit = function(e){
    e.preventDefault();
    
    let formData = new FormData(form_RegistrarAlumno_General);
    let formJson = JSON.stringify(Object.fromEntries(formData));
    console.log(formJson);

        Alumno_Registrar(formJson)
    
}

function Alumno_Registrar(jsonData){
    return new Promise((resolve, reject)=>{
        table_registrar("php/res_General.php", jsonData)
        .then(result=>resolve(result))
        .catch(result=>reject(result));
    })
}