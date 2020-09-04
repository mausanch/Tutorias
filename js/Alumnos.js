//import {Modulos correspondientes}

import {datatable_consultar_todos,Validar_Sesion,Cerrar_Sesion} from './Modules.js';

/*------------------------------------------------Tablas------------------------------------------------------*/

const thead_Alumno = document.getElementById('thead_Alumno');
const tbody_Alumno = document.getElementById("tbody_Alumno");
/*--------------------------------------------------Forms-----------------------------------------------------*/
const form_Alumno_registrar = document.getElementById('f_Alumno_registrar');
const form_Alumno_submit = document.getElementById('f_Alumno_submit');
const form_Alumno_action = document.getElementById('f_Alumno_action');

const B_Cerrar_Sesion=document.getElementById('B_Cerrar_Sesion');

let id;

document.addEventListener("DOMContentLoaded", function(event) {

    View_Informacion_Alummno()
    
    
   /* Alumnos_consultar('#t_Alumnos', true)
    .then(datatable=>{
        new $.fn.dataTable.Buttons(datatable, {     
            buttons: 
                [
                    {
                        text:"Boton 1", 
                        attr: {
                            //Despliegue de Modals (Si corresponde)
                            "data-toggle":"modal",
                            "data-target":"#modal_nombre"
                        },
                        action: ()=>{
                            //Acciones del Boton
                       
                        },   
                    },
                    {
                        text:"Boton 2", 
                        extend: "selectedSingle",
                        attr: {
                            //Despliegue de Modals (Si corresponde)
                            "data-toggle":"modal",
                            "data-target":"#modal_laborales_form"
                        },
                        action: ()=>{
                            //Acciones del Boton
                        },   
                    },

                    {
                        text:"Boton 3", 
                        extend: "selectedSingle",
                        attr: {
                            //Despliegue de Modals (Si corresponde)
                            "data-toggle":"modal",
                            "data-target":"#Asistencia_laborales_modal"
                        },
                    },
                    ,
                    {
                        text:"Boton 4", 
                        extend: "selectedSingle",
                        action: ()=>{
                        //Acciones del Boton
                        }   
                    }

                ]
        });
        datatable.buttons().container().appendTo( '#datatable_buttons_container' );  
    })
    .catch(
        e=>{console.log(e);
        console.log ('Tabla sin datos');
        }
        );*/
    //action requiere una definición de una función, y no una llamada a una función. Por ello se hace una estructura arrow function, es decir ()=>{}
});




function View_Informacion_Alummno(){
    fetch('php/res_Alumnos.php/'+1, {
        method: 'GET'
    })
    .then(res=>res.json())
    .then(res_json=>{
        console.log(res_json);
        resolve(res_json);
    })
    .then(resjson=>{
        Object.entries(resjson).forEach(([ind, value])=>{
            let option = document.createElement('option');
            option.setAttribute("value",value[Object.keys(value)[0]]); //Se refiere al id
            option.innerHTML=value[Object.keys(value)[1]]; //Se refiere al texto que aparece en la opción.
            selector.appendChild(option); //Agrega las opciones al selector
        })  
    })  

}


form_Alumnos_registrar.onsubmit = function(e){
    e.preventDefault();
    let formData = new FormData(form_laborales_registrar);
    let formJson = JSON.stringify(Object.fromEntries(formData));
    console.log(formJson);

}

B_Cerrar_Sesion.addEventListener("click", function(event) {
    Cerrar_Sesion();
});
