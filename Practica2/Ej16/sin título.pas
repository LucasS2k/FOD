

program untitled;
const
valorAlto = 9999
N = 100
type
registroMaestro = record
fecha: integer;
codigo: integer;
nombre: string;
descripcion: string;
precio: real;
ejemplares: integer;
vendidos: integer;
end;

registroDetalle = record
fecha: integer;
codigo: integer;
vendidos: integer;
end;

maestro = file of registroMaestro;

detalle = file of registroDetalle;

vectorDetalle = array [1..N] of detalle;

vectorRegistro = array [1..N] of registroDetalle;

procedure leer (var D: detalle; var regD: registroDetalle)
begin
	if (not(eof(D))) then
		read(D,regD);
		else begin
			regD.fecha:= valorAlto;
			regD.codigo:= valorAlto;
		end;
end;

procedure minimo(var vD: vectorDetalle; var vR: vectorRegistro; var min: registroDetalle)
var
i, posMin: integer;
begin
	min.codigo:=valorAlto;
	posMin:=-1;
	for i := 1 to N do begin
		if(vR[i].codigo < min.codigo) then
			min:=vR[i];
			posMin:= i;
	end;
	if (posMin <> -1) then
		read(vD[posMin], vR[posMin]);
end;

procedure actualizar (var M: maestro; var vD: vectorDetalle; var vR: vectorRegistro)
var
regM: registroMaestro;
min: registroDetalle;
max, min,codigoActual: integer;
begin
	max:= -1;
	min:= 99999;
	reset(M)
	minimo(vD,vR,min);
	while (min.fecha <> valorAlto) do begin
		codigoActual:= min.codigo;
		totalEmision:=0;
		fechaActual:= min.fecha;
		while (min.fecha = fechaActual) and (min.codigo= codigoActual) do begin
			totalEmision:= totalEmision+min.cantidad;
			minimo(vD,vR,min);
		end;
		read(M, regM);
		while(regM.fecha <> fechaActual) or (regM.codigo <> codigoActual) do begin
			read(M,regM);
		end;
		regM.vendidos:= regM.vendidos -totalEmision;
		if (totalEmision > max)then
		max:=totalEmision;
		if (totalEmision < min) then
		min:= totalEmision;
		
	end;
	seek(M,filepos(M)-1);
	write(M,regM);
	end;
	writeln('minimo', min);
	writeln('maximo',max);
	close(M);
end;



var
BEGIN
assign (M, 'maestro.dat');
for i :=1 to N do begin
	Str(i, nombre);
	assign(vD[i], 'detalle',+nombre+'.dat');
	reset(vD[i]);
	leer(vD[i]);
	end;
	actualizar(M,vD,vR);
	for i :=1 to N do begin
		close(vD[i]);
	end;
END.

