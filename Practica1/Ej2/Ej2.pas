program ej2;
type
  archivo_num_enteros = file of integer;
var 
  enteros: archivo_num_enteros;
  nombre: string;
  num,total,cant: integer;
  promedio: double;
begin
  cant:=0;
  promedio:=0;
  total:=0;
  writeln('Ingrese el nombre que desea para su archivo');
  readln(nombre);
  Assign(enteros, nombre + '.dat');
  Reset(enteros);
  while(not eof(enteros)) do begin
    read(enteros,num);
    if (num < 1500) then
    begin
      cant:= cant+1;
      total:= total+ num;
    end;
    writeln('numero actual: ',num);
  end;
  Close(enteros);
  promedio:= total / cant;
  writeln('promedio menor a 1500: ', promedio);
end.
