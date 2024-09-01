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
  contador := 0;
  IO := nil;  // Inicializar la lista como vacía
  
  writeln('Ingrese el código de identificación (o -1 para terminar):');
  readln(i);
  
  while (i <> -1) and (contador < 300) do 
  begin
    New(nuevaOficina);
    nuevaOficina^.datosOfi.codigoID := i;  // Asignar el código ingresado
    
    writeln('Ingrese el DNI del propietario:');
    readln(nuevaOficina^.datosOfi.DNI);
    
    writeln('Ingrese el valor de la expensa:');
    readln(nuevaOficina^.datosOfi.valorExpensa);
    
    nuevaOficina^.sig := IO;  // El nuevo nodo apunta al nodo anterior
    IO := nuevaOficina;
    
    contador := contador + 1;
    
    // Leer el siguiente código de identificación
    writeln('Ingrese el código de identificación (o -1 para terminar):');
    readln(i);
  end;
end;

procedure OrdenarOficinasInsercion(var IO: lista);
var
  sorted, current, prev, next: lista;
begin
  sorted := nil; // Inicialmente, la lista ordenada está vacía
  
  while IO <> nil do
  begin
    // Extrae el nodo actual de la lista original
    current := IO;
    IO := IO^.sig;
    
    // Inserta el nodo actual en la lista ordenada
    if (sorted = nil) or (current^.datosOfi.codigoID < sorted^.datosOfi.codigoID) then
    begin
      // Insertar al principio de la lista ordenada
      current^.sig := sorted;
      sorted := current;
    end
    else
    begin
      // Encuentra la posición correcta para insertar el nodo
      prev := sorted;
      next := sorted^.sig;
      
      while (next <> nil) and (current^.datosOfi.codigoID >= next^.datosOfi.codigoID) do
      begin
        prev := next;
        next := next^.sig;
      end;
      
      // Inserta el nodo actual en la lista ordenada
      prev^.sig := current;
      current^.sig := next;
    end;
  end;
  
  // La lista ordenada es ahora la lista original
  IO := sorted;
end;

var
  IO: lista;

begin
  LeerOficinas(IO);
  OrdenarOficinasInsercion(IO);
end.
