{
  Se cuenta con un archivo que almacena información sobre los tipos de dinosaurios
que habitaron durante la era mesozoica, de cada tipo se almacena: código, tipo de
dinosaurio, altura y peso promedio, descripción y zona geográfica. El archivo no está
ordenado por ningún criterio. Realice un programa que elimine tipos de dinosaurios
que estuvieron en el periodo jurásico de la era mesozoica. Para ello se recibe por
teclado los códigos de los tipos a eliminar.
Las bajas se realizan apilando registros borrados y las altas reutilizando registros
borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el
número 0 en el campo código implica que no hay registros borrados y -N indica que el
próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.
Dada la estructura planteada en el ejercicio, implemente los siguientes módulos:
Abre el archivo y agrega un tipo de dinosaurios, recibido como parámetro
manteniendo la política descripta anteriormente
a. procedure agregarDinosaurios (var a: tArchDinos ; registro: recordDinos);
b. Liste el contenido del archivo en un archivo de texto, omitiendo los tipos de
dinosaurios eliminados. Modifique lo que considere necesario para obtener el listado.
}


program untitled;

registroM = record;
codigo: integer;
tipo: String[15];
altura: real;
peso: real;
descripcion: String[40];
zona: String [15];
end;

maestro = file of registroM;

procedure altaDino(var M: maestro, dinoNuevo: registroM);
var
cabecera, aux: registroM;
posLibre: integer;
begin
reset(M);
read(M, cabecera);
if (cabecera < 0) then begin
	posLibre := abs(cabecera.codigo);
	seek(M, posLibre);
	read(M, aux);
	cabecera.codigo:= aux.codigo;
	
	seek(M, posLibre);
	write(M, dinoNuevo);
	
	seek(M, 0);
	write(M, cabecera);
	end;
	else begin
	seek(M, filesize(M));
	write(m, dinoNuevo);
	end;
	close(M);
end;

procedure bajaDino(var M: maestro){no se pide pero lo implemento para practicar (al parecer se dispone))}
var
var 
cabecera, reg : registroM;
eliminar, posActual: integer;
encontre: boolean;
begin
	reset(M);
	read(M,cabecera);
	writeln('ingrese el codigo del tipo a eliminar');
	readln(eliminar);
	while(eliminar <> -1) do begin
		encontre:= false;
		seek(M,1);
		while (not eof (M)) and (not encontre) do begin
			read(M, reg);
			posActual:=filepos(M)
			if (reg.codigo = eliminar) then
				encontre:= true;
				end;
		if (encontre) then begin
			seek(M, posActual);
			read(M, reg);
			reg.codigo := cabecera.codigo;
			
			seek(M, posActual);
			write(M, reg);
			
			cabecera.codigo:= posActual * -1;
			seek(M, 0);
			write(M, cabecera);
			end;
			readln(eliminar);
end;
close(M);
end;

procedure exportarATexto (var M: maestro; var TXT: Text);
var
reg: registroM;
begin
	reset(M);
	rewrite(TXT);
	if (not eof(M)) then
	read(M, reg);
	while (not eof (M)) do begin
		read(M, reg);
		if (reg.codigo > 0) then begin
			writeln(txt, reg.codigo, '', reg.altura, '', reg.tipo,'',reg.peso,'',reg.descripcion,'',reg.zona);
			end;
			end;
			close(M);
			close(TXT);
end;
var
M: maestro;
TXT: Text;
dinoNuevo: regM;
BEGIN
assign(M, 'maestro.dat');
assign(TXT, 'export.txt');
read(dinoNuevo.todosloscampos);
altaDino(M, dinoNuevo);
bajaDino(M);
exportarATexto(M,TXT);
END.

