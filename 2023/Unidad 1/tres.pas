









{3.- Netflix ha publicado la lista de películas que estarán disponibles durante
el mes de diciembre de 2022. 
De cada película se conoce: 
- código de película, 
- código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y 
- puntaje promedio otorgado por las críticas. 

Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:

a. Lea los datos de películas, almacenelos por orden de llegada y agrúpelos
por código de género, y retorne en una estructura de datos adecuada. La lectura finaliza
cuando se lee el código de la película -1.

b. Genere y retorne en un vector, para cada género, el código de película con
mayor puntaje obtenido entre todas las críticas, a partir de la estructura generada en a).

c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno
de los dos métodos vistos en la teoría.

d. Muestre el código de película con mayor puntaje y el código de película
con menor puntaje, del vector obtenido en el punto c).}


Program tres;

Const 
  dimFGenero = 8;
  // Declaración de la constante dimFGenero con valor 8

Type 
  pelicula = Record
    // Declaración del tipo de registro "pelicula"
    codigoPelicula: integer;
    // Campo para el código de la película
    codGenero: integer;
    // Campo para el código del género de la película
    puntajePromedio: real;
    // Campo para el puntaje promedio de la película
  End;
  Lista = ^Nodo;
  // Declaración de un tipo Lista que es un puntero a un tipo Nodo
  Nodo = Record
    // Declaración del tipo de registro "Nodo"
    info: pelicula;
    // Campo que contiene la información de una película
    sig: Lista;
    // Puntero al siguiente Nodo en la lista enlazada
  End;
  vPeliculasPorGenero = array[1..dimFGenero] Of Lista;
  // Declaración de un arreglo de listas

Procedure LeeDatos(Var listaPelicula: Lista; Var vectorPeliculas:
                   vPeliculasPorGenero);

Var 
  codAux: integer;
  // Variable para el código de la película ingresada
  nue: Lista;
  // Nuevo Nodo que almacenará información de una película
  genero: integer;
  // Variable para el código del género ingresado
Begin
  writeln('Ingrese el código de la película');
  ReadLn(codAux);
  // Lee el código de película desde la entrada estándar

  While (codAux <> -1) Do
    // Continuar mientras el código de película no sea -1
    Begin
      If (codAux >= 1) And (codAux <= dimFGenero) Then
        // Verifica si el código de película es válido
        Begin
          new(nue);
          // Crea un nuevo Nodo para almacenar la película
          nue^.info.codigoPelicula := codAux;
          // Asigna el código de película al Nodo

          writeln('Ingrese el código del género de la película');
          readln(genero);
          // Lee el código de género desde la entrada estándar

          If (genero >= 1) And (genero <= dimFGenero) Then
            // Verifica si el código de género es válido
            Begin
              nue^.info.codGenero := genero;
              // Asigna el código de género al Nodo
              writeln('Ingrese el puntaje promedio de la película');
              readln(nue^.info.puntajePromedio);
              // Lee el puntaje promedio desde la entrada estándar

              nue^.sig := vectorPeliculas[genero];
              // Conecta el nuevo Nodo a la lista de su género
              vectorPeliculas[genero] := nue;
              // Actualiza la cabeza de la lista de género
            End
          Else
            writeln('Código de género no válido.');
        End
      Else
        writeln('Código de película no válido.');

      writeln('Ingrese el código de la película (-1 para salir)');
      ReadLn(codAux);
      // Lee el próximo código de película desde la entrada estándar
    End;
End;

Procedure CodPeliculaMayorPuntaje(vectorPelis: vPeliculasPorGenero; Var
                                  vPeliculas: Array Of integer);

Var 
  i: integer;
  // Variable de control para el ciclo
  actual: Lista;
  // Puntero al Nodo actual en la lista
Begin
  For i := 1 To dimFGenero Do
    // Recorre los géneros
    Begin
      vPeliculas[i] := -1;
      // Inicializa el valor con -1 (ninguna película aún)

      actual := vectorPelis[i];
      // Obtiene la cabeza de la lista de género actual
      While actual <> Nil Do
        // Recorre la lista de películas de un género
        Begin
          If (vPeliculas[i] = -1) Or (actual^.info.puntajePromedio > vPeliculas[
             i]) Then
            vPeliculas[i] := actual^.info.codigoPelicula;
          // Actualiza el código de película con mayor puntaje

          actual := actual^.sig;
          // Avanza al siguiente Nodo en la lista
        End;
    End;
End;

Procedure OrdenarVector(Var vPeliculas: Array Of integer);

Var 
  i, j, temp: integer;
  // Variables de control y temporal para la ordenación
Begin
  For i := 1 To dimFGenero - 1 Do
    // Bucle externo para recorrer los elementos del vector
    Begin
      For j := i + 1 To dimFGenero Do
        // Bucle interno para comparar y mover elementos
        Begin
          If (vPeliculas[i] > vPeliculas[j]) Then // Compara elementos
            Begin
              temp := vPeliculas[i];
              // Intercambia elementos
              vPeliculas[i] := vPeliculas[j];
              vPeliculas[j] := temp;
            End;
        End;
    End;
End;

Procedure CodigoMejorYMenorPelicula(vPeliculas: Array Of integer);

Var 
  i, codigoMayor, codigoMenor: integer;
  // Variables de control y para almacenar códigos
Begin
  codigoMayor := -1;
  // Inicializa el código de película con mayor puntaje con -1
  codigoMenor := -1;
  // Inicializa el código de película con menor puntaje con -1

  For i := 1 To dimFGenero Do
    // Recorre los géneros
    Begin
      If (vPeliculas[i] <> -1) Then
        // Verifica si hay películas válidas en el género actual
        Begin
          If (codigoMayor = -1) Or (vPeliculas[i] > vPeliculas[codigoMayor])
            Then
            codigoMayor := i;
          // Actualiza el código de película con mayor puntaje si es necesario

          If (codigoMenor = -1) Or (vPeliculas[i] < vPeliculas[codigoMenor])
            Then
            codigoMenor := i;
          // Actualiza el código de película con menor puntaje si es necesario
        End;
    End;

  If (codigoMayor <> -1) Then
    writeln('El código de la película con mayor puntaje es: ', vPeliculas[
            codigoMayor]);
  // Muestra el código de película con mayor puntaje

  If (codigoMenor <> -1) Then
    writeln('El código de la película con menor puntaje es: ', vPeliculas[
            codigoMenor]);
  // Muestra el código de película con menor puntaje
End;

Var 
  listaPelicula: Lista;
  vectorPelis: vPeliculasPorGenero;
  // Arreglo de listas para almacenar películas por género
  vPeliculas: array[1..dimFGenero] Of integer;
  // Arreglo para almacenar códigos de películas con mayor puntaje
  i: integer;
Begin
  For i := 1 To dimFGenero Do
    Begin
      vectorPelis[i] := Nil;
      // Inicializa las listas de películas por género como listas vacías
    End;
  LeeDatos(listaPelicula, vectorPelis);
  // Llama al procedimiento para ingresar datos de películas
  CodPeliculaMayorPuntaje(vectorPelis, vPeliculas);


// Llama al procedimiento para encontrar códigos de películas con mayor puntaje
  OrdenarVector(vPeliculas);
  // Llama al procedimiento para ordenar los códigos de películas
  CodigoMejorYMenorPelicula(vPeliculas);


// Llama al procedimiento para mostrar códigos de películas con mayor y menor puntaje
End.
