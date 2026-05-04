program sintitulo;
const
valoralto = 'ZZZ';
type

registro = record
provincia: string;
alfabetizadas: integer;
encuestados: integer;
end;

regDetalle = record
provincia: string;
codigo: integer;
alfabetizadas: integer;
encuestados: integer;
end;


maestro = file of registro;
detalle = file of regDetalle;

procedure leer(var D: detalle; var dato: regDetalle);
begin 
if (not eof(D)) then begin
	read(D, dato);
	end
else begin
	dato.provincia := valoralto;
end;
end;


procedure actualizar(var M: maestro; var D1: detalle; var D2: detalle);
var
regM: registro;
regD1,regD2: regDetalle;
totalE, totalA: integer;
provinciaActual: string;
begin
	reset(M);
	reset(D1);
	reset(D2);
	leer(D1, regD1);
	leer(D2, regD2);
	while(regD1.provincia<> valorAlto) or (regD2.provincia <> valoralto) do begin
		if(regD1.provincia< regD2.provincia) then
			provinciaActual:= regD1.provincia
			else 
			provinciaActual:= regD2.provincia;
		totalE:= 0;
		totalA:= 0;
		while (regD1.provincia = provinciaActual) do begin
			totalA := totalA + regD1.alfabetizadas;
			totalE := totalE +regD1.encuestados;
			if not eof (D1) then read(D1, regD1) else regD1.provincia := valoralto;
		end;
		while (regD2.provincia <> provinciaActual) do begin 
			totalA := totalA + regD2.alfabetizadas;
			totalE := totalE +regD2.encuestados;
			if not eof (D2) then read(D2, regD2) else regD2.provincia := valoralto;
		end;
	read(M, regM);
	while(regM.provincia <> regD1.provincia) do 
		read(M, regM);
	regM.provincia:= regD1.provincia;
	regM.alfabetizadas := regM.alfabetizadas + totalA;
	regM.encuestados := regM.encuestados + totalE;
	seek(M, filepos(M)-1);
	write(M, regM);
	end;
	close(M);
	close(D1);
	close (D2);

end;
var
D1: detalle;
D2:detalle;
M: maestro;
begin
assign(D1, 'detalle1.dat');
assign(D2, 'detalle2.dat');
assign(M,'maestro.dat');
actualizar(M, D1,D2);

end.
