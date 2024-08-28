
{
   2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
las expensas de dichas oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.
   
   
}

Program dos;

Const 
  dimF = 300;

Type 
  oficina = Record
    codigoIdentificacion: integer;
    DNI: integer;
    valorExpensa: real;
  End;

  registroOficinas = array [1..dimF] Of oficina;





{a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra.
De cada oficina se ingresa el código de identificación, DNI del propietario y valor de la
expensa. La lectura finaliza cuando se ingresa el código de identificación -1, el cual no se
procesa.}
Procedure leerOficina (Var oficinas: registroOficinas; dimL: integer);

Var 
  aux: integer;
Begin
  dimL := dimL +1;
  WriteLn('Ingrese el código de identificación');
  ReadLn(aux);

  If (aux <> -1) And (dimL<dimF) Then
    Begin
      oficinas[dimL].codigoIdentificacion := aux;
      WriteLn('Ingrese el DNI del propietario');
      ReadLn(oficinas[dimL].DNI);
      WriteLn('Ingrese el valor de las expensas');
      ReadLn(oficinas[dimL].valorExpensa);
      leerOficina(oficinas, dimL);
    End;

End;




{b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
oficina.}
Procedure ordenInsercion(Var oficinas: registroOficinas; dimL: integer);

Var 
  i, indexAux: integer;
  // Declaración de variables enteras para índices
  actual: oficina;




// Declaración de una variable de tipo "oficina" para almacenar el valor actual
Begin
  For i := 2 To dimL Do
    // Bucle que comienza desde el segundo elemento hasta el último
    Begin
      actual := oficinas[i];
      // Almacena el valor actual en la variable "actual"
      indexAux := i - 1;
      // Inicializa el índice auxiliar con el valor anterior

      // Bucle while para comparar y mover elementos hacia la derecha




//Condición: comparo si el elemento anterior es mas grande que el elemento en el que estoy parado
      While (indexAux > 0) And (oficinas[indexAux].codigoIdentificacion > actual
            .codigoIdentificacion) Do

        Begin
          oficinas[indexAux + 1] := oficinas[indexAux];
          // Mueve el elemento hacia la derecha
          indexAux := indexAux - 1;
          // Disminuye el índice auxiliar
        End;

      oficinas[indexAux + 1] := actual;
      // Coloca el valor actual en su posición correcta
    End;
End;




{c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.}
Procedure ordenSeleccion(Var oficinas: registroOficinas; dimL: integer);

Var 
  i, indiceAux, pos: integer;
Begin
  For i:=1 To dimL-1 Do
    Begin {busca el mínimo y guarda en pos la posición}
      pos := i;
      For indiceAux:= i+1 To dimL Do
        If oficinas[indiceAux].codigoIdentificacion < oficinas[pos].
           codigoIdentificacion Then
          pos := indiceAux;
    End;
End;

Var 
  dimLog: integer;
  oficinas: registroOficinas;

Begin
  dimLog := 0;
  leerOficina(oficinas, dimLog);
  ordenInsercion(oficinas, dimLog);
  ordenSeleccion(oficinas, dimLog);
End.
