


program untitled;

type
archivo_enteros= file of integer;

var archEnteros: archivo_enteros;
nombreArchivo: string;
num: integer;

BEGIN
	writeln('ingrese el nombre del archivo');
	readln(nombreArchivo);
	Assign(archEnteros, nombreArchivo + '.dat');
	Rewrite (archEnteros);
	writeln('ingrese un entero');
	readln(num);
	while(num <> 3000) do begin
	write(archEnteros, num);
	writeln('ingrese un entero');
	readln(num);
	end;
	close(archEnteros);
END.

