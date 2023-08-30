
{1. Implementar un programa que procese la información de los alumnos de la Facultad de Informática.
c) Analizar: ¿qué cambios requieren los puntos a y b, si no se sabe de antemano la cantidad de materias aprobadas de cada alumno, y si además se desean registrar los aplazos? ¿cómo puede diseñarse una solución modularizada que requiera la menor cantidad de cambios?}

Program alumnxs;

Const 
  materiasTotales = 36;

Type 
  materias = array [1..materiasTotales] Of integer;

  Lista = ^Alumnos;
  Alumnos = Record
    apellido: string;
    nombre: string;
    numAlumno: integer;
    anioIngreso: integer;
    materiasAprobadas: integer;
    notasMateriasAprobadas: materias;
    siguiente: Lista;
  End;

  ListaDos = ^AlumnosDos;
  AlumnosDos = Record
    numAlumnoDos: integer;
    promedioAlumno: real;
  End;



{a) Implementar un módulo que lea y retorne, en una estructura adecuada, la información de todos los alumnos. De cada alumno se lee su apellido, número de alumno, año de ingreso, cantidad de materias aprobadas (a lo sumo 36) y nota obtenida (sin contar los aplazos) en cada una de las materias aprobadas. La lectura finaliza cuando se ingresa el número de alumno 11111, el cual debe procesarse.}
Procedure lectura(Var A: Alumnos);

Var 
  nuevo, actual: Lista;
  i: integer;
Begin
  new(nuevo);
  new(actual);
  nuevo^.siguiente := Nil;
  Repeat
    new(nuevo);

    Writeln('Escriba el apellido del alumno');
    Readln(nuevo^.apellido);

    Writeln('Escriba el nombre del alumno');
    Readln(nuevo^.nombre);

    Writeln('Escriba el número del alumno');
    Readln(nuevo^.numAlumno);

    Writeln('Escriba el año de ingreso del alumno');
    Readln(nuevo^.anioIngreso);

    Writeln('Escriba la cantidad de materias aprobadas del alumno');
    Readln(nuevo^.materiasAprobadas);

    For i:= 1 To nuevo^.materiasAprobadas Do
      Begin
        Writeln('Escriba la nota de la materia', i);
        Readln(nuevo^.notasMateriasAprobadas[i])
      End;
    actual^.siguiente := nuevo;
  Until (nuevo^.numAlumno = 11111 )


End;




{b) Implementar un módulo que reciba la estructura generada en el inciso a) y retorne número de alumno y promedio de cada alumno.}
Procedure ProcesarAlumnos(A: Alumnos; Ados: AlumnosDos);

Var 
  actual: Lista;
  actualDos: ListaDos;
  promedio: real;
  suma: real;
  i: integer;
Begin
  new(actual);
  new(actualDos);
  suma := 0;
  promedio := 0;
  While actual <> Nil Do
    Begin
      actualDos^.numAlumnoDos := actual^.numAlumno;
      For i:= 1 To actual^.materiasAprobadas Do
        Begin
          suma := suma + actual^.notasMateriasAprobadas[i];
        End;
      promedio := suma/actual^.materiasAprobadas;
      actualDos^.promedioAlumno := promedio;

      promedio := 0;
      suma := 0;
      actual := actual^.siguiente;
    End;
End;

Var 
  A: Alumnos;
  Ados: AlumnosDos;
Begin
  lectura(A);
  ProcesarAlumnos(A, Ados);

End.
