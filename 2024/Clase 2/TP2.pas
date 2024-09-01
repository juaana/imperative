{
   Implementar un módulo que permita generar un vector con la información 
   de las oficinas administradas. El vector debe almacenar, como máximo, 300 oficinas. 
   Se ingresarán los siguientes datos para cada oficina: 
   código de identificación, 
   DNI del propietario y 
   valor de la expensa. 
   La carga de datos finalizará cuando se ingrese el código de identificación -1, 
   el cual no se procesará.
   
}


program TP1EJ2;

type
  oficinasMax = 1..300;

  oficina = record
    codigoID: integer;
    DNI: integer;
    valorExpensa: real;
  end;

  lista = ^infoOficinas;

  infoOficinas = record
    datosOfi: oficina;
    sig: lista;
  end;

procedure LeerOficinas(var IO: lista);
var 
  i, contador: integer;
  nuevaOficina: lista;
begin
  contador := 1;
  IO := nil;  // Inicializar la lista como vacía
  writeln('Ingrese el código de identificación');
  readln(i);
  while (i <> -1) AND (contador < 300) do 
  begin
    New(nuevaOficina);
    nuevaOficina^.datosOfi.codigoID := i;  // Asignar el código ingresado
    writeln('Ingrese el DNI del propietario');
    readln(nuevaOficina^.datosOfi.DNI);
    writeln('Ingrese el valor de la expensa');
    readln(nuevaOficina^.datosOfi.valorExpensa);
    contador := contador + 1;
    nuevaOficina^.sig := IO;  // El nuevo nodo apunta al nodo anterior
    IO := nuevaOficina;
    
    // Leer el siguiente código de identificación
    writeln('Ingrese el código de identificación');
    readln(i);
  end;
end;

var
  IO: lista;

begin
  LeerOficinas(IO);
 
end.
