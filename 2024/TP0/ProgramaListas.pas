{
ACTIVIDAD 3: Crear un archivo ProgramaListas.pas
a) Implemente un módulo CargarLista que cree una lista de enteros y le
agregue valores aleatorios entre el 100 y 150, hasta que se genere el
120.
b) Implemente un módulo ImprimirLista que reciba una lista generada en
a) e imprima todos los valores de la lista en el mismo orden que están
almacenados.
c) Implemente un módulo BuscarElemento que reciba la lista generada
en a) y un valor entero y retorne true si el valor se encuentra en la lista
y false en caso contrario.
d) Invocar desde el programa principal a los módulos implementados
para crear una lista, mostrar todos sus elementos y determinar si un
valor leído por teclado se encuentra o no en la lista.
   
}


program ProgramaListas;

type
  lista = ^nodo;  // Definición del puntero al tipo nodo
  nodo = record
    num: integer;   // Dato que guarda el nodo
    sig: lista;     // Puntero al siguiente nodo
  end;
procedure cargarLista(var L: lista);
var
  al: integer;
  nuevoNodo: lista;
begin
  randomize;
  al := random(150 - 100 + 1) + 100;  // Genera un número aleatorio entre 100 y 150

  while (al <> 120) do
  begin
    New(nuevoNodo);            // Crear un nuevo nodo
    nuevoNodo^.num := al;       // Asignar el número aleatorio al nodo
    nuevoNodo^.sig := L;        // El nuevo nodo apunta al nodo anterior
    L := nuevoNodo;             // Actualizar la cabeza de la lista
    al := random(150 - 100 + 1) + 100;  // Generar el siguiente número aleatorio
  end;
end;
procedure imprimirLista(L: lista);
var nodoActual: lista;
begin
	nodoActual:= L;
	while nodoActual <> nil do
	begin
		writeln(nodoActual^.num);
		nodoActual:= nodoActual^.sig;
	end;	
end;

procedure buscarElemento(L: lista);
var 
  nodoActual: lista;
  num: integer;
  existe: boolean;
begin
  existe := false;   // Inicializa la variable boolean
  nodoActual := L;   // Comienza en el primer nodo de la lista
  
  writeln('Ingrese el número que quiere buscar:');
  readln(num);       // Lee el número que se desea buscar
  
  // Recorre la lista
  while nodoActual <> nil do
  begin
    if nodoActual^.num = num then
    begin
      existe := true;  // El número se encontró en la lista
    end;
    nodoActual := nodoActual^.sig;  // Avanza al siguiente nodo
  end;
  
  // Imprime el resultado
  if existe then
    writeln('El elemento ', num, ' está en la lista.')
  else
    writeln('El elemento ', num, ' no está en la lista.');
end;
var
L: lista;
BEGIN
cargarLista(L);
imprimirLista(L);
buscarElemento(L);

	
	
END.

