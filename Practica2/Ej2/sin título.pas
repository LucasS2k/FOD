program untitled;
type
producto = record
codigo: integer;
nombre: string;
precio: real;
stockA: integer;
stockM: integer;
end;

venta = record
codigo: integer;
vendidas: integer;
end;
archivoProductos = file of producto;
archivoVentas = file of venta;

procedure actualizar(var maestro : archivoProductos;var detalle: archivoVentas);
var 
p: producto;
v: venta;
codigoActual, total: integer;
begin
reset(maestro);
reset(detalle);
if (not eof (detalle)) then begin
	while (not eof(detalle)) do begin
		read(detalle, v);
		codigoActual:= v.codigo;
		total:= 0;
		while(codigoActual = codigoActual) do begin
			total:= total + v.vendidas;
			read(detalle, v);
			end;
		read(maestro, p);
		while(p.codigo <> codigoActual) do begin
			read(maestro, p);
			end;
		p.stockA := p.stockA - total;
		seek(maestro, filepos(maestro)-1); //para retroceder
		write(maestro, p);
		if (not eof(maestro))then
		read (maestro, p);
		end;
	end;
	close(maestro);
	close(detalle);
	writeln('completado');	
end;
procedure generarTXT(var maestro: archivoProductos);
var
p: producto;
texto: text;
begin
Assign(texto, 'stock.txt');
rewrite(texto);
reset(maestro);
if not (eof(maestro)) then begin
	while (not eof(maestro)) do begin
		read(maestro, p);
		if(p.stockA<p.stockM)
			then write('cod: ', p.codigo,'stock:', p.stockA, 'nombre: ',p.nombre);
		end;
end;
end;
var 
M: archivoProductos;
D: archivoVentas;
BEGIN
Assign(M, 'maestro.dat');
Assign(D, 'detalle.dat');

actualizar(M, D);

generarTXT(M);
END.

