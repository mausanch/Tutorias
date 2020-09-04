import {datatable_consultar_todos} from './Modules.js';

/*------------------------------------------------Tablas------------------------------------------------------*/

const thead_Alumno = document.getElementById('thead_Tutorados');
const tbody_Alumno = document.getElementById("tbody_Tutorados");

document.addEventListener("DOMContentLoaded", function(event) {
    
    Tutorados_consultar('#t_Tutorados', true)
    .then(datatable=>{
        new $.fn.dataTable.Buttons(datatable, {     
            buttons: 
                [
                    {
                        text:"Ver Detalles", 
                        extend: "selectedSingle",
                        attr: {
                            //Despliegue de Modals (Si corresponde)
                            "data-toggle":"modal",
                            "data-target":"#modal_nombre"
                        },
                        action: ()=>{
                            //Acciones del Boton
                       
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
    //action requiere una definición de una función, y no una llamada a una función. Por ello se hace una estructura arrow function, es decir ()=>{}
});




function Tutorados_consultar(table, init){  //thead_alumnos, tbody_alumnos
    return new Promise((resolve, reject)=>{
        datatable_consultar_todos("php/res_Administrador.php", "Tutorados", table, init, {
            'Número de Boleta' : "Número de boleta",
            'Nombre':'Nombre', 
            'Apellido Paterno':'Apellido_Paterno', 
            'Apellido Materno':'Apellido_Materno', 
            'Tutor Actual':'Tutor_Actual'
        })
        .then(datatable=>{resolve(datatable)})
        .catch(e=>{reject(e)})
    })
}