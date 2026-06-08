program untitled;

const

type
registroMaestro = record
codPrenda: integer;
descripcion: string;
colores: string;
tipoPrenda: string;
stock: integer;
precio; real;
end;

registroDetalle = record
codigo: integer;
end;

maestro = file of registroMaestro

detalle = file of registroDetalle

procedure procesarBajas(var M: maestro; var D:detalle)
regM: registroMaestro;
codigo,aBorrar: integer;
begin
	reset(M);
	reset(D);
	while(not(eof(D))) do begin
		read(D, regD);
		aBorrar:= regD.codigo;
		seek(M,1);
		while(not(eof(M))) do begin
			read(M, regM);
			if (regM.codigo = aBorrar) then begin
				regM.codigo:= -1;
				seek(M, filepos(M)-1);
				write(M, regM);
			end;
		end;
		end;
		close(D);
		close(M);
end;

procedure efectivizarBajas(var M: maestro);
regM: registroMaestro;
nuevo: maestro;
begin
	reset(M);
	rewrite(nuevo);
	while (not(eof(M))) do begin
		read(M,regM);
		if(regM. codigo > 0) then
			write(nuevo, regM);
	end;
	close(M);
	close(nuevo);
	rename(M,'respaldo.dat');
	rename(nuevo,'maestro.dat');
end;

var
BEGIN
	
	
END.

