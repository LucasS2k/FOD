program untitled;
const

type
registroMaestro = record;
sucursal: integer;
dni: integer;
numero: integer;
fecha: integer;
monto: real;
end;

maestro = file of registroMaestro;

procedure informe (var M: maestro; var informe: Texto);
var
regM: registroMaestro;
totalSusursal,totalVentas,ano,sucursalActual, dniActual, fechaActual,cantidadVentas: integer;
montoTotal, montoSucursal,montoVentas: real;

begin
reset(M);
rewrite(informe);
leer(M, regM);
while(regM.sucursal <> valorAlto) do begin
	totalSucursal:=0;
	montoSucursal:=0;
	sucursalActual:= regM.sucursal;
	writeln(informe,'sucursal: ',sucursalActual);
	while(regM.sucursal = sucursalActual) do begin
		dniActual:= regM.dni;
		writeln(informe,'Empleado:' ,dniActual);
		totalVentas:= 0;
		totalMonto:=0;
		while(regM.sucursal = sucursalActual) and (regM.dni = dniActual) do begin
			writeln(informe, 'Año   cantidad de ventas   monto de ventas');
			fechaActual:= extraerAno(regM.fecha);
			write(fechaActual,' ');
			cantidadVentas:=0;
			while(regM.sucursal = sucursalActual) and (regM.dni = dniActual) and (fechaActual = extraerAno(regM.fecha)) do begin
				cantidadVentas:=cantidadVentas+1;
				montoVentas:= montoVentas + regM.monto;
				leer(M, regM);
				end;
				write(informe, cantidadVentas,' ',montoventas,' ');
				totalVentas:= totalVentas+cantidadVentas;
				montoTotal:= montoTotal+montoVentas;
				end;
				totalSucursal:= totalSucursal+totalVentas;
				montoSucursal:=montoSucursal +montoTotal;
				writeln(informe, 'totales', totalVentas,' ',montoTotal);
				end;
				writeln(informe,'cantidad total de ventas sucursal: ',totalSucursal);
				writeln(informe,'monto total vendido por sucursal: ', montoSucursal);
				end;
				close(M);
				close(informe);
end;


var
M: maestro;
informe: Text;
BEGIN
assign(M, 'maestro.dat');
assign(informe, 'informe.txt');
informar(M, informe);
END.

