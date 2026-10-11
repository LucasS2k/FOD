{
  
}


program untitled;

registroM = record
codigo: integer;
nombre: string[15];
especie: string[15];
edad: integer;
dueno: string[30];
tel: integer;
end;

maestro = file of registroM;

function existeMascota (var M: maestro; codigo: integer):integer;
var
reg: registroM;
posActual: integer;
encontre: boolean;
begin
reset(M);
encontre:= false;
while (not eof (M)) and (not encontre) do begin
	posActual:= filepos(M);
	read(M, reg);
	if (reg.codigo = codigo) then
		encontre:=true;
	end;
	if encontre then existeMascota:= posActual;
	else existeMascota:= -1;
end;

procedure altaMascota (var M: maestro);
var
reg,cabecera,aux: registroM;
begin
	reset(M);
	read(M, cabecera);
	read(reg.codigo);
	read(reg.todoslosdemas);
	
	if (cabecera.codigo > 0) then begin
		pos:= abs(cabecera.codigo);
		seek(M, pos);
		read(M,aux);
		
		seek(M, pos); {volvemos a la pos libre porque el read nos hace avanzar}
		write(M,reg);
		
		cabecera.codigo:= aux.codigo *-1;
		seek(M,0);
		write(M,cabecera);
		
		else
		seek(M filesize(M));
		write(M,reg);
		end;
		close(M);
end;

procedure bajaMascota (var M: maestro);
var
eliminar,elimino,pos: integer;
reg,aux,cabecera: registroM;
begin
	read(eliminar);
	elimino:= existeMascota(M,eliminar);
	if (elimino <> -1) then begin
		reset(M);
		read(M,cabecera);
		
		seek(M, elimino);
		read(M, reg);
		
		reg.codigo:= cabecera.codigo;
		seek(M,elimino);
		write(M, reg);
		
		cabecera.codigo:= elimino *-1;
		seek(M,0);
		write(M,cabecera);
		end;
		close(M);
end;
BEGIN
	
	
END.

