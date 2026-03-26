

program untitled;
  type
  arch_Enteros = file of integer;
  var
 archEnteros:arch_Enteros;
 num, total, cant, menores: integer;
 promedio: real;
 nombre: string;
BEGIN
	menores:= 0;
	total:= 0;
	cant:= 0;
	promedio:=0;
	writeln('ingrese el nombre del archivo a informar');
	readln(nombre);
	Assign(archEnteros, nombre + '.dat');
	reset(archEnteros);
	while(not EOF(archEnteros))do begin
	read(archEnteros, num);
	if (num < 15000) then
		menores:= menores +1;
	cant := cant+1;
	total:= total+ num;
	writeln(num);
	end;
	close(archEnteros);
	promedio:= total / cant;
	writeln('promedio:', promedio:0:2);
	writeln('menores a 15000: ', menores);
END.

