drop database if exists ProyectoTutoriasFinal;
create database ProyectoTutoriasFinal;
use ProyectoTutoriasFinal;

		create table Carreras(
		IdCarrera int AUTO_INCREMENT  , 
		carrera varchar (40),
		primary key(IdCarrera)
		);
        
/*relacion carrera materias */
		create table Materias(
		IdMateria int not null AUTO_INCREMENT, /*nota*/
		Materia varchar(80) not null,
		primary key(IdMateria));
       
		create table Academia(
		IdAcademia int AUTO_INCREMENT ,
		Academia varchar(30) not null,
		primary key(IdAcademia)
		);
        
        create table Alumnos(
			NoBoleta varchar(20) not null,
			Contrasenia varchar(20) not null, 
			Nombre  varchar(30)not null ,
			APaterno varchar(20)not null ,
			AMaterno varchar(30)not null ,
			IdCarrera int not null, 
			Semestre int not null check(Semestre between 1 and 10),
			Sexo varchar(40) not null check (Sexo in ('Masculino','Femenino')),
			FechaNacimiento date not null,
			TelFijo varchar(10) null,
			Celular varchar(10) not null ,
			CorreoElectronico varchar(50) not null,
			primary key(NoBoleta),
			foreign key(IdCarrera) references Carreras(IdCarrera)
           );
           
		create table Profesores(
				NoEmpleado varchar(20) not null,
				ContraseniaP varchar(20) not null, 
				NombreP varchar(30)not null,
				APaternoP varchar(20)not null ,
				AMaternoP varchar(30)not null ,
				IdAcademia int not null,
				Turno varchar(13)  not null check (Turno in ('Matutino','Vespertino','Mixto')),
				ClaveAcepta varchar(10)not null,
				primary key(NoEmpleado),
				foreign key(IdAcademia) references Academia(IdAcademia)
		);
        
		create table AlumnoProfesor (
			IdAlumnoProfesor int not null auto_increment,
			NoBoleta varchar(20) not null,
			NoEmpleado varchar(20) not null,
			ClaveAceptaR varchar(10)not null,
			State varchar(20) not null,
			primary key(IdAlumnoProfesor),
			foreign key(NoBoleta) references Alumnos(NoBoleta),
			foreign key(NoEmpleado) references Profesores(NoEmpleado)
			);
        drop table if exists AlumnoProfesorV;
		create table AlumnoProfesorV ( /*restriccion clave de aceptacion repeticion*/
				IdAlumnoProfesor int not null auto_increment,
				NoBoleta varchar(20) not null,
				ClaveAceptaR varchar(10)not null,
				State varchar(20) not null,
				primary key(IdAlumnoProfesor),
				foreign key(NoBoleta) references Alumnos(NoBoleta)
				);
        
        create table Historial(
				idHistorial int auto_increment,
				IdAlumnoProfesor int,
				Fecha date not null,
				StateH varchar(20) not null,
				primary key (idHistorial),
				foreign key(IdAlumnoProfesor) references AlumnoProfesor(IdAlumnoProfesor)
		);
		create table Adeudos(
				idAdeudo int auto_increment,
				NoBoleta varchar(20) not null,
				IdMateria int not null,
				primary key (idAdeudo),
				foreign key(NoBoleta) references Alumnos(NoBoleta),
				foreign key(IdMateria) references Materias(IdMateria)
			);

insert into Carreras(carrera) values ("Ingenieria Telemática");
insert into Carreras(carrera) values ("Ingenieria Mecatrónica");
insert into Carreras(carrera) values ("Ingenieria Bionica");
insert into Carreras(carrera) values ("Ingenieria en Energia");
insert into Carreras(carrera) values ("Ingenieria en Sistemas Automotrices");

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

insert into Academia(Academia) values ("Telemática");
insert into Academia(Academia) values ("Mecatronica");
insert into Academia(Academia) values ("Bionica");
insert into Academia(Academia) values ("ISISA");
insert into Academia(Academia) values ("Administración");
insert into Academia(Academia) values ("Humanidades");
insert into Academia(Academia) values ("Ingles");
insert into Academia(Academia) values ("Cultura y deporte");
insert into Academia(Academia) values ("Quimica y Biologia");
insert into Academia(Academia) values ("Ciencias Basicas");
insert into Academia(Academia) values ("Electronica");
insert into Academia(Academia) values ("Informatica");
insert into Academia(Academia) values ("Mecanica");
insert into Academia(Academia) values ("Sistemas");

/*insert into Alumnos values (2015040720,"12345","Nadia","Lopez","Tirado", 1 , 12,"Femenino","1999-05-18","58302940","5523258868", "nadia18_lopez@hotmail,com");
 insert into Alumnos values (2015040720,"12345","Nadia","Lopez","Tirado", 1 , 6,"Mujer","1999-05-18","58302940","5523258868", "nadia18_lopez@hotmail,com"); comprobar checks de esta tabla */ 
insert into Alumnos values ("2015030720","12345","Nadia","Lopez","Tirado", 1 , 4 ,"Femenino","1999-05-18","58302940","5523258868", "nadia18_lopez@hotmail,com");
insert into Alumnos values ("2015170720","123","Mauricio","Sanchez","Moreno", 1 , 4 ,"Masculino","1999-09-19","55555555","5585963625", "mauricio@hotmail,com");
insert into Alumnos values ("2015070720","12","Ricardo","Flores","Lima", 1 , 4 ,"Masculino","1999-01-13","58888888","5556465544", "ricardo@hotmail,com");
insert into Alumnos values ("2015020720","12345","Maria","Hernandez","Perez", 2 , 6 ,"Femenino","1999-10-18","58302940","5523258868", "maria_lopez@hotmail,com");

/*insert into Profesores values ("2589654510","123456","Marcela","Hernandez","Perez", 1 , "Mañana","12345678"); comprobar check*/
insert into Profesores values ("2589654510","123456","Marcela","Hernandez","Perez", 1 , "Matutino","12345678");
insert into Profesores values ("2576767687","1234","Hugo","Gonzalez","Casas", 1 , "Vespertino","123456789");
insert into Profesores values ("2345567890","12348","Martha","Hernandez","Hernandez", 1 , "Mixto","123456781");

/*insert into AlumnoProfesorV(NoBoleta,NoEmpleado,ClaveAceptaR,State) 
values ("2015030720","2345567890","123456785","pendiente"); comprobar clavee*/

/*insert into AlumnoProfesorV(NoBoleta,ClaveAceptaR,State) 
          values ("2015030720","123456781","pendiente"); <------------------PRUEBA*/
/*insert into AlumnoProfesorV(NoBoleta,NoEmpleado,ClaveAceptaR,State) 
         values ("2015070720","2576767687","12","aceptado");
insert into AlumnoProfesorV(NoBoleta,NoEmpleado,ClaveAceptaR,State) 
         values ("2015170720","2589654510","12345678","pendiente");
insert into AlumnoProfesorV(NoBoleta,NoEmpleado,ClaveAceptaR,State) 
         values ("2015020720","2589654510","12345678","pendiente");*/
         
         
 /*Poner dos botones, tienes adeudos  sí y no, si es sí que mande un formulario para seleccionar materia una por una*/
INSERT into Adeudos(NoBoleta, IdMateria) values("2015030720","5");
INSERT into Adeudos(NoBoleta, IdMateria) values("2015030720","1");
    
     /***********INICIAR SESION*********/   
drop procedure if exists InicioSesionAlumno;
delimiter **
create procedure InicioSesionAlumno(in usre nvarchar(20),in pswe nvarchar(20))
begin

declare num int;
declare msj varchar(30);
declare validar int(20) ;
declare validar2 varchar(30);
	set validar= (select NoBoleta from Alumnos  where NoBoleta = usre);
	set validar2= (select contrasenia from Alumnos  where contrasenia = pswe and NoBoleta = usre);
   	if(validar =usre and validar2=pswe)then
		   set msj="INICIAR SESION ADMIN";
        else
		   set msj="ERROR EN EL USUARIO PRRO";
    end if;
select msj as Resultado;
end; **
delimiter ;

 /***********COMPARAR CLAVE DE ACEPTACION*********/   
drop trigger if exists Tutor;
delimiter **
create trigger Tutor after insert on AlumnoProfesorV
 FOR EACH ROW 
begin 
declare validar varchar(20);
declare empleado varchar(20);
set empleado=(select NoEmpleado from Profesores where ClaveAcepta=new.ClaveAceptaR);
set validar= (select ClaveAcepta from Profesores where ClaveAcepta=new.ClaveAceptaR );
if (validar=new.ClaveAceptaR) then
insert into AlumnoProfesor(NoBoleta,NoEmpleado,ClaveAceptaR,State) 
       values (new.NoBoleta,empleado,new.ClaveAceptaR,new.State);
       end if;
end;**



/***********CAMBIAR ESTADO CUANDO PROFESOR ACEPTA TUTORADO Y LLENAR HISTORIAL*********/   
drop trigger if exists CambioStatus;
delimiter **
create trigger CambioStatus after update on AlumnoProfesor /*Cambiar update cuando profesor acepte*/
 FOR EACH ROW 
begin 

if (new.State="aceptado") then
	   insert into Historial(idAlumnoProfesor, Fecha, StateH) 
       values (new.idAlumnoProfesor,now(),"activo") ;
	             
       end if;
end;**

/***********ACEPTAR ALUMNO*********/   
drop procedure if exists AceptarTutorado;
delimiter **
create procedure AceptarTutorado(in boleta varchar(20), in empleado varchar(20))
begin
	update AlumnoProfesor
			set State="aceptado"
             where NoBoleta=boleta and NoEmpleado=empleado;
    update AlumnoProfesorV
			set State="aceptado"
             where NoBoleta=boleta;         
		end; **
delimiter ;

/*call AceptarTutorado("2015030720","2345567890"); <------------------PRUEBA*/
/*call AceptarTutorado("2015030720","2576767687"); Acepta nuevo tutor*/


 /***********RECHAZAR UN ALUMNO*********/   
 
drop procedure if exists RechazarTutorado;
delimiter **

create procedure RechazarTutorado(in boleta varchar(20), in empleado varchar(20))
begin
	update AlumnoProfesor
			set State="rechazado"
             where NoBoleta=boleta and NoEmpleado=empleado;
		end; **
delimiter ;

/*call RechazarTutorado("2015030720","2345567890"); <------------------PRUEBA */

/***********CONSULTAR TUTOR*********/   
drop procedure if exists ConsultarTutor;
delimiter **
create procedure ConsultarTutor(in boleta varchar(20))
begin
	select NombreP, APaternoP, AMAternoP, AlumnoProfesor.IdAlumnoProfesor from Profesores,AlumnoProfesor, Historial
    where NoBoleta=boleta and AlumnoProfesor.IdAlumnoProfesor=Historial.IdAlumnoProfesor and StateH="activo"
    and AlumnoProfesor.NoEmpleado=Profesores.NoEmpleado;
   end; **
delimiter ;

/*call ConsultarTutor("2015030720"); <------------------PRUEBA*/

/***********CONSULTAR ALUMNOS DE UN TUTOR*********/ 
drop procedure if exists ConsultarAlumnos;
delimiter **
create procedure ConsultarAlumnos(in empleado varchar(20))
begin
	select Nombre, APaterno, AMAterno, AlumnoProfesor.IdAlumnoProfesor from Alumnos,AlumnoProfesor, Historial
    where NoEmpleado=empleado and AlumnoProfesor.IdAlumnoProfesor=Historial.IdAlumnoProfesor and StateH="activo"
    and AlumnoProfesor.NoBoleta=Alumnos.NoBoleta;
end; **
delimiter ;

/*call ConsultarAlumnos("2345567890"); <------------------PRUEBA*/
/*trigger hasta 5 tutores */
/*INGRESAR UN NUEVO TUTOR*/
drop procedure if exists NuevoTutor;
delimiter **
create procedure NuevoTutor(in boleta varchar(20),in clave varchar(20))
begin
declare validar int;
set validar= (select IdAlumnoProfesor from AlumnoProfesor where NoBoleta=boleta);
update Historial 
set StateH="inactivo"
where IdAlumnoProfesor=validar;

update AlumnoProfesorV
set State="finalizado"
where NoBoleta=boleta;
insert into AlumnoProfesorV(NoBoleta,ClaveAceptaR,State) 
       values (boleta, clave,"pendiente");

       
       end; **
delimiter ;

/*call NuevoTutor("2015030720", "123456789"); <------------------PRUEBA */


/*Visualizar Tablas*/
select*from Academia;
select*from  Materias;
select*from  AlumnoProfesor;
select*from AlumnoProfesorV;
select*from Alumnos;
select * from Profesores;
select * from Carreras; 
select * from Historial;  /*historial de rechazo*/

/**********************views******************/

drop view if exists Historial_Pendientes;
Create VIEW Historial_Pendientes AS 
			SELECT * FROM AlumnoProfesor
				WHERE State = "Pendiente";  
 
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
       Historial.StateH as "Status"
    FROM Alumnos INNER JOIN AlumnoProfesor 
						ON AlumnoProfesor.NoBoleta = Alumnos.NoBoleta
				INNER JOIN Historial 
						ON AlumnoProfesor.IdAlumnoProfesor=Historial.IdAlumnoProfesor
								WHERE Historial.StateH="aceptado";
                                
/***************Visualizar vistas*************/                          
select * from Tutores_Activos;
select *from Historial_Pendientes ;
select *from Vista_Alumnos;
                            
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
/*olvido de contraseña, confirmacion de nueva contraseña*/
 

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
             from AlumnoProfesorV 
             group by NoBoleta=boleta);
  if (num> 5) then
             set msj="TIENES QUE ACUDIR A LA OFICINA DE TUTORIAS";
             select msj as Resultado;
             else 
             select NoBoleta,count(*) 
			 as "Numero de Tutores en su Historial" 
             from AlumnoProfesorV 
             group by NoBoleta=boleta;
             end if;
	

end; **
delimiter ;
/*call Numero_Tutores("2015030720"); <------------------PRUEBA*/


/*---------------------------------------------------------------------------Dorime-----------------------------------------------------------------------------*/ 

select *from Vista_Alumnos where NoBoleta=2015020720;
select * from AlumnoProfesor  where NoEmpleado=2589654510;
SELECT* FROM HISTORIAL;
select *from Profesores;


	drop view if exists EstadoTutorados;	
	create view EstadoTutorados as 
	SELECT 
		   Alumnos.Nombre as "Nombre(s)",
		   Alumnos.APaterno as "Apellido Paterno",
		   Alumnos.AMaterno as "Apellido Materno",
		   Alumnos.NoBoleta as "Numero de Boleta",
		   Profesores.NoEmpleado,
		   Historial.StateH
		FROM Alumnos INNER JOIN AlumnoProfesor 
							ON AlumnoProfesor.NoBoleta = Alumnos.NoBoleta
					Inner JOIN Profesores 
							On AlumnoProfesor.NoEmpleado=Profesores.NoEmpleado
					Inner join Historial
							ON AlumnoProfesor.IdAlumnoProfesor=Historial.IdAlumnoProfesor;

/*insert into AlumnoProfesorV(NoBoleta,ClaveAceptaR,State) 
         values ("2015070720","12","aceptado");
insert into AlumnoProfesorV(NoBoleta,ClaveAceptaR,State) 
         values ("2015170720","12345678","pendiente");
insert into AlumnoProfesorV(NoBoleta,ClaveAceptaR,State) 
         values ("2015020720","12345678","pendiente");
select *from EstadoTutorados where NoEmpleado=2345567890;*/

drop view if exists DatosProfesor;	
	create view DatosProfesor as 
	SELECT 
		   Profesores.NombreP as "Nombre(s)",
		   Profesores.APaternoP as "Apellido Paterno",
		   Profesores.AMaternoP as "Apellido Materno",
		   Profesores.NoEmpleado
		FROM Profesores; 
        
   select *from DatosProfesor where NoEmpleado=2345567890;
   
   
   
create  view Tutor_Tutorado as 
SELECT
	Alumnos.NoBoleta,
    Alumnos.Nombre as "Nombre(s)",
    Alumnos.APaterno as "Apellido Paterno",
    Alumnos.AMaterno as "Apellido Materno",
    profesores.NoEmpleado, 
    alumnoprofesor.State "Estado"
    FROM Alumnos INNER JOIN AlumnoProfesor 
						ON AlumnoProfesor.NoBoleta = Alumnos.NoBoleta
				INNER JOIN profesores
						ON alumnoprofesor.NoEmpleado=profesores.NoEmpleado;
					
                        
 select *from Tutor_Tutorado where NoEmpleado="2589654510";
 select Materia from Materias;
 
 select *from adeudos;


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
						on adeudos.IdMateria=materias.IdMateria;
                        
		select *from Adeudos_Materia where NoBoleta='2015070720';
        
        select *from profesores;
        
        select *from Academia;
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
                        
                        
select *from Profesores_Tutores; 




