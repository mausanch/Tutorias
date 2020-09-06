//Mensajes 
let Message_PeticionSelector_Todos=100;
let Message_PeticionPersonales_Alumno=1;
let Message_PeticionAcademicos_Alumno=2;
let Message_PeticionContacto_Alumno=3;


//FUNCIONES GENERALES//

function handleHttpErrors(response) { //Maneja los códigos de error de HTTP cuando se hace una solicitud.
    if (!response.ok) {
        throw Error(response.statusText);
    }
    return response;
}

//Usado para las operaciones que no requieren de respuesta  
function table_simple_fetch(uri, parameters){  
    return new Promise((resolve, reject)=>{
        fetch(uri, parameters)
        .then(handleHttpErrors)
        .then(res=>res.json()) //Cambiar a text para corroborar errores
        .then(res_json=>{
            console.log(res_json);
            resolve(res_json);
        })
        .catch(e=>{
            console.log(e);
            reject(e);
        })
    })
}



function table_generate_rowsandcols(thead, tbody, rows, columns, columnwidths){
    //Object:={key: value, key: value, key:value}
    //Esta función crea los nombres de columnas de las tablas y llena el contenido de la tabla.
    let th_row;
    let th_col=[];
    let first;
    thead.innerHTML="";
    tbody.innerHTML="";    
        
    th_row= document.createElement('tr');
    th_row.setAttribute('class','row');
    thead.appendChild(th_row);

    Object.entries(columns).forEach(([colname,col],ind)=>{ //colname es un key de Object, col es un value de Object
        
            th_col.push(document.createElement('th'));
            th_col[ind].setAttribute('class',columnwidths[ind])
            th_col[ind].innerHTML=`${colname}`;
            th_row.appendChild(th_col[ind]);  
    })
    
    Object.entries(rows).forEach(([rowname,row]) => { //rowname es un key de Object, row es un value de Object
         
        let td_row = document.createElement('tr');
        td_row.setAttribute('class','row')

        Object.entries(columns).forEach(([colname,col],ind)=>{ //colname es un key de Object, col es un value de Object
            
            let td_col = document.createElement('td');
            td_col.setAttribute('class',columnwidths[ind]);
            td_col.innerHTML=`${row[col]}`;
            td_row.appendChild(td_col);
        })
        
        tbody.appendChild(td_row);
    });
}


function table_generate_datatables(tablename, init, rows, cols){
    //cols={"Apellido Paterno" : "Apellido_P", "Apellido Materno" : "Apellido_M", "ind" : "value"}
    let datatable;
    let dataSet = [];
    let customCols = [];
 
    rows.forEach((row)=>{
        let result = [];
        Object.entries(cols).forEach(([ind, value])=>{
            result.push(row[value]); 
        })
        dataSet.push(result);
    })
    Object.entries(cols).forEach(([ind, value])=>{
        customCols.push({title: ind})
    })
     
    if(init){
        datatable = $(tablename).DataTable( {
            select: true,//{style: 'multi'},
            data: dataSet,
            columns: customCols,
            dom: "frtip"
        });
    }else{ //Caso de solo actualización
        datatable = $(tablename).DataTable();
        datatable.clear();
        datatable.rows.add(dataSet);
        datatable.draw();
    }
    return datatable;
}


//Es posible que pueda usar la función simple fetch
function table_consultar_todos(uri, thead, tbody, columns, rowsindex){
    fetch(uri, {
        method: 'GET'
    })
    .then(handleHttpErrors)
    .then(res=>res.json())
    .then(res_json=>{
        let rows=res_json[rowsindex]; 
        table_generate_rowsandcols(thead, tbody, rows, columns);
    })
    .catch(e=>console.log(e))
}

//Es posible que pueda usar la función simple fetch
export function datatable_consultar_todos(uri, rowsindex, table, init, columns){
    let datatable;
    return new Promise((resolve, reject)=>{
        fetch(uri, {
            method: 'GET'
        })
        .then(handleHttpErrors)
        .then(res=>res.json())//Para hacer pruebas pasar el .json a .text
        .then(res_json=>{
            console.log(res_json);
            let rows=res_json[rowsindex];
            datatable=table_generate_datatables(table, init, rows, columns);
            resolve(datatable);
        })
        .catch(e=>{console.log(e);reject(e);})

    })
     
}



export function table_registrar(uri, jsonData){
    return new Promise((resolve, reject)=>{
        table_simple_fetch(uri, {method: 'POST', body: jsonData})
        .then(result => resolve(result))
        .catch(result => reject(result));
    })
}

function table_modificar(uri, jsonData){
    return new Promise((resolve, reject)=>{
        table_simple_fetch(uri, {method: 'PUT', body: jsonData})
        .then(result=>resolve(result))
        .catch(result=>reject(result));
    })
}

function table_eliminar(uri){
    return new Promise((resolve, reject)=>{
        table_simple_fetch(uri, {method: 'DELETE'})
        .then(result=> resolve(result))
        .catch(result=>reject(result));
    })
}

export function llenar_opciones_selector(selectors_ids){
    let ids;
    for(ids of selectors_ids){
        let selector = document.getElementById(ids);
        fetch('php/res_General.php/'+Message_PeticionSelector_Todos, {
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
}


//ALUMNOS

