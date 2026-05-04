
program untitled;

type
empleado = record 
codigo: integer;
nombre: string;
comision: integer;
end;

archivoEmpleado = file of empleado;

procedure comprimir (var archivoViejo, archivoComprimido: archivoEmpleado);
var e, actual: empleado;
codigoActual: integer;
total: integer;
begin
Reset(archivoViejo);
Rewrite(archivoComprimido);
if not (eof(archivoViejo))then
begin
Read(archivoViejo, e);
while not (eof (archivoViejo)) do begin
codigoActual := e.codigo;
total:= 0;
actual.codigo := e.codigo;
		actual.nombre := e.nombre;
	while(not eof (archivoViejo)) and (e.codigo = codigoActual) do begin
		
		total := total + e.comision;
		read (archivoViejo, e);
		end;
		actual.comision:= total;
		write(archivoComprimido, actual);
	end;
	Close(archivoViejo);
	Close(archivoComprimido);
end;
end;
var
archivoViejo, archivoComprimido: archivoEmpleado;
BEGIN
	Assign(archivoViejo, 'viejo.dat');
	Assign(archivoComprimido, 'compacto.dat');
	Comprimir(archivoViejo,archivoComprimido);
	Writeln('Compactado con exito');
	
END.

