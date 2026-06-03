
program untitled;

const 
valorAlto = 9999;
N = 30;
type
producto = record
codigo: integer;
nombre: string;
descripcion: string;
stock: integer;
stockMin: integer;
precio: real;
end;

productoSucursal = record
codigo: integer;
cantidad: integer;
end;

maestro = file of producto;
detalle = file of productoSucursal;
arreglo_detalle = array [1..N] of detalle;
arreglo_registros = array [1..N] of productoSucursal;

procedure leer(var aD: detalle; var regD: productoSucursal);
begin
if (not(EOF(aD))) then
	begin
		read(aD, regD);
	end
else begin
	regD.codigo := valorAlto;
	end;
end;
procedure minimo(var vD: arreglo_detalle; var vR: arreglo_registros; var min: productoSucursal);
var
i, indiceMin: integer;
begin
min.codigo:= valorAlto;
indicemin:= -1;
for i :=1 to N do begin
	if (vR[i].codigo < min.codigo) then begin
		min := vR[i];
		indiceMin:= 1;
		end;
	end;
	if (indiceMin <> -1) then
		leer(vD[indiceMin], vR[indiceMin]);
end;





procedure actualizar(var aM: maestro; var vD: arreglo_detalle);
var
vR: arreglo_registros;
min: productoSucursal;
codActual, total,i: integer;
regM: producto;
reporte: Text;
begin
reset(aM);
for i :=1 to N do begin
	reset(vD[i]);
	leer(vD[i], vR[i]);
end;
assign(reporte, 'productosstockbajo.txt');
rewrite(reporte);
minimo(vD, vR, min);
while (min.codigo <> valorAlto) do begin
	codActual:= min.codigo;
	total:=0;
	while(min.codigo = codActual) do begin
		total:= total + min.cantidad;
		minimo(vD, vR, min);
	end;
	read(aM, regM);
	while(regM.codigo <> codActual)do 
		read(aM, regM);
	regM.stock := regM.stock-total;
	seek(aM, filepos(aM)-1);
	write(aM, regM);
	if (regM. stock < regM.stockMin) then
		writeln(reporte, regM.nombre,' ', regM.descripcion,' ',regM.stock,' ',regM.precio);
	end;
for i :=1 to N do 
	close(vD[i]);
close(aM);
close(reporte);
end;
var
vD: arreglo_detalle;
aM: maestro;
i: integer;
nombre_fisico: string;
BEGIN
assign(aM, 'archivocentral.dat');
for i:=1 to N do begin
	Str(i,nombre_fisico);
	nombre_fisico:= 'detalle' +nombre_fisico+'.dat';
	assign(vD[i],nombre_fisico)
	end;
actualizar(aM, vD);
END.

