

program untitled;

type
 empleado = record
	num: integer;
	ape: string;
	nombre: string;
	edad: integer;
	DNI: integer;
	end;
 empleados= file of empleado;
 
 procedure imprimirEmpleado(E: empleado);
 begin
	with E do begin
	writeln('nombre: ', nombre);
	writeln('apellido: ',ape);
	writeln('DNI: ', DNI);
	writeln('edad: ', edad);
	writeln('numero de empleado: ', num);
	writeln('________________________')
 end;
 end;
 
 procedure imprimirTodos(var Es: empleados);
 var
 E: empleado;
 begin
	with E do begin
	while (not EOF (Es)) do begin;
		Read(Es, E);
		imprimirEmpleado(E);
	end;
 end;
 end;
 
 procedure imprimirMayores(var Es: empleados);
 var
 E:empleado;
 begin
	with E do begin
		while(not EOF (Es)) do begin
			read (Es, E);
			if (E.edad > 70) then
				imprimirEmpleado(E);
	end;
 end;
 end;
 
 procedure buscarEmpleado(var Es: empleados);
 var 
 buscado: string;
 E: empleado;
 begin
 writeln('ingrese nombre o apellido a buscar');
	readln(buscado);
	while(not EOF(Es)) do begin
			read(Es, E);
		if(E.nombre = buscado) or (E.ape = buscado) then
			imprimirEmpleado(E);
	end;
	end;
var
	Es: empleados;
	nomArch: string;
	opcion: integer;
BEGIN
	
	writeln('ingrese el nombre del archivo: ');
	readln(nomArch);
	Assign(Es, nomArch + '.dat');
	reset(Es);
	writeln('Elija una opcion: ');
	writeln('1 para buscar un empleado');
	writeln('2 para mostrar los empleados proximos a jubilarse');
	writeln('3 para listar a todos los empleados');
	readln(opcion);
	case opcion of
	1: buscarEmpleado(ES);
	2: imprimirMayores(Es);
	3: imprimirTodos(Es);
	else 
	writeln('opcion invalida, ingrese un numero del 1 al 3. ');
	end;
	close(Es);
END.

