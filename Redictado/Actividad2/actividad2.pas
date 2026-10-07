{
  1. Archivos Secuenciales
Una empresa dedicada a la distribución de licencias de software posee un archivo que contiene información sobre las
aplicaciones que comercializa. De cada aplicación se registran los siguientes datos: código de aplicación, nombre, origen, precio
de la licencia, cantidad de licencias disponibles y cantidad mínima de licencias que se desea mantener en stock. La empresa
cuenta con 20 portales de venta online asociados. Diariamente, se recibe un archivo detalle de cada uno de los 20 portales que
indica las licencias vendidas durante el día. De cada venta se registra el código de aplicación y la cantidad de licencias vendidas.
Se debe realizar un procedimiento que actualice la cantidad de licencias disponibles en el archivo maestro con la información
contenida en los archivos detalle y que además informe en un archivo de texto aquellas aplicaciones cuyo monto total vendido
durante el día supere los $10.000.
En el archivo de texto a exportar, por cada aplicación incluida, se deben informar código de aplicación, nombre, origen y monto
total vendido en el día. La información debe organizarse de manera tal que facilite su utilización posterior como archivo de carga.
El objetivo del ejercicio es escribir el procedimiento solicitado, junto con las estructuras de datos y módulos utilizados para
resolverlo.
Notas:
● Todos los archivos se encuentran ordenados por código de aplicación.
● En un archivo detalle pueden existir 0, 1 o N registros correspondientes a una misma aplicación.
● Cada archivo detalle contiene únicamente aplicaciones que existen en el archivo maestro.
● Los archivos deben recorrerse una única vez. En el mismo recorrido debe realizarse tanto la actualización del archivo
maestro como la generación del archivo de texto solicitado.
}


program untitled;
const 
VA = 99999;

venta = record;
codigo: integer;
cantidad: integer;
end;

registro = record;
	codigo: integer;
	nombre: string[15];
	origen: string[20];
	precio: real;
	disponibles: integer;
	minimas: integer;
end;

maestro = file of registro;
detalle = file of venta;

vectorDetalles = array [1..20] of detalle;
vectorRegistros = array [1..20] of venta;

procedure leer(var arch: maestro; var R: venta);
begin
	if (not eof( arch)) then
	read(arch,R);
	else
	R.codigo := VA;
end;

procedure minimo (var arch: maestro; VD: vectorDetalles; VR: vectorRegistros);
var
min: venta;
i, posMin: integer;
begin
	min.codigo:= valorAlto;
	posMin:= -1;
	for i := 1 to 20 do begin
		if (VR[i].codigo < min.codigo) then begin
			min:= VR[i];
			posMin:= i;
	end;
end;
if (pos <> -1) then 
	leer(VD[posMin], VR[posmin]);
end;

procedure actualizar (var M: maestro; VD: vectorDetalles; var exportacion: Text);
var
VR: vectorRegistros;
min: venta;
regM: registro;
i, actual, total: integer
monto:real;
begin
	reset(M);
	rewrite(exportacion);
	for i := 1 to 20 do begin
		reset(VD[i]);
		leer(VD[i], VR[i]);
	end;
	
	if (not eof(M)) do begin
		read(M,regM);
		minimo(VD,VR,min);
		while (min.codigo <> VA) do begin
			actual:= min.codigo;
			total:=0;
			while(min.codigo = actual) do begin
				total:= total+ min.cantidad;
				minimo(VD,VR,min);
			end;
			while (min.codigo <> actual)do 
			read(M, registro);
			regM.disponible:= regM.disponible - total;
			seek(M, filepos(M)-1);
			write(M, regM);
			monto := total * regM.precio;
			if (monto > 10000) then begin
			writeln(exportacion, regM.codigo, '',monto, '', regM.origen,'',regM.nombre)
			end;
			if (not eof(M)) then
			read(M, registro);
		end;
		close (M);
		close(exportacion);
		for i := 1 to 20 do
		close(VD[i]);
		end;
end;

var
A: archivo;
R: registro;
VD: vectorDetalles;
txt: Text;
i: integer;
nombre: string
BEGIN
	assign(M,'maestro.dat');
	for i := 1 to 20 do begin
		read(nombre)
		assign(VD[i],nombre);
	end;
	
	actualizar(A, VD, txt);
	
END.

