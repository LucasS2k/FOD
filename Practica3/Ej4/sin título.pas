program untitled;

type

registroFlor = record;
nombre: string;
codigo: integer;
end;

maestro = file of registroFlor;

procedure agregarFlor(var M: maestro; nombre: string; codigo: integer)
var
hueco,cabecera,regM: registroFlor;
begin
	regM.nombre:= nombre;
	regM.codigo:=codigo;
	reset(M);
	seek(M, 0);
	read(M,cabecera);
	if (cabecera.codigo < 0) then begin
		nrrlibe:= abs(cabecera.codigo);
		seek(nrrlibre);
		read(M, hueco);
		
		seek(M,0);
		write(M,hueco);
		
		seek(M,nrrlibre);
		
		write(M, regM);
	end;
	else begin
		seek(M, filesize(M));
		write(M, regM);
	end
	close(M);
end;

procedure listar (var M: maestro);
regM: registroFlor;
begin
	reset(M);
	if (not(eof (M))) then seek (M,1);
	while(not(eof(M))) do begin
		read(M, regM);
		if (regM.codigo > 0) then begin
			write(regM.codigo);
			write(regM.nombre);
		end;
		end;
		close(M);
end

procedure eliminarFlor(var M: maestro; flor: registroFlor);
regM,cabecera: registroFlor;
buscado: integer;
encontrado: boolean;
begin
encontrado:= false;
buscado:= flor.codigo;
while (not(eof(M))) and not encontrado do begin
	nrractual:= filepos(M);
	read(M, regM);
	if (regM.codigo = buscado) then
	encontrado:= true;
	if encontrado then begin
		seek(M, 0);
		read(M, cabecera);
		
		regM.codigo:= cabecera.codigo;
		
		write(M, regM);
		
		cabecera.codigo:=(nrractual *(-1));
		seek(M,0);
		write(M,cabecera);
	end;
	end;
end;

BEGIN
	
	
END.

