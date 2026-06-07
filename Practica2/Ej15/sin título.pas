

program untitled;

const
valorAlto = 9999
N = 10
type
registroMaestro = record
provincia: integer;
nombreP: string;
localidad: integer;
nombreL: string;
sinLuz: integer;
sinGas: integer;
deChapa: integer;
sinAgua:integer
sinSanitarios: integer;
end;

registroDetalle= record
provincia: integer;
localidad:integer;
conLuz:integer;
construidas: integer;
conAgua: integer;
conGas: integer;
sanitarios: integer;
end;

maestro = file of registroMaestro

detalle = file of registroDetalle

vectorDetalles = array [1..N] of detalle
vectorRegistros = array [1..N] of registroDetalle

procedure leer(var D: detalle; var regD: registroDetalle)
begin
	if (not (eof(D))) then
		read(D,regD);
	else begin
		regD.provincia:= valorAlto;
		regD.localidad:=valorAlto;
	end;
end;

procedure minimo(var V: vectorDetalles; var vR: vectorRegistros; var min: registroDetalle)
i; posMin: integer;
begin
	min.destino:= valorAlto;
	posMin:=-1;
	for i := 1 to N do begin
		if (vR[i].destino < min.destino) then begin
		min:=vR[i];
		posMin:=i;
		end;
	end;
	is (posMin <> -1) then
		leer(V[posMin],vR[posMin]);
end;

procedure actualizar(var M:maestro; var V: vectorDetalles; var vR: vectorRegistros)
var
regM: registroMaestro;
i,cantSinChapa: integer;
min: registroDetalle;
begin
	cantSinChapa:=0;
	reset(M);
	minimo(V,vR,min);
	while (not(eof(M))) do begin
		read(M, regM);
		if(regM.provincia = min.provincia) and (regM.localidad = min.localidad) then begin
			regM.sinLuz:= regM.sinLuz - min.conLuz;
			regM.sinAgua:= regM.sinAgua - min.conAgua;
			regM.deChapa:=regM.deChapa - min.construidas;
			seek(M, filepos(M)-1);
			write(M,regM);
			minimo(V,vR, min);
		end;
		if (regM.deChapa =0) then
			cantSinChapa:=cantSinChapa +1;
		end;
	writeln(cantSinChapa);
	close(M)
end;

var
M: maestro;
V: vectorDetalles;
vR: vectorRegistros;
i: integer;
BEGIN
	for i := 1 to N do begin
		reset(V[i]);
		leer(V[i], vR[i]);
	end
	actualizar(M,V,vR);
	for i := 1 to N do begin
		close(V[i]);
	end
END.

