

program untitled;

const

type
registroMaestro = record;
codigo: integer;
nombre: string;
familia: string;
descripcion: string;
zona: string;
end;

maestro = file of registroMaestro;

procedure borradoLogico (var M: maestro);
var
regM: registroMaestro;
begin
	reset(M);
	encontrado:= false;
	while(not(eof(M))) and not encontrado do begin
		read(M, regM);
		if (regM. codigo = buscado) then
		encontrado:= true;
		end;
		if encontrado then begin
			regM.codigo:= -1;
			seek(M, filepos(M)-1);
			write(M,regM);
		end;
	end;
	close(M);
end;

procedure compactacion(var M: maestro);
ultimo,regM: registroMaestro;
posHueco: integer;
begin
	reset(M);
	while (not (eof(M))) do begin
		read(M, regM);
		if(regM. codigo < 0) then begin
			posHueco:= filepos(M)-1;
		
			seek(M, filepos(M)-1);
			read(M, ultimo);
		
			seek(M, posHueco);
			write(M, ultimo);
			
			seek(M, filesize(M)-1);
			truncate(M);
			seek(M, posHueco);
			end;
			end;
	close(M);
end;
var
M: maestro;
BEGIN
	
	
END.

