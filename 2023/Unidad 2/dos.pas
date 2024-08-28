
{2.- Realizar un programa que lea números hasta leer el valor 0 e imprima, para
cada número leído, sus dígitos en el orden en que aparecen en el número. Debe
implementarse un módulo recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor
256, se debe imprimir 2 5 6}

Program dos;

{------------------------------------------------------}

Procedure imprimirDigitos(num: integer);
Begin
  If num <> 0 Then
    // Verifica si el número no es igual a 0 (caso base de la recursión)
    Begin
      imprimirDigitos(num Div 10);

   // Llamada recursiva con el cociente (elimina el dígito menos significativo)
      Write(num Mod 10, ' ');
      // Imprimir el dígito menos significativo
    End;
End;

{------------------------------------------------------}

Procedure procesamientoDeNumeros();
// Definición del procedimiento principal de procesamiento

Var 
  num: integer;
  // Variable para almacenar el número ingresado por el usuario
Begin
  Writeln('Ingrese un numero');

  Readln(num);

  If num <> 0 Then
    // Verifica si el número no es igual a 0 (caso base de la recursión)
    Begin
      imprimirDigitos(num);
      // Llama al procedimiento para imprimir los dígitos del número
      Writeln();
      procesamientoDeNumeros();
      // Llamada recursiva para procesar más números
    End;
End;

{------------------------------------------------------}

{------------------- PROGRAMA PRINCIPAL ---------------}

Begin
  procesamientoDeNumeros();
End.
