

{3.- Escribir un programa que:
a. Implemente un módulo recursivo que genere una lista de números enteros “random”
mayores a 0 y menores a 100. Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista.
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista.
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se
encuentra en la lista o falso en caso contrario.}


Program tres;

Type 
  lista = ^nodo;

  nodo = Record
    numero: integer;
    sig: lista;
  End;


{a. Implemente un módulo recursivo que genere una lista de números enteros "random" mayores a 0 y menores a 100. Finalizar con el número 0.}
Procedure numerosRandom(Var L: lista);

Var 
  nue, ant: lista;
  numero: integer;
Begin
  numero := random(99) + 1;
  // Genera un número aleatorio entre 1 y 99

  If numero <> 0 Then
    Begin
      new(nue);
      // Crea un nuevo nodo para almacenar el número
      nue^.numero := numero;
      nue^.sig := Nil;

      If L = Nil Then
        Begin
          L := nue;
          // Si la lista está vacía, el nuevo nodo se convierte en el primero
          ant := L;
        End
      Else
        Begin
          ant^.sig := nue;
          // Conectar el nuevo nodo al final de la lista
          ant := nue;
        End;

      numerosRandom(L);
      // Llamada recursiva para generar el siguiente número
    End;
End;

{b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista.}
Procedure minimoLista(L: lista; Var min: integer);
Begin
  If L <> Nil Then
    Begin
      If L^.numero < min Then
        Begin
          min := L^.numero;
        End;
      minimoLista(L^.sig, min);
    End;
End;

{c. Implemente un módulo recursivo que devuelva el máximo valor de la lista.}
Procedure maximoLista(L: lista; Var max: integer);
Begin
  If L <> Nil Then
    Begin
      If L^.numero > max Then
        Begin
          max := L^.numero;
        End;
      maximoLista(L^.sig, max);
    End;
End;


{d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se encuentra en la lista o falso en caso contrario.}
Function seEncuentra(L: lista; num: integer): boolean;
Begin
  If L = Nil Then
    Begin
      seEncuentra := false;

// Si llegamos al final de la lista y no se encuentra el número, devolvemos falso
    End
  Else If L^.numero = num Then
         Begin
           seEncuentra := true;
           // Si encontramos el número, devolvemos verdadero
         End
  Else
    Begin
      seEncuentra := seEncuentra(L^.sig, num);
      // Continuamos la búsqueda en la lista
    End;
End;

Var 
  L: lista;
  min, max, num: integer;
  esta: boolean;
Begin
  randomize;
  L := Nil;
  // Inicializa la lista vacía
  min := 101;
  max := -1;
  esta := false;

  numerosRandom(L);
  minimoLista(L, min);
  maximoLista(L, max);

  writeln('Mínimo valor en la lista: ', min);
  writeln('Máximo valor en la lista: ', max);
  write('Ingrese el número que desea saber si está en la lista: ');
  readln(num);
  esta := seEncuentra(L, num);

  If esta Then
    writeln('El número ', num, ' está en la lista.')
  Else
    writeln('El número ', num, ' no está en la lista.');
End.
