program untitled;
const 
valorAlto = 9999;

type

registroMaestro = record
provincia:integer;
localidad: integer;
mesa: integer;
votos: integer;
end;

maestro = file of registroMaestro

procedure leer(var M: maestro;var regM: registroMaestro)
begin
	if (not (eof(M))) then
		read(M,regM)
		else
		regM.provincia:=valorAlto;
		regM.localidad:=valorAlto;
	end;

procedure contabilizar(var M: maestro)
var
provinciaActual,localidadActual, totalProvincia, totalLocalidad,totalVotos: integer;
regM: registroMaestro;
begin
	reset(M);
	leer(M, regM);
	totalVotos:=0;
	while(regM.provincia <> valorAlto) do begin
		provinciaActual:= regM.provincia;
		totalProvincia:=0;
		writeln('codigo de provincia: ',provinciaActual);
		while(regM.provincia = provinciaActual) do begin
			totalLocalidad:=0;
			localidadActual:= regM.localidad;
			while (regM.provincia = provinciaActual) and (regM.localidad = localidadActual) do begin
				totalLocalidad:= totalLocalidad+ regM.votos;
				leer(M,regM)
			end;
			writeln(localidadActual, 'total localidad: ',totalLocalidad);
			totalProvincia:= totalProvincia + totalLocalidad;
		end;
		writeln('total provincia: ',totalProvincia);
		totalVotos:= totalVotos+totalProvincia;
	end;
	writeln('total votos: ', totalVotos);
	close(M);
end;

var
M: maestro;
BEGIN
assign(M,'maestro.dat');
contabilizar(M);
END.

