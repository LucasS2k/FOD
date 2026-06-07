program untitled;
const

type
registroMaestro = record
ano: integer;
mes: integer;
dia: integer;
usuario: integer;
tiempo: integer;
end;

maestro = file of registroMaestro;

procedure leer(var M: maestro; var regM: registroMaestro)
begin
	if (not (eof(M))) then
		read(M, regM);
	else begin
	regM.ano:=valorAlto;
	regM.mes:=valorAlto;
	regM.dia:=valorAlto;
	regM.usuario=valorAlto;
	end;
end;

procedure informar (var M: maestro)
ingreso,tiempoUsuario, tiempoDia,tiempoMes,tiempoAno: integer;
regM: registroMaestro;
anoActual, mesActual,diaActual,usuarioActual: integer;
begin
	existe:= false;
	reset(M)
	readln(ingreso);
	leer(M, regM)
	while (regM.ano <> valorAlto) and (regM.ano < ingreso) do begin
		leer(M, regM)
		if (regM.ano = ingreso) then
			existe:= true;
	end;
	if (existe) then begin
	while (regM.ano = ingreso) do begin
	anoActual:=regM.ano;
	tiempoAno:=0;
	writeln('año: ',anoActual);
		while (regM.ano = anoActual)
		mesActual:=regM.mes;
		tiempoMes:=0;
		writeln('mes: ',mesActual)
			while (anoActual = regM.ano) and (mesActual = regM.mes) do begin
				diaActual:= regM.dia
				tiempoDia:=0;
				writeln('dia: ',diaActual);
					while (anoActual = regM.ano) and (mesActual = regM.mes) and (diaActual = regM.dia)do begin
						usuarioActual:= regM.usuario;
						tiempoUsuario:=0;
						writeln('usuario: ',usuarioActual);
							while(anoActual = regM.ano) and (mesActual = regM.mes) and (diaActual = regM.dia) and (usuarioActual = regM.usuario) do begin
								tiempoUsuario:=tiempoUsuario+regM.tiempo;
								leer(M,regM);
							end;
							tiempoDia:=tiempoDia+tiempoUsuario;
							writeln('tiempo usuario: ', tiempoUsuario);
					end;
					tiempoMes:=tiempoMes+tiempoDia;
					writeln('tiempo dia: ', tiempoDia);
			end;
			tiempoAno:=tiempoAno+tiempoMes;
			writeln('tiempo mes',tiempoMes);
		end;
		writeln('tiempo año', tiempoAno);
		close(M);
		end;
		else 
		writeln('no encontrado');
end;
var
M: maestro;
BEGIN
assign(M,'maestro.dat');

END.

