


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
var
	Es: empleados;
	E: empleado;
	nomArch: string;
BEGIN
	writeln('ingrese el nombre del archivo: ');
	readln(nomArch);
	Assign(Es, nomArch + '.dat');
	rewrite(Es);
	with E do begin
		writeln('ingrese el numero de empleado: ');
		readln(num);
		writeln('ingrese el apellido: ');
		readln(ape);
	while(ape <> 'fin') do begin
		writeln('ingrese el nombre: ');
		readln(nombre);
		writeln('ingrese la edad: ');
		readln(edad);
		writeln('ingrese el dni: ');
		readln(DNI);
		write(Es, E);
		writeln('ingrese el numero de empleado: ');
		readln(num);
		writeln('ingrese el apellido: ');
		readln(ape);
	end;
	end;
	close(Es);
END.

