

program untitled;

const 
valorAlto = 9999

type
registroMaestro = record
destino: string;
fecha: integer;
hora: integer;
disponibles;
end;

registroDetalle = record
destino: integer;
fecha: integer;
hora: integer;
comprados: integer;
end;
maestro = file of registroMaestro
detalle = file of registroDetalle

procedure leerMaestro(var M:maestro; var regM: registroMaestro)

begin
	if (not(eof(M))) then
		read(M,regM);
	else begin
	regM.destino:=valorAlto;
	regM.fecha:=valorAlto;
	regM.hora:=valorAlto
end;
end;

procedure leerDetalle(var det: detalle; var regD: registroDetalle)

begin
	if (not (eof(det))) then
		read(det, regD);
	else begin;
		regD.destino:=valorAlto;
		regD.fecha:=valorAlto;
		regD.hora:=valorAlto;
	end;

end;

procedure minimo(var det1: detalle; var det2: detalle; var reg1: detalle; var reg2:detalle; var min: registroDetalle)
begin
	if (reg1.destino < reg2.destino) or ((reg1.destino = reg2.destino) and (r1.fecha < r2.fecha)) or ((r1.fecha = r2.fecha) and (r1.hora < r2.hora))
		then begin
		min:= reg1;
		leer(det1, reg1);
		end;
		else begin
		min:= r2;
		leer(det2, reg2);
	end;
end;

procedure actualizar(var M: maestro; var det1: detalle; var det2: detalle)
var
regM: registroMaestro;
regDet1, regDet2,min,aux: registroDetalle;
minimoAsientos: integer;
begin
	reset(M);
	reset(det1);
	reset(det2);
	leer(M,regM);
	leer(det1, reg1);
	leer(det2, reg2);
	minimo(det1, det2, reg1,reg2);
	writeln('ingrese la cantidad de asientos minimos')
	readln(minimoAsientos);
	while (min.destino <> valorAlto) fo begin
		aux:= min;
		totalVendido:=0;
		while(min.destino = aux.destino) and (min.fecha = aux.fecha) and (min.hora = aux.hora) bo begin
			totalVendido:= totalVendido+ min.comprados;
			end;
		while (regM.destino <> aux.destino) or (regM.fecha <> aux.fecha) or (regM.hora <> aux.hora) do 
		begin
			read(M, regM);
		end;
		regM.disponibles:= regM.disponibles-totalVendido;
		if (regM.disponibles < minimoAsientos) then 
		writeln('vuelo con cantidad inferior a la ingresada;', regM.destino, regM.fecha, regM.hora);
		seek(M, filepos(M)-1);
		write(M,regM);
		leer(M,regM);
	end;
	close(M);
	close(det1);
	close(det2);
end;

var
M:maestro;
det1,det2: detalle;
BEGIN
assign(M,'maestro.dat');
assign(det1,'detalle1.dat');
assign(det2,'detalle2.dat');
actualizar(M,det1,det2);
END.

