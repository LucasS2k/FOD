program ej1;
type
  archivo_num_enteros = file of integer;
var 
  enteros: archivo_num_enteros;
  nombre: string;
  num: integer;
begin
  writeln('Ingrese el nombre que desea para su archivo');
  readln(nombre);
  Assign(enteros, nombre + '.dat');
  Rewrite(enteros);
  writeln('Ingrese un entero');
  readln(num);
  while(num <> 3000) do 
  begin
  write(enteros,num);
  writeln('Ingrese otro entero (3000 para terminar)');
  readln(num);
  end;
  Close(enteros);
end.
