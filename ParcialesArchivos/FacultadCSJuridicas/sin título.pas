
program untitled;
const VA = 9999;
type
registroM = record
dni: integer;
carrera: integer;
monto: real;
end;

registroD = record
dni: integer;
codigo: integer;
monto: real;
end;

maestro = file of registroM;

detalle = file of registroD;

vectorD = array [1..N] of detalle;

vectorR = array [1..N] of registroD;

procedure leer (var D: detalle; var reg: registroD);
begin
	if not (eof (D)) then
		read(D,reg);
		else
		reg.dni:= VA;
end;

procedure minimo(var VR: vectorR; var VD: vectorD; var minimo: registroD);
var
i,pos: integer;
begin
	minimo.codigo := VA;
	pos:= -1;
	for i := 1 to N do begin
		if (VR[i].codigo < minimo.codigo) then begin
			minimo:= VR[i]
			pos:=i;
		end;
		end;
		if (pos <> -1) then 
		leer(VD[pos]);
end;

procedure actualizar (var M: maestro; var VD: vectorD; var VR: vectorR);
var
min: registroD;
regM: registroM;
i: integer;
begin
	reset(M);
	for i := 1 to N do begin
		reset(VD[i]);
		leer(VD[i],VR[i]);
		end;
	if not (eof (M)) then begin
		minimo(VR, VD, min);
		while (min.dni <> VA) do begin
			actual:= min.dni;
			read(M, regM);
			while(regM.dni <> actual) do begin
				read(M,regM);
				while(min.dni = actual) do begin
					regM.monto := regM.monto + min.monto;
					minimo(VR,VD,min);
					end;
					seek(filepos(M)-1);
					write(M, regM);
					end;
					end;
					end;
					close(M);
					for i := 1 to N do begin
						close(VD[i]);
						end;
end;

procedure exportar (var M: maestro; txt: Text);
begin
rewrite(txt);
reset(M);
while not (eof(M)) do begin
	read(M,regM);
	if (regM.monto = 0) then begin
		writeln(txt, dni, facultad, 'alumno moroso');
		read(M,regM);
		end;
		end;
	close(M);
	close(txt);
end;
var
M: maestro;
VR: vectorR;
VD: vectorD;
txt: Text;
i: integer;
BEGIN
	for i := 1 to N do begin
		read(nombre);
		assign(VD[i], nombre);
		end
	assign(M, 'maestro.dat');
	assign(txt, 'export.txt');
	actualizar(M, VD, VR);
	exportar(M, txt);
END.

