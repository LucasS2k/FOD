{Se cuenta con un archivo que posee información de las ventas que realiza una empresa a los diferentes 
clientes. Se necesita obtener un reporte con las ventas organizadas por cliente. Para ello, se deberá 
informar por pantalla: los datos personales del cliente, el total mensual (mes por mes cuánto compró) y 
finalmente el monto total comprado en el año por el cliente. Además, al finalizar el reporte, se debe 
informar el monto total de ventas obtenido por la empresa.  
El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año, mes, día y 
monto de la venta. El orden del archivo está dado por: cod cliente, año y mes. 
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron compras. No es 
necesario que informe tales meses en el reporte. }
program untitled;
const
valorAlto = 9999
type
registroCliente = record
codigo: integer;
nombre: string;
apellido: string;
end;

registroMaestro = record
cliente: registroCliente;
anio: integer;
mes: integer;
dia: integer;
monto: real;
end;

maestro = file of registroMaestro;

procedure leer(var M:maestro, var regM: registroMaestro);
begin
	if not(eof(M)) then
		read(M,regM);
	else
	regM.cliente.codigo := valorAlto;
end;;

procedure reporte(var M: maestro);
var
mesActual,anioActual: integer;
clienteActual: integer;
cliente: registroCliente;
regM: registroMaestro;
totalAnio,totalMes,totalEmpresa: real;
begin
	reset(M);
	totalEmpresa:=0;
	leer(M,regM);
	while(regM.cliente.codigo <> valorAlto) do begin
		read(M,regM);
		clienteActual:= regM.cliente.codigo;
		totalAnio:=0;
		writeln('datos del cliente:');
		writeln(regM.nombre);
		writeln(regM.apellido);
		while(regM.cliente.codigo = clienteActual) do begin
			anioActual:= regM.anio
			while(clienteActual = regM.cliente.codigo) and(regM.anio = anioActual) do begin
				totalMes:=0;
				mesActual:= regM.mes;
				while(clienteActual = regM.cliente.codigo) and (regM.anio = anioActual) and (regM.mes = mesActual) do begin
					totalMes:= totalMes+ regM.monto;
					leer(MM, regM);
				end;
			writeln('total del mes:' ,mes, totalMes);
			totalAnio:=totalAnio+totalMes;
			end;
	end;
	writeln('total año',totalAnio);
	totalEmpresa:= totalEmpresa+totalAnio;
end;
	writeln('total empresa',totalEmpresa);
	close(M);
end;

var
M: maestro;
BEGIN
assign(M, 'maestro.dat');
reporte(M);
END.

