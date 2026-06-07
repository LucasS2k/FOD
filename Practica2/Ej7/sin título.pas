

program untitled;

const
valorAlto = 9999;
type
registroMae = record
codigo: integer;
ape: string;
nom: string;
cursadas: integer;
finales: integer;
end;

registroCursadas = record
codigo: integer;
materia: integer;
anio: integer;
resultado: integer;
end;

registroFinales = record
codigo: integer;
materia: integer;
fecha: integer;
nota: integer;
end;

maestro = file of registroMae;

detalleCursadas = file of registroCursadas;

detalleFinales = file of registroFinales;

procedure leerCursada(var archivo: detalleCursadas; var R: registroCursadas);
begin
if (not (eof(archivo))) then 
	read(archivo, R)
	else
	R.codigo:=valorAlto;
end;

procedure leerFinal(var archivo: detalleFinales; var R: registroFinales);
begin
	if (not (eof(archivo))) then
		read(archivo,R)
		else
	R.codigo:=valorAlto;
end;

procedure minimo(var dC: detalleCursadas; var dF:detalleFinales; var regC:registroCursadas; var regF:registroFinales; var min:integer);

begin
	if (regC.codigo <= regF.codigo) then
	begin
	min:= regC.codigo;
	if (min <> valorAlto) then
		leerCursada(dC, regC)
	else begin
	min := regF.codigo;
	if (min <> valorAlto) then begin
		leerFinal(dF, regF);
	end;
	end;
	end;
end;

procedure actualizar (var M: maestro; var dC: detalleCursadas; var dF: detalleFinales);
var
regM: registroMae;
regC: registroCursadas;
regF: registroFinales;
min: integer;
begin
	reset(M);
	reset(dC);
	reset(dF);
	leerCursada(dC, regC);
	leerFinal(dF,regF);
	minimo(dC, dF,regC,regF,min);
	while(min <> valorAlto)do begin
		read(M,regM);
		while(regM.codigo <> min) do 
			read(M, regM);
		while(min = regM.codigo) do begin
			regM.codigo:= min;
			regM.finales:= regM.finales + 1;
			if (regC.codigo = min) then
				begin
					if (regC.resultado > 4) then
					regM.cursadas:= regM.cursadas +1;
				end;
			if (regF.codigo = min) then begin
				if (regF.nota > 4) then
				regM.finales:= regM.finales +1;
			end;
			minimo(dC, dF,regC,regF,min);
			end;
	seek(M,filepos(M)-1);
	write(M,regM);
	end;
	close(M);
	close(dC);
	close(dF);
end;
var
M: maestro;
dC:detalleCursadas;
dF:detalleFinales;

BEGIN
assign(M, 'maestro.dat');
assign(dC,'cursadas.dat');
assign(dF,'finales.dat');
actualizar(M,dC,dF);
END.

