

program untitled;
type
celular = record
codigo: integer;
nombre: string;
descripcion: string;
marca: string;
precio: real;
stockMin: integer;
stock: integer;
end;
celulares = file of celular;

procedure crearArchivoBIN (var CsTXT: text; var CsBIN: celulares);
var 
C: celular;
begin
	rewrite(CsBIN);
	Reset(CsTXT); // para abrir el archivo
	while(not EOF(CsTXT)) do begin 
		with C do begin //para ir guardando todo el registro
		Read(CsTXT, codigo); //se lee campo a campo
		Read(CsTXT, precio);
		ReadLn(CsTXT, marca); //el ultimo campo debe saltarse linea
		
		Read(CsTXT, stock);
		Read(CsTXT, stockMin);
		ReadLn(CsTXT, descripcion);
		
		Readln(CsTXT, nombre);
		write(CsBIN,C) //escribimos el registro
		end;
		end;
	close(CsBIN); ///cerramos archivo bin
end;

procedure exportarATXT(var CsTXT: text; var CsBIN:celulares);
var
C:celular;
begin
	reset(CsBIN);
	rewrite(CsTXT);
	while (not EOF(CsBIN)) do begin
		read(CsBIN, C);
		with C do 
		begin
			writeln(CsTXT, codigo,' ', precio:0:2,' ', marca);
			writeln(CsTXT, stock,' ', stockMin,' ', descripcion);
			writeln(CsTXT, nombre);
		end;
	end;
	close(CsTXT);
	close(CsBIN);
end;

procedure imprimirCelular(C: celular);
begin
	writeln(C.codigo);
	writeln(C.precio);
	writeln(C.marca);
	writeln(C.stock);
	writeln(C.stockMin);
	writeln(C.descripcion);
end;

procedure listarCadena(var CsBIN: celulares);
var
C: celular;
cadena: string;
bool: boolean;
begin
	bool:= false;
	writeln('ingrese una descripcion: ');
	readln(cadena);
	reset(CsBIN);
	while(not EOF(CsBIN)) do begin
		read(CsBIN, C);
		if(Pos(LowerCase(cadena), LowerCase(C.descripcion))>0) then
		begin
		imprimirCelular(C);
		bool:= true;
	end;
	end;
	close(CsBIN);
	if(bool = false) then
	writeln('no encontrado');
end;

procedure listarStock(var CsBIN: celulares);
var
C:celular;
begin
reset(CsBIN);
while(not EOF(CsBIN)) do begin
	begin
		read(CsBIN, C);
		if (C.stock < C.stockMin) then
			imprimirCelular(C);
	end;
end;
end;
var 
opcion:integer;
CsTXT: text;
CsBIN: celulares;
BEGIN
	Assign(CsBIN, 'celulares.dat');
	Assign(CsTXT, 'celulares.txt');
	writeln('ingrese una opcion para operar: ');
	readln(opcion);
	case opcion of
	1: crearArchivoBIN(CsTXT, CsBIN);
	2: listarStock(CsBIN);
	3: listarCadena(CsBIN);
	4: exportarATXT(CsTXT, CsBIN);
	end;
END.

