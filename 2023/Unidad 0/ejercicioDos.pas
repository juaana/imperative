

{Implementar un programa que procese información de propiedades que están a la venta
en una inmobiliaria. Se pide:
a) Implementar un módulo para almacenar en una estructura adecuada, las propiedades
agrupadas por zona. Las propiedades de una misma zona deben quedar almacenadas
ordenadas por tipo de propiedad. Para cada propiedad debe almacenarse el código, el tipo de
propiedad y el precio total. De cada propiedad se lee: zona (1 a 5), código de propiedad, tipo
de propiedad, cantidad de metros cuadrados y precio del metro cuadrado. La lectura finaliza
cuando se ingresa el precio del metro cuadrado -1.
b) Implementar un módulo que reciba la estructura generada en a), un número de zona y un tipo de
propiedad y retorne los códigos de las propiedades de la zona recibida y del tipo recibido}

Program dos;

Const 
  //Constante de corte
  corte = -1;
  //Constante dimensión física
  dimF = 5;

Type 
  Zonas = 1..dimF;
  //Calcular precio por m2
  calcular = Record
    cantMts2: Real;
    precioMts2: Real;
    precioTotal: Real;
  End;
  //Nodo de propiedad
  propiedad = Record
    zona: Zonas;
    codigo: Integer;
    tipo_propiedad: Integer;
    precio: calcular;
    // metros cuadrado * precio metro cuadrado
  End;

  //Nodo siguiente
  lista = ^nodo;




//El nodo es un registro que tiene los datos de la propiedad y el siguiente de la lista
  nodo = Record
    dato: propiedad;
    //Dato que contiende
    sig: lista;
    //Siguiente nodo
  End;

  Propiedades = array [Zonas] Of lista;
  {Array de dimF=5 de listas que tienen los noditos}

{------------------------------------------------------}

Procedure inicializarVectorLista (Var v: Propiedades);
//Inicializa toda la dimF con las listas en nil

Var i: Integer;
Begin
  For i:= 1 To dimF Do
    v[i] := Nil;
End;
{------------------------------------------------------}

Procedure leerPropiedad (Var p: propiedad);
Begin
  Writeln('Ingrese la zona: ');
  ReadLn(p.zona);
  Writeln('Ingrese el codigo de la propiedad: ');
  ReadLn(p.codigo);
  Writeln('Ingrese el tipo de propiedad: ');
  ReadLn(p.tipo_propiedad);
  Writeln('Ingrese la cantidad de mts2 ');
  ReadLn(p.precio.cantMts2);
  Writeln('Ingrese el precio del mtr2 ');
  ReadLn(p.precio.precioMts2);
  If (p.precio.precioMts2 <> corte) Then
    p.precio.precioTotal := (p.precio.cantMts2 * p.precio.precioMts2);
  WriteLn('---------------')
End;
{------------------------------------------------------}

Procedure insertarOrdenado(Var l: lista; p: propiedad);

Var nue,ant,act: lista;
Begin
  ant := l;
  act := l;
  new(nue);
  nue^.dato := p;
  While (act <> Nil) And (p.tipo_propiedad > act^.dato.tipo_propiedad) Do
    Begin
      ant := act;
      act := act^.sig;
    End;
  If (act = ant) Then
    L := nue
  Else
    ant^.sig := nue;
  nue^.sig := act;
End;
{------------------------------------------------------}

Procedure cargarPropiedad (Var v: Propiedades);

Var p: propiedad;
Begin
  leerPropiedad(p);
  While (p.precio.precioMts2 <> corte) Do
    Begin
      insertarOrdenado(v[p.zona],p);
      leerPropiedad(p);
    End;
End;
{------------------------------------------------------}
//Inciso B
Procedure filtrarPropiedades (V: Propiedades; numZona:Zonas; tipoProp: integer);
Begin
  While (V[numZona] <> Nil) And (V[numZona]^.dato.tipo_propiedad <= tipoProp) Do
    Begin
      If (V[numZona]^.dato.tipo_propiedad = tipoProp) Then
        writeln('Codigo de propiedad: ',V[numZona]^.dato.codigo);
      V[numZona] := V[numZona]^.sig;
    End;
End;
{------------------------------------------------------}

Var 
  v: Propiedades;
  numZona: Zonas;
  tipoPropiedad: Integer;
Begin
  inicializarVectorLista(v);
  cargarPropiedad(v);
  Writeln('Ingrese un numero de zona: ');
  readln(numZona);
  Writeln('Ingrese un tipo de propiedad: ');
  readln(tipoPropiedad);
  filtrarPropiedades(v,numZona,tipoPropiedad);
End.
