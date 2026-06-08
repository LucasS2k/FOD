program untitled;
const

type
registroMaestro = record;
nombre: string;
lanzamiento: integer;
version: integer;
devs: integer;
descripcion: string;
end;

maestro = file of registroMaestro;

procedure buscarDistribucion(var M: maestro; distribucion: string; var pos: integer);
var
regM: registroMaestro;
posActual: integer;
begin
	reset(M);
	seek(M, 1);
	pos:= -1;
	while (not (eof(M))) and (pos = -1) do begin
		posActual:= filepos(M);
		read(M, regM);
		if(regM.nombre = distribucion) then
			pos:= posActual;
		end;
	close(M);
end;

procedure altaDistribucion(var M: maestro; regM: registroMaestro);
var
hueco, cabecera, nrrlibre: registroMaestro;
pos: integer;
begin
	reset(M);
	buscarDistribucion(M, regM.nombre, pos);
	if (pos <> -1) then begin
		seek(M, 0);
		read(M, cabecera);
		if (cabecera.devs > 0) then begin
			nrrlibre:= abs(cabecera.devs);
			seek(M, nrrlibre);
			read(M, hueco);
			
			seek(M, 0);
			write(M, hueco);
			
			seek(M, nrrlibre);
			write(M, regM);
			end;
			else begin
			seek(M, filepos(M));
			write(M, regM);
			end;
	end;
	else writeln('ya existe la distribucion');
	close(M);
end;

procedure bajaDistribucion(var M: maestro; distribucion: string);
var
pos: integer;
nrr,cabecera, regM: registroMaestro;
begin
	reset(M);
	buscarDistribucion(M, distribucion, pos);
	if (pos = -1) then 
	writeln('distribucion no existente')
	else begin
		while(not(eof(M))) do begin
			nrractual:= filepos(M);
			read(M, regM);
			if (regM.distribucion = distribucion) then begin
				seek(M, 0);
				read(M, cabecera);
				
				regM.devs:= cabecera.devs;
				
				write(M, regM);
				
				cabecera.devs:= nrractual * (-1);
				
				seek(M,0);
				write(M, cabecera);
				end;
			end;
			end;
			end;
			close(M);
end;
var
BEGIN
	
	
END.

