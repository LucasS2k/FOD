program untitled;
const
valorAlto = 9999;
N = 15;
type
registroMaestro = record
departamento: integer;
division: integer;
empleado: integer;
categoria: integer;
horas: integer;
end;

maestro = file of registroMaestro;
archivoDivisiones = Text;
divisiones = array [1..N] of integer;

procedure cargarDivisiones(var D: divisiones; var aD:archivoDivisiones);
var 
i,valor:integer;
begin
	reset(aD)
	for i := 1 to N do begin
	readln(aD, valor);
	D[i]:= valor;
	end;
	close(aD)
end;

procedure leer(var M: maestro; var regM:registroMaestro);
begin
	if (not(eof(M))) then
		read(M, regM)
	else begin
		regM.departamento:= valorAlto;
		regM.division:= valorAlto;
		regM.empleado:=valorAlto;
	end;
end;

procedure procesar (var M: maestro);
var
regM: registroMaestro;
departamentoActual,divisionActual,horasDepartamento,horasDivision,horasEmpleado,empleadoActual: integer;
importe,montoDivision,montoDepartamento,totalDepartamento:real;
begin
	reset(M);
	leer(M,regM);
	while (regM.departamento <> valorAlto)do begin
		departamentoActual:=regM.departamento;
		montoDepartamento:=0;
		horasDepartamento:=0;
		
		writeln('departamento: ',departamentoActual);
		while(regM.departamento = departamentoActual) do begin
			divisionActual:= regM.division;
			horasDivision:=0;
			montoDivision:=0;
			writeln('division actual')
		while(regM.departamento = departamentoActual) and (regM.division = divisionActual)
			do begin
				empleadoActual:=regM.empleado;
				horasEmpleado:=0;
				writeln('empleado',empleadoActual);
				while(regM.departamento = departamentoActual) and (regM.division = divisionActual) and (regM.empleado = empleadoActual) do begin
					horasEmpleado:= horasEmpleado + regM.horas;
					leer(M,regM);
				end;
				importe:= horasEmpleado * D[regM.division];
				horasDivision:=horasDivision + horasEmpleado;
				montoDivision:=montoDivision +importe;
			end;
			writeln('monto division: 'montoDivision);
			montoDepartamento:= montoDepartamento + montoDivision;
			horasDepartamento:= totalDepartamento+horasDivision;
	end;
	writeln(horasDepartamento);
	writeln(montoDepartamento);
	end;
	close(M);
end;


var
D: archivoDivisiones;
M: maestro;
vD: divisiones
BEGIN
assign(M,'maestro.dat');
assign(D,'divisiones.txt');
cargarDivisiones(D);
procesar(M);
	
END.

