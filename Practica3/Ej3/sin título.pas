
program untitled;
const
valorAlto = 9999;
type
registroMaestro = record;
codigo: integer;
genero: string;
titulo: string;
autor: string;
paginas:integer;
precio: real;
end;

maestro = file of registroMaestro;

procedure crearArchivo (var M: maestro);
regM: registroMaestro;
begin
	rewrite(M);
	regM.codigo:=0;
	write(M, regM);
	close(M);
	writeln('archivo inicializado para listas invertidas');
end;

procedure darDeAlta(var M:maestro);
libro, cabecera, hueco: registroMaestro;
nrrlibre: integer;
begin
	reset(M);
	writeln('ingrese el codigo o 0 para terminar');
	read(libro.codigo);
	while(libro.codigo <> 0) do begin
		readln(libro.genero);
		readln(libro.titulo);
		readln(libro.autor);
		readln(libro.paginas);
		readln(libro.precio);
		
		seek(M, 0);
		read(M, cabecera);
		if (cabecera.codigo < 0) then end
			nrrlibre := abs(cabecera.codigo);
			seek(M, nrrlibre);
			read(M, hueco);
			
			seek(M, 0);
			write(M, hueco);
			
			seek(M, nrrlibre);
			write(M,libro);
			end;
		else begin
			seek (M,filesize(M));
			write(M,libro);
			end;
		readln(libro.codigo);
	end;
	close(M);
end;

procedure modificar(var M: maestro);
buscado: integer;
begin
	reset(M);
	read(buscado);
	while (libro.codigo <> buscado) do begin
		read(M, libro);
	end;
		readln(libro.genero);
		readln(libro.titulo);
		readln(libro.autor);
		readln(libro.paginas);
		readln(libro.precio);
		seek(M, filepos(M)-1);
		write(M.libro);
	close(M);
end;

procedure eliminar(var M: maestro);
regM,cabecera: registroMaestro;
buscado: integer;
encontrado: boolean;
begin
	encontrado:=false;
	read(buscado);
	reset(M);
	seek(M,1); {para evitar a la cabecera}
	while (not(eof(M))) and not econtrado do begin
		nrractual:= filepos(M);
		read(M, regM);
		if (regM.codigo = buscado) then
			encontrado:=true;
	end;
	if encontrado then begin
		seek(M, 0);
		read(M, cabecera);
		regM.codigo:=cabecera.codigo;
		write(M, regM);
		
		cabecera.codigo:= nrrActual *(-1);
		seek(M, 0);
		write(M,cabecera);
		end;
		else 
		writeln('codigo no encontrado');
	close(M);
end;

procedure exportar (var M: maestro)
T: text;
begin
	reset(M);
	rewrite(T);
	while(not(eof(M))) do begin
		read(M, regM);
		writeln(T, regM.codigo ,'',regM.genero ,'',regM.titulo ,'',regM.autor ,'',regM.paginas ,'',regM.precio ,'')
	end;
	close(M);
	close(T);
end;

procedure mantenimiento(var M: maestro);
opcion: integer;
begin
	read(opcion);
	case opcion of
		1: darDeAlta(M);
		2: modificar(M);
		3: eliminar(M);
		end;
end;
var
opcion: integer;
BEGIN
read(opcion)
case opcion of 
	1: crearArchivo(M);
	2: mantenimiento(M);
	3: exportarLimpio(M);
	end;
END.

