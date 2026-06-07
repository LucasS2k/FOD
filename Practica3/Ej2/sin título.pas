program untitled;
const
valorAlto = 9999;
type
 registroMaestro = record
 codigo: integer;
 nombre: string;
 descripcion: string;
 precio: real;
 stock: integer;
 end;

maestro = file of registroMaestro;

procedure agregarProducto (var M: maestro);
var
P: registroMaestro;
begin
	reset(M);
	seek(M, fileSize(M));
	with P do begin
		read(codigo);
		while (codigo <> valorAlto) do begin
			readln(nombre);
			readln(descripcion);
			readln(precio);
			readln(stock);
			write(M, P);
			writeln('guardado exitoso ingrese otro producto o 9999 para finalizar');
			read(codigo);
			end;
			end;
end;	

procedure bajaLogica (var M: maestro);
var
regM: registroMaestro;
begin
	reset(M);
	while (not(eof(M))) do begin
		read(M, regM);
		if (regM.stock = 0) then begin
			regM.nombre:= '@'+regM.nombre;
			seek(filepos(M)-1);
			write(M,regM);
			end;
	end;
	close(M);
end;






var
M: maestro;
BEGIN
rewrite(M);
agregarProducto(M);
bajaLogica(M);
END.

