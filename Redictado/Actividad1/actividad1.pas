{1. Archivos Secuenciales
Considere que se tiene un archivo que contiene información de los trabajos de impresión realizados por una empresa de
impresión 3D. Por cada trabajo se tiene la siguiente información: código de sucursal, código de impresora, número de cliente,
tipo de material utilizado y cantidad de minutos de impresión.
Cada registro del archivo representa un trabajo de impresión. En consecuencia, una misma sucursal puede aparecer en varios
registros, una misma impresora puede realizar varios trabajos y un mismo cliente puede tener registrados varios trabajos sobre
una misma impresora.
Además, se sabe que el archivo se encuentra ordenado por los siguientes criterios: código de sucursal, código de impresora y
número de cliente (en ese orden).
Se solicita definir las estructuras de datos necesarias y escribir el módulo que reciba el archivo de datos y genere un informe en
pantalla con el formato que se adjunta en la imagen. Para calcular el costo de cada trabajo existe un vector con el costo por
minuto correspondiente a cada tipo de material. Los tipos de material se identifican con valores enteros. El vector contiene el
costo por minuto de cada material, utilizando como índice el código del material. Por ejemplo, si vector[1] = 10, significa que el
costo por minuto del material con código 1 es de $10.
El costo de un trabajo se obtiene multiplicando la cantidad de minutos de impresión por el costo por minuto correspondiente al
tipo de material utilizado.
Notas: El archivo de datos deberá recorrerse una única vez. Puede asumir que el vector contiene información válida para todos
los tipos de material. En el informe solo interesa que aparezca la información solicitada; no es necesario respetar los espacios en
blanco o la alineación mostrados en el ejemplo.}


program untitled;
const
VA = 99999;

trabajo = record
	codigoSucursal: integer;
	codigoImpresora: integer;
	numeroCliente: integer;
	materia: integer;
	minutos: integer;
end;

archivo = file of trabajo;

vectorCostos = array [1..10] of real;

procedure leer(var arch: archivo; var R: trabajo);
begin
	if (not (EOF(arch))) then
	read(arch, reg);
	else
	reg.codigoSucursal := VA;
end;

procedure generarInforme (var A: archivo; VC: vectorCostos);
var
R: trabajo;
sucActual, imprActual, cliActual: integer;
totalSucursal, totalEmpresa, totalImpresora, totalCliente: real
begin
reset(arch);
leer(arch,R);
totalEmpresa:=0;

while (R.codigoSucursal <> VA) do begin
	sucActual:= R.codigoSucursal;
	totalSucursal:= 0;
	writeln('SUCURSAL:',sucActual);
	while (R.codigoSucursal = sucActual) do begin
		imprActual:= R.codigoImpresora;
		totalImpresora:=0;
		writeln('IMPRESORA:', imprActual);
		while (R.codigoSucursal = sucActual and R.codigoImpresora = imprActual) do begin
			cliActual:= R.codigoCliente;
			totalCliente:=0;
			writeln('CLIENTE', cliActual);
				while(R.codigoSucursal = sucActual and R.codigoImpresora = imprActual and R.codigoCliente = cliActual) do begin
					costoTrabajo:= R.minutos * [VC.material];
					totalCliente:= totalCliente + costoTrabajo;
					leer(arch,R);
					end;
					writeln('TOTAL GASTADO:', totalCliente);
					totalImpresora:= totalImpresora + totalCliente;
					end;
					WriteLn('TOTAL IMPRESORA', totalImpresora);
					totalSucursal:= totalSucursal + totalImpresora;
					end;
					writeln('TOTAL SUCURSAL:' ,totalSucursal);
					totalEmpresa:= totalEmpresa + totalSucursal;
					end;
					writeln('TOTAL EMPRESA', totalEmpresa);
					close(arch);			
end;
var
A: archivo;
R: trabajo;
BEGIN
assign (A, 'maestro.dat');
generarInforme(A,R);
END.

