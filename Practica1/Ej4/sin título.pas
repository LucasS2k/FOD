

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
 
 function buscar(var Es: empleados; numero: integer):boolean;
 var
 esta: boolean;
 E: empleado;
 begin
 reset(Es);
 esta:= false;
	while(not EOF(Es)) do begin
		read(Es, E);
		if (E.num = numero) then
		esta:=true;
	end;
	buscar:= esta;
 end;
 
 procedure exportarTodos(var Es: empleados);
 var
 E: empleado;
 T: text;
 nombreTXT: string;
 begin
	reset(Es);
	writeln('ingrese un nombre para su TXT: ');
	readln(nombreTXT);
	Assign(T, nombreTXT + '.txt');
	rewrite(T);
	while (not EOF (Es)) do begin
		read(Es, E);
		write(T, E.num , E.ape, E.nombre, E.DNI, E.edad);
	end;
	close(T);
	close(Es);
 end;
 
 procedure exportarSinDNI(var Es: empleados);
 var
 E: empleado;
 T: text;
 nombreTXT: string;
 begin
	reset(Es);
	writeln('ingrese un nombre para su TXT: ');
	readln(nombreTXT);
	Assign(T, nombreTXT + '.txt');
	rewrite(T);
	while (not EOF (Es)) do begin
		read(Es, E);
		if (E.DNI = 0) then
			write(T, E.num , E.ape, E.nombre, E.DNI, E.edad);
	end;
	close(T);
	close(Es);
 end;
 
 procedure modificarEdad(var Es: empleados);
 var
 nuevaEdad, busqueda: integer;
 E: empleado;
 encontrado: boolean;
 begin
 encontrado:= false;
 reset(Es);
 writeln('ingrese el codigo de empleado que desea modificar: ');
 readln(busqueda);
 while(not EOF (Es) and (not encontrado)) do begin
	read(Es, E);
	if (E.num = busqueda) then
	begin
		encontrado:= true;
		writeln('ingrese la nueva edad para: ',E.num);
		readln(nuevaEdad);
		E.edad:= nuevaEdad;
		seek(Es, FilePos(Es)-1);
		write(Es, E);
	end;
	if (encontrado = false) then
	writeln('empleado inexistente');
 end;
 end;
 
 
 
 
 procedure agregarEmpleado(var Es: empleados);
 var
 E: empleado;
 begin
 reset(Es);
 seek(Es, FileSize(Es));
 with E do begin
	writeln('ingrese el apellido: ');
	readln(ape);
	while(ape <> 'fin') do begin
		writeln('ingrese el codigo de empleado: ');
		readln(num);
		while buscar(Es, num) do begin
			writeln('ese codigo ya fue registrado ingrese otro: ');
			readln(num);
		end;
		writeln('ingrese el nombre:');
		readln(nombre);
		writeln('ingrese el DNI:');
		readln(DNI);
		writeln('ingrese la edad :');
		readln(edad);
		write(Es, E);
		write('guardado exitoso');
		writeln('ingrese otro apellido o "fin" para salir');
		readln(ape);
	end;
 
 end;
 end;
 
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
	writeln('4 para añadir uno o mas empleados');
	writeln('5 para modificar la edad de un empleado');
	writeln('6 para exportar el archivo a un txt');
	writeln('7 para exportar a un txt los empleados sin dni');
	readln(opcion);
	case opcion of
	1: buscarEmpleado(ES);
	2: imprimirMayores(Es);
	3: imprimirTodos(Es);
	4: agregarEmpleado(Es);
	5: modificarEdad(Es);
	6: exportarTodos(Es);
	else 
	writeln('opcion invalida, ingrese un numero del 1 al 3. ');
	end;
	close(Es);
END.
