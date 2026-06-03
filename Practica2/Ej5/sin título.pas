
program untitled;
const
valorAlto = 9999;
type

registro = record;
usuario: integer;
fecha: integer;
tiempo: integer;
end;

registroMaestro = record
usuario: integer;
fecha: integer;
tiempototal: integer;
end;

maestro = file of registroMaestro;
detalle = file of registro;
arreglo_registros = array [1..5] of registro
arreglo_detalle = array [1..5] of detalle;

procedure minimo(var vD: arreglo_detalle; var vR: arreglo_registros; var min: registro)
var
i, indiceMin: integer;
begin
	min.usuario:=valorAlto;
	min.fecha:=valorAlto;
	indiceMin:=-1;
	for i := 1 to 5 do begin
		if (vR[i].usuario < min.usuario) or ((vR[i].usuario = min.usuario) and (vR[i].fecha < min.fecha)) then begin
			min:= vR[i];
			indiceMin:=i;
			end;
			end;
	if (indiceMin<> -1) then 
		leer(vD[indiceMin], vR[indiceMin]);
end;

procedure leer (var archivo: detalle; var regD: registro);
begin
	if(not(eof(archivo))) then
		read(archivo, regD);
		else
		regD.usuario:= valorAlto;
		regD.fecha:=valorAlto;
end;


procedure actualizar (var aM: maestro; var vD: arreglo_detalle)

var
total,i,actual,fechaactual: integer;
vR: arreglo_registros;
regM: registroMaestro
min: registro;
begin
	rewrite(aM);
	for i :=1 to 5 do begin
		reset(vD[i]);
		leer(vD[i], vR[i])
		end;
	minimo(vD, vR, min)
	while(min.usuario<> valorAlto) do begin
		actual:= min.codigo;
		total:=0;
		while(min.usuario = actual) and (min.fecha = fechaactual)do begin
			total:= total+ min.tiempo;
			minimo(vD,vR,min);
		end;
		regM.usuario:= actual;
		regM.fecha:=fechaactual;
		regM.tiempo:= total
		write(aM, regM);
	end;
	end;
	for i :=1 to 5 do begin
		close(vD[i]);
	close(aM);
end;

var
M :maestro;
vD: arreglo_detalle;
i: integer;
nombrefisico: string
BEGIN
assign(maestro,'/var/log/maestro.dat');
for i := 1 to 5 do begin
	Str(i, nombrefisico)
	nombre:= 'detalle'+nombrefisico+,'.dat';
	assign(vD[i],nombre);
end;
actualizar(M, vD);
END.

