program untitled;
const
N = 10;
valorAlto = 9999;
type
registroDetalle = record
localidad: integer;
cepa: integer;
activos: integer;
nuevos:integer;
recuperados: integer;
fallecidos:integer;
end;

registroMaestro = record
localidad: integer;
nombre: string;
cepa: integer;
nombreCepa: integer;
activos: integer;
nuevos: integer;
recuperados: integer;
fallecidos: integer;
end;

detalle = file of registroDetalle;
maestro = file of registroMaestro;

arregloDetalles = array [1..N] of detalle;
arregloRegistros = array [1..N] of registroDetalle;
procedure leer(var archivo: detalle; var R: registroDetalle);
begin 
	if (not(eof(archivo))) then
		read(archivo, R)
	else begin
		R.localidad:=valorAlto;
		R.cepa:=valorAlto;
	end;
end;

procedure minimo (var vR:arregloRegistros; var vD: arregloDetalles; var min: registroDetalle);
var
i, indiceMin:integer;
begin
min.cepa := valorAlto;
min.localidad:= valorAlto;
indiceMin:=-1;
for i :=1 to N do begin
	if (vR[i].localidad < min.localidad) or ((vR[i].localidad = min.localidad) and (vR[i].cepa < min.cepa))
	then begin
	min := vR[i];
	indiceMin:=i
	end;
end;
if (indiceMin <> -1) then
	leer(vD[indiceMin], vR[indiceMin]);
end;




procedure actualizar(var M:maestro; var vD: arregloDetalles);
var
totalFallecidos, totalRecu,totalActivos,totalNuevos, i,localidadActual, cepaActual:integer;
vR: arregloRegistros;
min: registroDetalle;
regM: registroMaestro;
begin
	reset(M);
	for i := 1 to N do begin
		reset(vD[i]);
		leer(vD[i],vR[i]);
		end;
	minimo(vR,vD,min);
	while(min.localidad <> valorAlto) do begin
		totalFallecidos:=0;
		totalRecu:=0;
		totalActivos:=0;
		totalNuevos:=0;
		localidadActual:=min.localidad;
		cepaActual:=min.cepa;
		while(min.localidad = localidadActual) and (min.cepa = cepaActual) do begin
		totalFallecidos:= totalFallecidos +min.fallecidos;
		totalActivos:= totalActivos+ min.activos;
		totalNuevos:= totalNuevos+ min.nuevos;
		totalRecu:=totalRecu+min.recuperados;
		minimo(vR,vD,min);
		end;
		read(M,regM);
		while(regM.localidad <> localidadActual) or (regM.cepa <> cepaActual) do begin
				read(M, regM);
		regM.fallecidos := regM.fallecidos + totalFallecidos;
		regM.activos:= regM.activos+ totalActivos;
		regM.nuevos:= regM.nuevos+ totalNuevos;
		regM.recuperados := regM.recuperados+totalRecu;
		if (regM.activos > 50) then
			writeln('mas de 50 casos activos en: ', regM.nombre);
		seek(M, filepos(M)-1);
		write(M, regM);
		end;
		end;
		close(M);
	for i :=1 to N do begin
		close(vD[i]);
		end;
end;
var
M: maestro;
vD: arregloDetalles;
i:integer;
nombreFisico: string;
BEGIN
assign(M,'maestro.dat');
for i := 1 to N do begin
	Str(i,nombreFisico);
	Assign(vD[i],nombreFisico);
end;
actualizar(M, vD);
END.

