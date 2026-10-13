{

}
program untitled;
const
VA = 9999;
type
registroM = record;
codigo: integer;
nombre: string[20];
jugados: integer;
ganados: integer;
empatados: integer;
puntos: integer;
end;

registroFecha = record;
dia: integer;
mes: integer;
ano: integer;
end;

registroD = record;
codigo: integer;
fecha: registroFecha;
puntos: integer;
rival: integer;
end;

maestro = file of registroM;

detalle = file of registroD;

vectorRegistros = array [1..12] of registroD;
vectorDetalles = array [1..12] of detalle;

procedure leer(var D: detalle; var R: registroD);
begin
if not (eof (D)) then 
	read(D, R);
else
	R.codigo:= VA;
end;

procedure minimo (var VD: vectorDetalles; var VR: vectorRegistros; var min: registroD);
var
i, pos: integer;
begin
	min.codigo:= VA;
	pos:=-1;
	for i := 1 to 12 do begin
		if(VR[i].codigo < min.codigo) then begin
			min:= VR[i];
			pos:= i;
			end;
			end;
	if (pos <> -1) then
		leer (VD[pos], VR[pos]);
end;

procedure actualizarEInformar (var M: maestro; var VD: vectorDetalles; var VR: vectorRegistros);
var
mejorEquipo,regM: registroM;
min: registroD;
i,actual: integer;
begin
	reset(M);
	for i := 1 to 12 do begin
		reset(VD[i]);
		leer(VD[i], VR[i]);
	end;
	minimo(VD,VR,min);
	while(min.codigo <> VA) do begin
	actual:= min.codigo;
	read(M,regM);
	while (regM.codigo <> min.codigo) do 
	read(M,regM);
	while (min.codigo = actual) do begin
		regM.jugados:=regM.jugados+1;
		regM.puntos:= regM.puntos + min.puntos;
		if (min.puntos =3) then
			regM.ganados:= regM.ganados+1;
			else if (min.puntos =1) then
				regM.empatados:= regM.empatados +1;
		end;
		for i :=1 to 12 do begin
			if (regM.puntos > maxPuntos) then begin
				maxPuntos:= regM.puntos;
				maxNombre:= regM.nombre;
				end;
				end;
		end;
		writeln(maxPuntos.puntos);
		wrilteln(maxNombre.nombre);
		close(M);
		for i := 1 to 12 do begin
			close(VD[i]);
			end;
end;
var
M: maestro;
VD: vectorDetalles;
VR: vectorRegistros;
i: integer;
nombre: string[20];
BEGIN
assign(M,'maestro.dat');
for i := 1 to 12 do begin
	read(nombre);
	assign(VD[i], nombre);
	end;
	actualizarEInformar(M,VD,VR);
END.

