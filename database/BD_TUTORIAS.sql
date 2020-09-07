drop database if exists ProyectoTutoriasFinal;
create database ProyectoTutoriasFinal;
use ProyectoTutoriasFinal;

		create table Carreras(
		IdCarrera int AUTO_INCREMENT  not null ,
		Carrera varchar (35) not null ,
		primary key (IdCarrera)
		);
		
        create table Materias(
		IdMateria int AUTO_INCREMENT  not null,
		Materia varchar(50) not null,
		primary key(IdMateria)
        );
       
		create table Academia(
		IdAcademia int AUTO_INCREMENT  not null,
		Academia varchar(6) not null,
		primary key(IdAcademia)
		);
        
		create table Genero(
        IdGenero int AUTO_INCREMENT not null,
        Genero varchar(15) not null,
        primary key (IdGenero)
        );
        
        create table Estados(
        IdEstado int AUTO_INCREMENT  not null,
        Estado varchar(15)  not null,
        primary key (IdEstado)
        );
        
        create table Turnos(
        IdTurno int  AUTO_INCREMENT not null,
        Turno varchar(12) not null,
        primary key (IdTurno)
        );
        
		DROP TABLE IF EXISTS  Profesores;           
		create table Profesores(
		       NoEmpleado bigint(10) not null,
			   Contrasenia varchar(100) not null, 
			   Nombre varchar(30)not null,
				Paterno varchar(20)not null ,
				Materno varchar(30)not null ,
                IdGenero int not null ,
				IdAcademia int not null,
				IdTurno int not null ,
                CorreoElectronico varchar(50) not null,
				ClaveAcepta varchar(10)not null,
                IdEstado int not null check(IdEstado in(1,2,3)), /*1-Activo,2-Suspendido.3-Inactivo*/
				primary key(NoEmpleado),
				foreign key(IdAcademia) references Academia(IdAcademia),
                foreign key(IdEstado) references Estados(IdEstado),
                foreign key(IdTurno) references Turnos(IdTurno),
                foreign key (IdGenero) references Genero(IdGenero) 
		);
        
        DROP TABLE IF EXISTS  Alumnos;
        create table Alumnos(
			NoBoleta int(10) not null, 
			Contrasenia varchar(100) not null,
			Nombre  varchar(30)not null ,
			Paterno varchar(30)not null ,
			Materno varchar(30)not null ,
			IdCarrera int not null,
			Semestre int not null check(Semestre between 1 and 15),
			IdGenero int not null ,
			FechaNacimiento date not null,
			TelFijo varchar(10) null,
			Celular varchar(10) not null ,
			CorreoElectronico varchar(50) not null,
            Hobby varchar(300) not null,
            IdEstado int not null check(IdEstado in ('6','7')), /*6-Regular, 7-Irregular*/
			primary key(NoBoleta),
			foreign key(IdCarrera) references Carreras(IdCarrera),
			foreign key(IdEstado) references Estados(IdEstado),
            foreign key (IdGenero) references Genero(IdGenero) 
           );
           
       
		create table AlumnoProfesor (
			IdAlumnoProfesor int not null auto_increment,
			NoBoleta int(20) not null,
			NoEmpleado bigint(20) not null,
			IdEstado int not null check(IdEstado in(4,5,11,12)), /*4-Pendiente, 5-Sin asignar, 11-Aceptado ,12-Rechazado*/
            FechaSolicitud date not null,
			primary key(IdAlumnoProfesor),
			foreign key(NoBoleta) references Alumnos(NoBoleta),
			foreign key(IdEstado) references Estados(IdEstado),
			foreign key(NoEmpleado) references Profesores(NoEmpleado)
			);        
        
        create table Historial(
				IdHistorial int auto_increment not null,
				IdAlumnoProfesor int,
				FechaInicio date not null,
				FechaTermino date null,
				IdEstado int not null check(IdEstado in(1,10)),
				primary key (IdHistorial),
				foreign key(IdEstado) references Estados(IdEstado),
				foreign key(IdAlumnoProfesor) references AlumnoProfesor(IdAlumnoProfesor)
		);
       
		create table AdeudosMateriasAlumno(
					IdAdeudo int not null,
                    NoBoleta int(10) not null,
                    IdMateria int not null,
					IdEstado int not null check(IdEstado in ('8','9')), /*8-Reprobada 9-Aprobada*/
                    primary key (IdAdeudo),
					foreign key(IdEstado) references Estados(IdEstado),
                    foreign key(NoBoleta) references Alumnos(NoBoleta),
                    foreign Key(IdMateria) references Materias(IdMateria)
        );
        
/**************************************************Insert****************************************************/

insert into Genero values (1,"Masculino"),
						  (2,"Femenino");
	
insert into Estados(Estado) values ("Activo"),/*Profesor en labores y  relacion Tutor-Tutorados*/
								   ("Suspendido"),/*Profesor en sabatico  Alumno suspendido*/
								   ("Inactivo"),/*Alumno dado de baja o Profesor fuera del instituto*/  
								   ("Pendiente"),/*Solicitud de Tutorado*/
								   ("Sin Asignar"),/*Ha alcanzado el maximo de Tutores(solicitud)*/                                 
								   ("Regular"),/*Situacion academica del alumno*/
								   ("Iregular"),/*Situacion academica del alumno*/
								   ("Reprobada"),/*Status de la materia*/
								   ("Aprobada"),/*Status de la materia*/
                                   ("Finalizado"),/*Finalizar Relacion Tutor-Tutorado*/
                                   ("Aceptado"),/*Solicitud aceptada*/
                                   ("Rechazado");/*Solicitud Rechazada*/
                                   
insert into Turnos(Turno) values ("Matutino"),
								 ("Vespertino"),
								 ("Mixto");
                                
insert into Carreras(Carrera) values ("Ing. Telemática");
insert into Carreras(Carrera) values ("Ing. Mecatrónica");
insert into Carreras(Carrera) values ("Ing. Bionica");
insert into Carreras(Carrera) values ("Ing. en Energia");
insert into Carreras(Carrera) values ("Ing. en Sistemas Automotrices");

insert into Materias (Materia) values   ("PROGRAMACION"),
									    ("ANALISIS Y DISEÑO DE SISTEMAS"),
									    ("ESTRUCTURA DE DATOS"),
										("ADMINISTRACION DE SISTEMAS OPERATIVOS"),
										("DISEÑO DIGITAL"),
										("ARQUITECTURA DE COMPUTADORAS"),
										("FUNDAMENTOS DE FISICA"),
										("ECUACIONES DIFERENCIALES"),
										("PROBABILIDAD"),
										("CALCULO DIFERENCIAL E INTEGRAL"),
										("VARIABLE COMPLEJA"), 
										("ALGEBRA LINEAL"),
										("ELECTROMAGNETISMO"),
										("CALCULO MULTIVARIABLE"),
										("ADMINISTRACION ORGANIZACIONAL"),
										("ETICA, PROFESION Y SOCIEDAD"),
										("COMUNICACION ORAL Y ESCRITA"),
										("INGLES I"),
										("INGLES II"),
										("PROGRAMACION ESTRUCTURADA"),
										("SOCIEDAD, CIENCIA Y TECNOLOGIA"),
										("SEÑALES Y SISTEMAS"),
										("PROPAGACION DE ONDAS ELECTROMAGNETICAS"),
										("ELECTRONICA"),
										("TEORIA DE LOS CIRCUITOS"),
										("TEORIA DE LA INFORMACION"),
										("TEORIA DE LAS COMUNICACIONES"),
										("COMUNICACIONES DIGITALES"),
										("PROCESAMIENTO DIGITAL DE SEÑALES"),
										("TELEFONIA"),
										("SISTEMAS CELULARES"),
										("PROTOCOLOS DE INTERNET"),
										("SISTEMAS DISTRIBUIDOS"),
										("INGENIERIA WEB"),
										("PROGRAMACION AVANZADA"),
										("BASES DE DATOS"),
										("TRANSMISION DE DATOS"),
										("INFORMACION FINANCIERA E INGENIERIA ECONOMICA"),
										("OPTATIVA I"),
										("INGLES III"),
										("METODOS NUMERICOS"),
										("ELECTRONICA PARA COMUNICACIONES"),
										("OPTICA"),
										("DESARROLLO SUSTENTABLE"),
										("ECONOMIA PARA INGENIEROS"),
										("INGLES IV"),
										("REDES INALAMBRICAS"),
										("REDES NEURONALES"),
										("LOGICA DIFUSA"),
										("SISTEMAS DE INFORMACION GEOGRAFICA"),
										("PROGRAMACION DE DISPOSITIVOS MOVILES"),
										("NORMATIVIDAD EN TELECOMUNICACIONES E INFORMATICA");

insert into Academia(Academia) values ("TELE");
insert into Academia(Academia) values ("MEC");
insert into Academia(Academia) values ("BIO");
insert into Academia(Academia) values ("ISISA");
insert into Academia(Academia) values ("ADMIN");
insert into Academia(Academia) values ("HUM");
insert into Academia(Academia) values ("INGLES");
insert into Academia(Academia) values ("CYD");
insert into Academia(Academia) values ("QB");
insert into Academia(Academia) values ("CB");
insert into Academia(Academia) values ("ELEC");
insert into Academia(Academia) values ("INF");
insert into Academia(Academia) values ("ME");
insert into Academia(Academia) values ("SIST"); 

               
insert into Profesores values (2589654510,"123456","Paola Nayeli","Cortez","Herrera", 2 , 1 , 1 ,"Paola@gmail.com","12345678", 1 );
insert into Profesores values (2576767687,"1234","Hugo","Gonzalez","Casas", 1,1 , 2,"HugoGonzalez@yahoo.com","123456789",1);
insert into Profesores values (2345567890,"12348","Martha","Hernandez","Hernandez", 2,1 , 3,"Martha@hotmail.com","123456781",1);


insert into Alumnos values (2015030721,"12345","Nadia","Lopez","Tirado", 1 , 4 ,2,"1999-05-18","58302940","5523258868", "nadia18_lopez@hotmail.com","Baquetbol",7);
insert into Alumnos values (2015170720,"123","Mauricio","Sanchez","Moreno", 1 , 4 ,1,"1999-09-19","55555555","5585963625", "mauricio@hotmail.com","Campismo",7);
insert into Alumnos values (2015080720,"12","Ricardo","Flores","Lima", 1 , 4 ,1,"1999-01-13","58888888","5556465544", "ricardo@hotmail.com","Cilcismo",6);
insert into Alumnos values ("2015020709","12340","ARTURO","LANDA","ESPINOSA", 2 , 6 ,2,"1999-10-18","58302940","5523258868", "arturolandae@hotmail.com","NATACION Y BASKET",7);

insert into AdeudosMateriasAlumno values (1, 2015030721, 4, 8);
insert into AdeudosMateriasAlumno values (2, 2015030721, 11, 9);
insert into AdeudosMateriasAlumno values (3, 2015030721, 12, 8);

/*Pruebas de solicitud*/
insert into AlumnoProfesor values (1,2015030721,2589654510,11,"2019-06-18");
insert into AlumnoProfesor values (5,2015030721,2576767687,11,"2019-12-18");
insert into AlumnoProfesor values (6,2015030721,2345567890,4,"2020-01-01");

insert into AlumnoProfesor values (2,2015170720,2589654510,4,"2020-08-17");
insert into AlumnoProfesor values (3,2015080720,2576767687,11,"2020-08-18");
insert into AlumnoProfesor values (4,2015020709,2576767687,4,"2020-08-20");

insert into Historial values (1,1,"2019-06-20","2019-12-20",10); /*Crear trigger para historial cuando la solicitud es aceptada y la relacion esta activa, la fecha de termino aparezca "sin fecha de termino"*/
insert into Historial values (2,5,"2019-12-20",null ,1);

/*--------------------------------------NUEVAS VISTAS--------------------------------------------------/

/**************************************GENERAL****************************************************/
drop view if exists View_OpcionesBySituacionAcademica_General;
    /*Consulta de estado por sistuacion academica*/
    create view View_OpcionesBySituacionAcademica_General as
    select Estados.Estado as Estado
      from Estados 
	 where IdEstado=6 or IdEstado=7;

select * from View_OpcionesBySituacionAcademica_General;

drop view if exists View_OpcionesByEstadoAdeudo_General;
    /*Consulta de estado por adeudo*/
    create view View_OpcionesByEstadoAdeudo_General as
		select Estados.Estado as Estado
		  from Estados 
		 where IdEstado=8 or IdEstado=9;

select * from View_OpcionesByEstadoAdeudo_General;





/******************************************ALUMNOS************************************************/
        
    drop view if exists View_DatosByPersonales_Alumno;
    /*Consulta Alumno datos personales*/
    create view View_DatosByPersonales_Alumno as
    select  Alumnos.NoBoleta as Boleta,
            Alumnos.Nombre as Nombre,
			Alumnos.Paterno as Paterno,
			Alumnos.Materno as Materno, 
            Genero.Genero as Genero,
			Alumnos.FechaNacimiento as Nacimiento ,
            Alumnos.Hobby as Hobbie
	   from Alumnos
            inner join Genero 
                    on Alumnos.IdGenero=Genero.IdGenero;
           
	select*from View_DatosByPersonales_Alumno;
	/* select*from View_DatosByPersonales_Alumno where Boleta=2015030721;*/
            
            
	drop view if exists View_DatosByAcademicos_Alumno;
    /*Consulta Alumno datos academicos*/
    create view View_DatosByAcademicos_Alumno as
    select Alumnos.NoBoleta as Boleta, 
		   Carreras.Carrera as Carrera,
		   Alumnos.Semestre as Semestre,
           Estados.Estado as SituacionAcademica
	 from  Alumnos
            inner join Carreras
                    on Carreras.IdCarrera=Alumnos.IdCarrera
			inner join Estados
                    on Estados.IdEstado=Alumnos.IdEstado;
                    
	select*from View_DatosByAcademicos_Alumno;     
	/*select*from View_DatosByAcademicos_Alumno where Boleta=2015030721;*/
 
           
	drop view if exists View_DatosByContactos_Alumno;
    /*Consulta Alumno datos de contacto*/
    create view View_DatosByContactos_Alumno as
    select Alumnos.NoBoleta as Boleta, 
           Alumnos.TelFijo as "Telefono_Fijo",
           Alumnos.Celular as "Telefono_Celular",
           Alumnos.CorreoElectronico as "Email"
      from Alumnos;
           
	select*from View_DatosByContactos_Alumno;
	/*select*from View_DatosByContactos_Alumno where Boleta=2015030721;*/
               
      
	drop view if exists View_Adeudos_Alumno;
    /*Consulta Alumno su historial de adeudos*/
    create view View_Adeudos_Alumno as
    select AdeudosMateriasAlumno.NoBoleta as Boleta, 
		   Materias.IdMateria as "Identificador de materia",
           Materias.Materia as Materia,
           Estados.Estado as Estado
      from AdeudosMateriasAlumno
              inner join Materias
                      on AdeudosMateriasAlumno.IdMateria=Materias.IdMateria
              inner join Estados
                      on AdeudosMateriasAlumno.IdEstado=Estados.IdEstado;
           
	select*from View_Adeudos_Alumno;
	/*select*from View_Adeudos_Alumno where Boleta=2015030721;*/
			   
           
   drop view if exists View_TutorActual_Alumno;
    /*Consulta Alumno su tutor actual*/
    create view View_TutorActual_Alumno as
    select AlumnoProfesor.NoBoleta as Boleta, 
           Profesores.Nombre as Nombre,
           Profesores.Paterno as Paterno,
           Profesores.Materno as Materno,
           Profesores.CorreoElectronico as Email,
           Turnos.Turno as Turno /*Aqui se tendrá que modificar a poder consultar su horario que el mismo profe subirá*/
      from AlumnoProfesor
              inner join Profesores
					  on Profesores.NoEmpleado=AlumnoProfesor.NoEmpleado
			  inner join Turnos
			           on Turnos.IdTurno=Profesores.IdTurno;
           
           select*from View_TutorActual_Alumno;
           /*select*from View_TutorActual_Alumno where Boleta=2015030721;*/           
              
	
    
    drop view if exists View_Historial_Alumno;
    /*Consulta Alumno su historial de profesores*/
    create view View_Historial_Alumno as
    select AlumnoProfesor.NoBoleta,
           Profesores.Nombre as Nombre,
		   Profesores.Paterno as Paterno,
           Profesores.Materno as Materno,
           Historial.FechaInicio as FechaInicio,
           Historial.FechaTermino as FechaTermino,
           Estados.Estado as Estado
           from Historial 
           inner join AlumnoProfesor
                   on Historial.IdAlumnoProfesor=AlumnoProfesor.IdAlumnoProfesor
           inner join Estados
				   on Historial.IdEstado=Estados.IdEstado
           inner join Profesores
                   on Profesores.NoEmpleado=AlumnoProfesor.NoEmpleado;
    
    select * from View_Historial_Alumno;   
    
/*************************************PROFESOR****************************************/
    
        drop view if exists View_Tutorados_Profesor;
        /*Esta vista es para iniciar sesion como profesor y ver todos sus alumnos (estado y solicitudes)*/
	    create view View_Tutorados_Profesor as 
        select Profesores.NoEmpleado,
               Alumnos.NoBoleta as Boleta,
               Alumnos.Nombre as Nombre,
               Alumnos.Paterno as Paterno,
               Alumnos.Materno as Materno,
               Estados.Estado as Estado
			from   AlumnoProfesor
				   inner Join Estados
						   on Estados.IdEstado=AlumnoProfesor.IdEstado
				   inner join Alumnos
						   on AlumnoProfesor.NoBoleta=Alumnos.NoBoleta
				   inner join Profesores
						   on AlumnoProfesor.NoEmpleado=Profesores.NoEmpleado;
         
        select * from View_Tutorados_Profesor ;
       /* select * from View_Tutorados_Profesor where NoEmpleado=2576767687  */
       
        drop view if exists View_Solicitudes_Profesor;
        /*Esta vista es para iniciar sesion como profesor y ver todos sus alumnos (estado y solicitudes)*/
	    create view View_Solicitudes_Profesor as 
        select Profesores.NoEmpleado,
               Alumnos.NoBoleta as Boleta,
               Alumnos.Nombre as Nombre,
               Alumnos.Paterno as Paterno,
               Alumnos.Materno as Materno,
               Estados.Estado as Estado
			from   AlumnoProfesor
				   inner Join Estados
						   on Estados.IdEstado=AlumnoProfesor.IdEstado
				   inner join Alumnos
						   on AlumnoProfesor.NoBoleta=Alumnos.NoBoleta
				   inner join Profesores
						   on AlumnoProfesor.NoEmpleado=Profesores.NoEmpleado
				   where AlumnoProfesor.IdEstado=4;
         
        select * from View_Solicitudes_Profesor ;
       /* select * from View_Solicitudes_Profesor where NoEmpleado=2576767687 */
        
	 drop view if exists View_TutoradosByDetalle_Profesor;
     create view View_TutoradosByDetalle_Profesor as 
     select  Alumnos.NoBoleta as Boleta, 
             Alumnos.Nombre as Nombre,
             Alumnos.Paterno as Paterno,
             Alumnos.Materno as Materno,
             Carreras.Carrera as Carrera,
             Alumnos.Semestre as Semestre,
             Estados.Estado as SituacionAcademica,
             Alumnos.CorreoElectronico as Email,
             Materias.IdMateria as IdentificadorMateria,
			 Materias.Materia as Materia,
			 Estados.Estado as Estado
      from AdeudosMateriasAlumno
              inner join Materias
                      on AdeudosMateriasAlumno.IdMateria=Materias.IdMateria
              inner join Estados
                      on AdeudosMateriasAlumno.IdEstado=Estados.IdEstado
              inner join Alumnos 
					  on Alumnos.NoBoleta=AdeudosMateriasAlumno.NoBoleta
              inner join Carreras 
                      on Carreras.IdCarrera=Alumnos.IdCarrera;
                      
    select * from View_TutoradosByDetalle_Profesor ;
   /* select * from View_TutoradosByDetalle_Profesor where 20150721;*/
    
/*************************************************ADMINISTRADOR****************************************************/
    
   drop view if exists View_Tutores_Administrador;
   /*Vista para visualizar los profesores y el numero de tutorados a su cargo*/
     create view View_Tutores_Administrador as 
     select  AlumnoProfesor.NoEmpleado as NoEmpleado,
             Profesores.Nombre as Nombre,
             Profesores.Paterno as Paterno,
             Profesores.Materno as Materno,
             count(AlumnoProfesor.NoEmpleado) as NumeroAlumnos
	   from  AlumnoProfesor
 inner join  Profesores
         on  AlumnoProfesor.NoEmpleado=Profesores.NoEmpleado
   group by  AlumnoProfesor.NoEmpleado;
    
    select * from View_Tutores_Administrador;
    
    drop view if exists View_TutoresByDetalle_Administrador;
   /*Vista para visualizar los profesores y el numero de tutorados a su cargo*/
     create view View_TutoresByDetalle_Administrador as 
     select  AlumnoProfesor.NoEmpleado as NoEmpleado,
             Profesores.Nombre as Nombre,
             Profesores.Paterno as Paterno,
             Profesores.Materno as Materno,
             Genero.Genero as Genero,
             Academia.Academia as Academia,
             Turnos.Turno as Turno,
             Profesores.CorreoElectronico as Email,
             Profesores.ClaveAcepta as ClaveAceptacion,
             count(AlumnoProfesor.NoEmpleado) as NumeroAlumnos
	   from  AlumnoProfesor
 inner join  Profesores
         on  AlumnoProfesor.NoEmpleado=Profesores.NoEmpleado
 inner join  Estados
		 on  Profesores.IdEstado=Estados.IdEstado
 inner join  Academia
         on  Profesores.IdAcademia=Academia.IdAcademia
 inner join  Genero
         on  Profesores.IdGenero=Genero.IdGenero
 inner join  Turnos
         on  Profesores.IdTurno=Turnos.IdTurno
   group by  AlumnoProfesor.NoEmpleado;
    
    select * from View_TutoresByDetalle_Administrador;
   
    
    drop view if exists View_Tutorados_Administrador;
   /*Vista para visualizar los alumnos */
     create view View_Tutorados_Administrador as 
     select  Alumnos.NoBoleta as Boleta,
             Alumnos.Nombre as Nombre,
             Alumnos.Paterno as Paterno,
             Alumnos.Materno as Materno
			 from  Alumnos;
   
    select * from View_Tutorados_Administrador;
    
    
    
     drop view if exists View_TutoradosByDetalle_Administrador;
   /*Vista para visualizar la informacion detallada de los alumnos */
     create view View_TutoradosByDetalle_Administrador as 
	 select  AlumnoProfesor.NoBoleta as Boleta,
             Alumnos.Nombre as Nombre,
             Alumnos.Paterno as Paterno,
             Alumnos.Materno as Materno,
             Historial.FechaInicio as FechaInicio,
             Historial.FechaTermino as FechaTermino,
             AlumnoProfesor.NoEmpleado as NumeroEmpleado
	   from  Alumnos
 inner join  AlumnoProfesor
		 on AlumnoProfesor.NoBoleta=Alumnos.NoBoleta
 inner join Historial
		on Historial.IdAlumnoProfesor=AlumnoProfesor.IdAlumnoProfesor
	  where Historial.IdEstado=1;
   
    select * from View_TutoradosByDetalle_Administrador;
    
     drop view if exists View_TutoradosByTutor_Administrador;
   /*Vista para las relaciones alumnoprofesor */
     create view View_TutoradosByTutor_Administrador as 
	 select  Historial.IdAlumnoProfesor as NumeroExpediente,
             AlumnoProfesor.NoBoleta as NoBoleta,
             AlumnoProfesor.NoEmpleado as NoEmpleado,
             Estados.Estado as Estado             
	   from  Historial
 inner join  AlumnoProfesor
         on  AlumnoProfesor.IdAlumnoProfesor=Historial.IdAlumnoProfesor
 inner join  Estados 
		 on  Estados.IdEstado=Historial.IdEstado;
 
   
    select * from View_TutoradosByTutor_Administrador;
    
   
    
    /*************************************************************************************************************/