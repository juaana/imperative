

{1.- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que permita leer una secuencia de caracteres terminada
en punto, los
almacene en un vector con dimensión física igual a 10 y retorne el vector.
b. Un módulo que reciba el vector generado en a) e imprima el contenido del
vector.
c. Un módulo recursivo que reciba el vector generado en a) e imprima el
contenido del vector..
d. Un módulo recursivo que permita leer una secuencia de caracteres terminada
en punto y
retorne la cantidad de caracteres leídos. El programa debe informar el valor
retornado.
e. Un módulo recursivo que permita leer una secuencia de caracteres terminada
en punto y
retorne una lista con los caracteres leídos.
f. Un módulo recursivo que reciba la lista generada en e) e imprima los valores
de la lista en el
mismo orden que están almacenados.
g. Implemente un módulo recursivo que reciba la lista generada en e) e imprima
los valores de
la lista en orden inverso al que están almacenados.}

Const dimF = 5;

Type vector = array [1..dimF] Of char;
  lista = ^nodo;
  nodo = Record
    dato: char;
    sig: lista;
  End;


Procedure CargarVector (Var v: vector; Var dimL: integer);

Procedure CargarVectorRecursivo (Var v: vector; Var dimL: integer);

Var caracter: char;
Begin
  write ('Ingrese un caracter: ');
  readln(caracter);
  If (caracter <> '.' ) And (dimL < dimF)
    Then
    Begin
      dimL := dimL + 1;
      v[dimL] := caracter;
      CargarVectorRecursivo (v, dimL);
    End;
End;

Begin
  dimL := 0;
  CargarVectorRecursivo (v, dimL);
End;

Procedure ImprimirVector (v: vector; dimL: integer);

Var 
  i: integer;
Begin
  For i:= 1 To dimL Do
    write ('----');
  writeln;
  write (' ');
  For i:= 1 To dimL Do
    Begin
      write(v[i], ' | ');
    End;
  writeln;
  For i:= 1 To dimL Do
    write ('----');
  writeln;
  writeln;
End;

Function ContarCaracteres(): integer;

Var caracter: char;
Begin
  write ('Ingrese un caracter: ');
  readln(caracter);
  If (caracter <> '.' )
    Then ContarCaracteres := ContarCaracteres() + 1
  Else ContarCaracteres := 0
End;


Procedure CargarLista (Var l: lista);

Var caracter: char;
  nuevo: lista;
Begin
  write ('Ingrese un caracter: ');
  readln(caracter);
  If (caracter <> '.' )
    Then
    Begin
      CargarLista (l);
      new (nuevo);
      nuevo^.dato := caracter;
      nuevo^.sig := l;
      l := nuevo;
    End
  Else l := Nil
End;

Procedure ImprimirListaMismoOrden (l: lista);
Begin
  If (l<> Nil) Then
    Begin
      write (' ', l^.dato);
      ImprimirListaMismoOrden (l^.sig);
    End;
End;

Var cont, dimL: integer;
  l: lista;
  v: vector;
Begin
  CargarVector (v, dimL);
  writeln;
  If (dimL = 0) Then writeln ('--- Vector sin elementos ---')
  Else
    Begin
      ImprimirVector (v, dimL);
                       {ImprimirVectorRecursivo (v, dimL);}
    End;
  writeln;
  writeln;
  cont := ContarCaracteres();
  writeln;
  writeln;
  writeln('Se ingresaron ',cont,' caracteres');
  writeln;
  writeln;
  CargarLista (l);
  writeln;
  writeln;
  If (l = Nil) Then
    writeln ('--- Lista sin elementos ---')
  Else
    Begin
      writeln ('--- Orden ingresado ---');
      writeln;
      ImprimirListaMismoOrden (l);
      writeln;
      writeln;

{ writeln ('--- Orden inverso ---');
        writeln;
        ImprimirListaOrdenInverso (l); }
    End;
End.
