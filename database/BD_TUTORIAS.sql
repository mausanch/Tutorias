
drop database if exists ProyectoTutoriasFinal;
create database ProyectoTutoriasFinal;
use ProyectoTutoriasFinal;

		create table Carreras(
		IdCarrera int AUTO_INCREMENT  not null ,
		Carrera varchar (35) not null ,
		primary key (IdCarrera)
		);
		
        create table Materias(
		IdMateria varchar(4) not null,
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
           
        DROP TABLE IF EXISTS  AlumnoProfesor;
		create table AlumnoProfesor (
			IdAlumnoProfesor int not null auto_increment,
			NoBoleta int(20) not null,
			NoEmpleado bigint(20) not null,
			IdEstado int not null check(IdEstado in(4,5,11,10,12)), /*4-Pendiente, 5-Sin asignar, 11-Aceptado ,12-Rechazado*/
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
				IdEstado int not null check(IdEstado in(1,10)), /*1.Activo , 10-Finalizado*/
				primary key (IdHistorial),
				foreign key(IdEstado) references Estados(IdEstado),
				foreign key(IdAlumnoProfesor) references AlumnoProfesor(IdAlumnoProfesor)
		);
       
		create table AdeudosMateriasAlumno(
					IdAdeudo int not null,
                    NoBoleta int(10) not null,
                    IdMateria varchar(4) not null,
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

/*insert into Materias (Materia) values ("PROGRAMACION"),
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
										("NORMATIVIDAD EN TELECOMUNICACIONES E INFORMATICA"); */

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
/*
insert into AdeudosMateriasAlumno values (1, 2015030721, 4, 8);
insert into AdeudosMateriasAlumno values (2, 2015030721, 11, 9);
insert into AdeudosMateriasAlumno values (3, 2015030721, 12, 8);
*/


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
    select*from Historial;
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
		 on  AlumnoProfesor.NoBoleta=Alumnos.NoBoleta
 inner join  Historial
		 on  Historial.IdAlumnoProfesor=AlumnoProfesor.IdAlumnoProfesor
	  where  Historial.IdEstado=1;
   
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
    
    
    /*Pruebas de solicitud*/
insert into AlumnoProfesor values (1,2015030721,2589654510,4,"2019-06-18");
/*insert into AlumnoProfesor values (5,2015030721,2576767687,11,"2019-12-18");
insert into AlumnoProfesor values (6,2015030721,2345567890,4,"2020-01-01");*/

insert into AlumnoProfesor values (2,2015170720,2589654510,4,"2020-08-17");
/*insert into AlumnoProfesor values (3,2015080720,2576767687,11,"2020-08-18");*/
insert into AlumnoProfesor values (3,2015020709,2576767687,4,"2020-08-20");

/*insert into Historial values (1,1,"2019-06-20","2019-12-20",10); /*Crear trigger para historial cuando la solicitud es aceptada y la relacion esta activa, la fecha de termino aparezca "sin fecha de termino"*/
/*insert into Historial values (2,5,"2019-12-20",null ,1); */

select * from Historial;
select * from AlumnoProfesor;
select * from Estados;    
 
/***********CAMBIAR ESTADO CUANDO PROFESOR ACEPTA TUTORADO Y LLENAR HISTORIAL*********/   

drop trigger if exists CambiarEstadoHistorial;
delimiter **
create trigger CambiarEstadoHistorial after update on AlumnoProfesor /*Cambiar update cuando profesor acepte*/
  FOR EACH ROW 
  begin 
  declare boleta bigint;
  set boleta=(select NoBoleta from AlumnoProfesor where IdAlumnoProfesor=new.IdAlumnoProfesor);
  
if (new.IdEstado=11) then
	   insert into Historial(IdAlumnoProfesor, FechaInicio,FechaTermino,IdEstado) 
       values (new.IdAlumnoProfesor,now(),null,1) ;	
       end if;
	  
if (new.IdEstado=10) then
	   update Historial   
		  set FechaTermino=now(),
	          IdEstado=10
        where IdAlumnoProfesor=new.IdAlumnoProfesor;
       end if;
       
       
       /*Historial
       1   3                   4
       2   3                   11
       3   3                   10
       
       */
       


end;**

/*Nuevo registro historial*/
drop trigger if exists NuevoRegistroHistorial
delimiter **
create trigger NuevoRegistroHistorial after insert on AlumnoProfesor /*Cambiar update cuando profesor acepte*/
  FOR EACH ROW 
  begin 
     insert into Historial values (null,new.IdAlumnoProfesor,now(), null, 4);
  end;**
 
 
 
 
/*Actualizar historial*/
drop trigger if exists ActualizarHistorial;
delimiter **
create trigger ActualizarHistorial after update on AlumnoProfesor /*Cambiar update cuando profesor acepte*/
  FOR EACH ROW 
  begin 
  declare IdHistorial int;
  set IdHistorial= (select IdHistorial 
                    from AlumnoProfesor
                    where IdAlumnoProfesor=new.IdAlumnoProfesor 
                    order by IdHistorial desc limit 1);
   
  
  	  update Historial
	  set FechaTermino=now()
	  where IdHistorial=Historial.IdHistorial;
      
      insert into Historial values (null,new.IdAlumnoProfesor,now(),null, new.IdEstado);
 
 end;**
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


drop trigger if exists CambiarEstadoAlumnoProfesor;
delimiter **
create trigger CambiarEstadoAlumnoProfesor after update on Historial /*Cambiar update cuando profesor acepte*/
  FOR EACH ROW 
  begin 
  /*if (new.IdEstado=10)then
     update AlumnoProfesor
     set IdEstado=10
     where NoBoleta=NoBoleta;*/

declare validar int;
set validar= (select IdAlumnoProfesor from AlumnoProfesor where Historial.IdAlumnoProfesor=AlumnoProfesor.IdAlumnoProfesor and NoBoleta=new.NoBoleta);
update Historial 
set IdEstadoH=10
where IdAlumnoProfesor=validar;
   /*end if;*/
  end;**

/*PRUEBA TRIGGER*/
  
  /*Aceptar alumno 11=Aceptado*/
       update AlumnoProfesor
       set IdEstado=11
       where IdAlumnoProfesor=1;
       
  /*Rechazar alumno 12=Rechazado*/
       update AlumnoProfesor
       set IdEstado=12
       where IdAlumnoProfesor=2;
       
  /*Finalizar relacion alumno 10=Fnalizado*/
       update AlumnoProfesor
       set IdEstado=10
       where IdAlumnoProfesor=1;
     
select * from AlumnoProfesor;
select * from Historial;














/*-----------------------Cambiar estado de AlumnoProfesor a sin asignar------------------------*/
use ProyectoTutoriasFinal     
delimiter **
create trigger ActualizarRelacion
after update on Profesores
for each row 
BEGIN
if (new.IdEstado=5) then
	   update AlumnoProfesor
       set IdEstado=4 
       where NoEmpleado=(select NoEmpleado from Profesores where NoEmpleado=new.NoEmpleado);
	end if;
END;**
/*-----------------------------------Pruebas-------------------------*/
UPDATE Profesores set IdEstado=5 where NoEmpleado='2345567890';
select * from Profesores;
select * from Alumnos;
select * from alumnoprofesor;
select * from Estados;

/*-------------------Crea IdAdeudo en AdeudosAlumnos-----------------*/
delimiter **
create trigger RegistrarAdeudos
after insert on Alumnos
for each row 
BEGIN
if (new.IdEstado=6) then
	   insert into AdeudosAlumno(NoBoleta) values (new.NoBoleta);
	end if;
END;**

/***********ACEPTAR ALUMNO*********/   
drop procedure if exists AceptarTutorado;
delimiter **
create procedure AceptarTutorado(in boleta varchar(20), in empleado varchar(20))
begin
	update AlumnoProfesor
			set IdEstado="aceptado"
             where NoBoleta=boleta and NoEmpleado=empleado;
            
		end; **
delimiter ;

/*call AceptarTutorado("2015030720","2345567890"); <------------------PRUEBA*/
/*call AceptarTutorado("2015030720","2576767687"); Acepta nuevo tutor*/



/*INGRESAR UN NUEVO TUTOR*/
drop procedure if exists NuevoTutor;
delimiter **
create procedure NuevoTutor(in boleta varchar(20),in clave varchar(20))
begin
declare validar int;
set validar= (select IdAlumnoProfesor from AlumnoProfesor where NoBoleta=boleta);
update Historial 
set IdEstadoH="Finalizado"
where IdAlumnoProfesor=validar;

insert into AlumnoProfesorV(NoBoleta,ClaveAceptaR,IdEstado) 
       values (boleta, clave,"pendiente");

       
       end; **
delimiter ;

/*call NuevoTutor("2015030721", "123456789"); <------------------PRUEBA */






/**********************views******************/

drop view if exists Historial_Pendientes;
Create VIEW Historial_Pendientes AS 
			SELECT * FROM AlumnoProfesor
				WHERE IdEstado = "Pendiente";  
 
drop view if exists Vista_Alumnos;
create VIEW Vista_Alumnos AS 
			SELECT Alumnos.NoBoleta,
                   Alumnos.Nombre as "Nombre(s)",
                   Alumnos.APaterno as "Apellido Paterno", 
				   Alumnos.AMaterno  as "Apellido Materno", 
				   Alumnos.TelFijo as "Telefono Fijo", 
				   Alumnos.Celular as Celular,
                   Alumnos.CorreoElectronico as "Correo Electronico" 
            FROM Alumnos  
            ;  
            
drop view if exists Tutores_Activos;	
create view Tutores_Activos as 
SELECT Alumnos.Nombre as "Nombre(s)",
       Alumnos.APaterno as "Apellido Paterno",
	   Alumnos.AMaterno as "Apellido Materno",
       Alumnos.NoBoleta as "Numero de Boleta",
       Historial.IdEstado as "Status"
    FROM Alumnos INNER JOIN AlumnoProfesor 
						ON AlumnoProfesor.NoBoleta = Alumnos.NoBoleta
				INNER JOIN Historial 
						ON AlumnoProfesor.IdAlumnoProfesor=Historial.IdAlumnoProfesor
								WHERE Historial.IdEstado="aceptado";
                                
/***************Visualizar vistas*************/                          
/*select * from Tutores_Activos;
select *from Historial_Pendientes ;
select *from Vista_Alumnos;*/
                            
/***********************procedimientos extras ALUMNOS**********************/  

drop procedure if exists CambiarContraseniaAlumno ;
delimiter **
create procedure CambiarContraseniaAlumno(in boleta varchar(20), in contrasenia varchar(40))
begin
	update Alumnos
    set Contrasenia=contrasenia
    where NoBoleta=boleta;
end; **
delimiter ;                                

/*call CambiarContraseniaAlumno("2015030720","12349"); <------------------PRUEBA*/
 

drop procedure if exists CambiarCarreraAlumno ;
delimiter **
create procedure CambiarCarreraAlumno(in boleta varchar(20), in carrera INT)
begin
	update Alumnos
    set IdCarrera=carrera /*SE TIENE QUE PONER UNA LISTA DE SELECCION QUE POR DEFAULT DÉ NUMEROS*/
    where NoBoleta=boleta;
end; **
delimiter ;

/*call CambiarCarreraAlumno("2015030720",1); <------------------PRUEBA*/
                            
drop procedure if exists CambiarSemestreAlumno ;
delimiter **
create procedure CambiarSemestreAlumno(in boleta varchar(20), in semestre INT)
begin
	update Alumnos
    set Semestre=semestre 
    where NoBoleta=boleta;
end; **
delimiter ;

/*call CambiarSemestreAlumno("2015030720",10); <------------------PRUEBA*/

drop procedure if exists CambiarTelefonoFijo ;
delimiter **
create procedure CambiarTelefonoFijo(in boleta varchar(20), in tel varchar(10))
begin
	update Alumnos
    set TelFijo=tel 
    where NoBoleta=boleta;
end; **
delimiter ;

/*call CambiarTelefonoFijo("2015030720","5523258888"); <------------------PRUEBA*/

drop procedure if exists CambiarCelular ;
delimiter **
create procedure CambiarCelular(in boleta varchar(20), in cel varchar(10))
begin
	update Alumnos
    set Celular=cel 
    where NoBoleta=boleta;
end; **
delimiter ;

/*call CambiarCelular("2015030720","58302340"); <------------------PRUEBA*/

drop procedure if exists CambiarCorreo ;
delimiter **
create procedure CambiarCorreo(in boleta varchar(20), in correo varchar(40))
begin
	update Alumnos
    set CorreoElectronico=correo 
    where NoBoleta=boleta;
end; **
delimiter ;

/*call CambiarCorreo("2015030720","nadiajaqueline@hotmail.com"); <------------------PRUEBA*/

/***********************procedimientos extras PROFESORES**********************/ 

drop procedure if exists CambiarContraseniaProfesores ;
delimiter **
create procedure CambiarContraseniaProfesores(in empleado varchar(20), in contra varchar(40))
begin
	update Profesores
    set ContraseniaP=contra 
    where NoEmpleado=empleado;
end; **
delimiter ;

/*call CambiarContraseniaProfesores("2345567890","12345"); <------------------PRUEBA*/

drop procedure if exists CambiarAcademiaProfesores ;
delimiter **
create procedure CambiarAcademiaProfesores(in empleado varchar(20), in academia int)
begin
	update Profesores
    set IdAcademia=academia 
    where NoEmpleado=empleado;
end; **
delimiter ;

/*call CambiarAcademiaProfesores("2345567890",3); <------------------PRUEBA*/

drop procedure if exists CambiarTurnoProfesores ;
delimiter **
create procedure CambiarTurnoProfesores(in empleado varchar(20), in turno varchar(40))
begin
	update Profesores
    set Turno=turno 
    where NoEmpleado=empleado;
end; **
delimiter ;

/*call CambiarTurnoProfesores("2345567890","Matutino"); <------------------PRUEBA*/
/*call CambiarTurnoProfesores("2345567890","Mañana"); verificar que otra cosa fuera de los checks no se registra*/


drop procedure if exists CambiarClaveAceptacionProfesores ;
delimiter **
create procedure CambiarClaveAceptacionProfesores(in empleado varchar(20), in clave varchar(40))
begin
	update Profesores
    set ClaveAcepta=clave
    where NoEmpleado=empleado;
end; **
delimiter ;

/*call CambiarClaveAceptacionProfesores("2345567890","123"); <------------------PRUEBA*/


/*************************** Visualizar ADEUDOS DE MATERIAS ALUMNOS**************************************/

drop procedure if exists VisualizarAdeudosAlumnos ;
delimiter **
create procedure VisualizarAdeudosAlumnos(in boleta varchar(20))
begin
	select Materia from Adeudos, Materias where Adeudos.NoBoleta=boleta
    and Materias.IdMateria=Adeudos.IdMateria ;
end; **
delimiter ;

/*call VisualizarAdeudosAlumnos("2015030720"); <------------------PRUEBA*/
drop procedure if exists EliminarAdeudosAlumnos ;
delimiter **
create procedure EliminarAdeudosAlumnos(in boleta varchar(20), in materia int)
begin
    delete from Adeudos where NoBoleta=boleta
    and IdMateria=materia ;
end; **
delimiter ;
/*call EliminarAdeudosAlumnos("2015030720", 5); <------------------PRUEBA*/

/**********************SI SON 5 TUTORES MANDAR ALERTA DE QUE TIENE QUE ACUDIR A OFICINA DE TUTORIAS************************/
drop procedure if exists Numero_Tutores ;
delimiter **
create procedure Numero_Tutores(in boleta varchar(20))
begin
declare num int;

declare msj varchar(100);
  set num=  (select count(*) 
			 as "Numero de Tutores en su Historial" 
             from AlumnoProfesor
             group by NoBoleta=boleta);
  if (num> 5) then
             set msj="TIENES QUE ACUDIR A LA OFICINA DE TUTORIAS";
             select msj as Resultado;
             else 
             select NoBoleta,count(*) 
			 as "Numero de Tutores en su Historial" 
             from AlumnoProfesor
             group by NoBoleta=boleta;
             end if;
	

end; **
delimiter ;
/*call Numero_Tutores("2015030721"); <------------------PRUEBA*/


/**---------------------------------------------------------------------------Dorime-----------------------------------------------------------------------------*/ 
/*
select *from Vista_Alumnos where NoBoleta=2015020720;
select * from AlumnoProfesor  where NoEmpleado=2589654510;
SELECT* FROM HISTORIAL;
select *from Profesores;
*/


	drop view if exists EstadoTutorados;	
	create view EstadoTutorados as 
	SELECT 
		   Alumnos.Nombre as "Nombre(s)",
		   Alumnos.APaterno as "Apellido Paterno",
		   Alumnos.AMaterno as "Apellido Materno",
		   Alumnos.NoBoleta as "Numero de Boleta",
		   Profesores.NoEmpleado,
		   Historial.IdEstado
		FROM Alumnos INNER JOIN AlumnoProfesor 
							ON AlumnoProfesor.NoBoleta = Alumnos.NoBoleta
					Inner JOIN Profesores 
							On AlumnoProfesor.NoEmpleado=Profesores.NoEmpleado
					Inner join Historial
							ON AlumnoProfesor.IdAlumnoProfesor=Historial.IdAlumnoProfesor;




drop view if exists DatosProfesor;	
	create view DatosProfesor as 
	SELECT 
		   Profesores.NombreP as "Nombre(s)",
		   Profesores.APaternoP as "Apellido Paterno",
		   Profesores.AMaternoP as "Apellido Materno",
		   Profesores.NoEmpleado
		FROM Profesores; 
        /*
   select *from DatosProfesor where NoEmpleado=2345567890;
   */
   
   drop view if exists Tutor_Totorado;
create  view Tutor_Tutorado as 
SELECT
	Alumnos.NoBoleta,
    Alumnos.Nombre as "Nombre(s)",
    Alumnos.APaterno as "Apellido Paterno",
    Alumnos.AMaterno as "Apellido Materno",
    profesores.NoEmpleado, 
    alumnoprofesor.IdEstado "Estado"
    FROM Alumnos INNER JOIN AlumnoProfesor 
						ON AlumnoProfesor.NoBoleta = Alumnos.NoBoleta
				INNER JOIN profesores
						ON alumnoprofesor.NoEmpleado=profesores.NoEmpleado;
			/*		
                        
 select *from Tutor_Tutorado where NoEmpleado="2589654510";
 select Materia from Materias;
 
 select *from adeudos;*/
/*
drop view if exists Adeudos_Materia; 
create view Adeudos_Materia as 
    select 
    adeudos.idAdeudo as "Número de materia",
    alumnos.NoBoleta,
    alumnos.Nombre as "Nombre(s)",
    alumnos.APaterno as "Apellido Paterno",
    alumnos.AMaterno as "Apellido Materno",
    materias.Materia as "Nombre de la materia"
     from alumnos inner Join adeudos 
						on adeudos.NoBoleta=alumnos.NoBoleta
				  inner Join materias 
						on adeudos.IdMateria=materias.IdMateria;*/
        /*                
		select *from Adeudos_Materia where NoBoleta='2015070720';
        
        select *from profesores;
        
        select *from Academia;*/
create  view Profesores_Tutores as 
SELECT
    profesores.NoEmpleado,
    profesores.NombreP as "Nombre(s)",
    profesores.APaternoP as  "Apellido Paterno",
    profesores.AMaternoP as "Apellido Materno",
    profesores.AMaternoP  as "Turno",
    Academia.Academia as "Academia"
    FROM Profesores inner Join Academia 
						on Academia.IdAcademia=Profesores.IdAcademia;                        
                        

         
         
 /*Poner dos botones, tienes adeudos  sí y no, si es sí que mande un formulario para seleccionar materia una por una*/
/*INSERT into Adeudos(NoBoleta) values("2015030721");*/
/*INSERT into Adeudos(NoBoleta) values("2015030721");*/


/*select*from sexoAP;
drop view Tutorados;*/
create  view Tutorados as 
SELECT
	alumnoprofesor.NoEmpleado,
    alumnos.Nombre as "Nombre",
    alumnos.CorreoElectronico as "CorreoElectronico",
    alumnos.Semestre as "semestre",
    alumnoprofesor.NoBoleta as "Boleta" from alumnos 
    inner join alumnoprofesor on alumnos.NoBoleta = alumnoprofesor.NoBoleta;
    /*update alumnoprofesorV set Status=2 where NoEmpleado='' 
    and NoBoleta='';
    select * from Tutorados;
	select * from alumnos;
	select * from alumnoprofesorv;
	select * from alumnoprofesor;
	select * from estados;
    select * from PROFESORES
    */
/*ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'upiita2020';*/


create view View_Adeudos_Alumnos as 
    select 
    AdeudosMaterias.idMateria,
    Materias.Materia,
    Alumnos.NoBoleta
	from AdeudosMaterias
				  inner Join Materias
						on  Materias.IdMateria=AdeudosMaterias.IdMateria
				  inner Join AdeudosAlumno
						on AdeudosMaterias.IdAdeudo=AdeudosAlumno.IdAdeudo
				  inner Join Alumnos
						on Alumnos.NoBoleta=AdeudosAlumno.NoBoleta;
				
        
drop view if exists View_Alumno_Tutor;         
create view View_Alumno_Tutor as 
    select 
    Profesores.NombreP as Nombre,
    Profesores.APaternoP,
    Profesores.AMaternoP,
    Estados.Estado,
    Alumnos.NoBoleta
	from AlumnoProfesor
				  inner Join Profesores
						on  Profesores.NoEmpleado=AlumnoProfesor.NoEmpleado
				  inner Join Estados
						on Estados.IdEstado=AlumnoProfesor.IdEstado
				  inner join Alumnos
						on AlumnoProfesor.NoBoleta=Alumnos.NoBoleta;
select * from View_Alumno_Tutor;

select * from AdeudosMateriasAlumno;


