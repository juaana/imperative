
{Implementar un programa que procese las ventas de un supermercado. El supermercado
dispone de una tabla con los precios y stocks de los 1000 productos que tiene a la venta.

a) Implementar un módulo que retorne, en una estructura de datos adecuada, los tickets de las ventas.
De cada venta se lee código de venta y los productos vendidos. Las ventas finalizan con el código de
venta -1. 

De cada producto se lee código y cantidad de unidades solicitadas. Para cada venta, la lectura
de los productos a vender finaliza con cantidad de unidades vendidas igual a 0. El ticket debe contener:
- Código de venta
- Detalle (código de producto, cantidad y precio unitario) de los productos que se pudieron vender. En
caso de no haber stock suficiente, se venderá la máxima cantidad posible.
- Monto total de la venta.

b) Implementar un módulo que reciba la estructura generada en el inciso a) y un código de
producto y retorne la cantidad de unidades vendidas de ese código de producto.}


Program ej3;

Const 
  dimF = 1000;
  // Debería ser 1000 para tener 1000 productos

Type 
  // Datos del super
  rango1000 = 1..dimF;

  // Columnas
  tabla = Record
    precio: real;
    stock: integer;
  End;

  // Filas
  vTabla = array[rango1000] Of tabla;

  // Detalle de compra
  venta = Record
    codProducto: integer;
    cantidadDeUnidadesVendidas: integer;
    precioUnitario: real;
  End;

  listaDetalle = ^nodoDetalle;

  nodoDetalle = Record
    dato: venta;
    sig: listaDetalle;
  End;

  // Un ticket
  ticket = Record
    codigoDeVenta: integer;
    detalle: listaDetalle;
    montoTotalDeVenta: real;
  End;

  listaTicket = ^nodoTicket;

  // Lista de todos los tickets
  nodoTicket = Record
    dato: ticket;
    sig: listaTicket;
  End;

Procedure leerTabla(Var t: tabla);
Begin
  // Lee precio y stock de lo que tiene el super
  writeln('Ingrese el precio del producto: ');
  readln(t.precio);
  writeln('Ingrese el stock del producto: ');
  readln(t.stock);
End;

Procedure cargarVtabla(Var v: vTabla);

Var 
  t: tabla;
  i: integer;
Begin
  For i := 1 To dimF Do
    Begin
      leerTabla(t);
      v[i] := t;
    End;
End;

Procedure inicializarLista(Var L: listaTicket);
Begin
  L := Nil;
End;

Procedure leerProducto(Var p: venta; Var v: vTabla);
Begin
  // Lee un producto
  writeln('Ingrese el codigo del producto: ');
  readln(p.codProducto);
  writeln('Ingrese la cantidad de unidades solicitadas: ');
  readln(p.cantidadDeUnidadesVendidas);
  p.precioUnitario := v[p.codProducto].precio;
End;

Procedure inicializarListaProductos(Var l: listaDetalle);
Begin
  l := Nil;
End;

Procedure validaStock(Var p: venta; Var v: vTabla);
Begin
  // Si lo que le pido es igual o menor a la cantidad que tengo en stock
  If (v[p.codProducto].stock >= p.cantidadDeUnidadesVendidas) Then
    Begin
      // Resto la cantidad vendida del stock
      v[p.codProducto].stock := v[p.codProducto].stock - p.
                                cantidadDeUnidadesVendidas;
    End
    // Sino
  Else
    Begin
      // Si la cantidad que pido es mayor o igual al stock
      If (p.cantidadDeUnidadesVendidas >= v[p.codProducto].stock) Then
        Begin
          // La cantidad de Unidades vendidas es igual al stock actual
          p.cantidadDeUnidadesVendidas := v[p.codProducto].stock;
          // Dejo guardado en la tabla que el producto no tiene más stock
          v[p.codProducto].stock := 0;
        End;
    End;
End;

// Agrego producto nuevo
Procedure agregarProductoADetalle(Var L, UltProducto: listaDetalle; p: venta);

Var 
  nuevoProducto: listaDetalle;
Begin
  // Nuevo nodo
  new(nuevoProducto);
  // Los datos del producto son iguales a los datos de la venta
  nuevoProducto^.dato := p;
  // Agrego siguiente dirección en nil
  nuevoProducto^.sig := Nil;
  // Si la lista esta en nil entonces la lista va a ser solo el producto nuevo
  If (L = Nil) Then
    L := nuevoProducto


// Si la lista tiene algo entonces el último producto que tenía guarda la dirección del producto que estoy agregando
  Else
    UltProducto^.sig := nuevoProducto;


// El último producto ahora es aquel que estoy agregando (Así siempre guardo cuál es el último producto)
  UltProducto := nuevoProducto;
End;

// Tengo que guardar todos los tickets para saber las ventas que tuve
Procedure agregarUnNuevoTicket(Var L, UltTicket: listaTicket; t: ticket);

Var 
  nuevoTicket: listaTicket;
Begin
  // Hago lo mismo que en el procedimiento anterior pero con los tickets
  new(nuevoTicket);
  nuevoTicket^.dato := t;
  nuevoTicket^.sig := Nil;
  If (L = Nil) Then
    L := nuevoTicket
  Else
    UltTicket^.sig := nuevoTicket;
  UltTicket := nuevoTicket;
End;

Procedure leerVentas(Var L: listaTicket; Var v: vTabla);

Var 
  p: venta;
  UltProducto: listaDetalle;
  UltTicket: listaTicket;
  tick: ticket;
  // Uso de registro auxiliar para acceder a la lista
Begin
  tick.codigoDeVenta := 1;
  // Inicializamos el código de venta a 1
  While (tick.codigoDeVenta <> -1) Do
    Begin
      leerProducto(p, v);
      inicializarListaProductos(tick.detalle);
      While (p.cantidadDeUnidadesVendidas <> 0) Do
        //Condición de corte
        Begin
          validaStock(p, v);
          agregarProductoADetalle(tick.detalle, UltProducto, p);
          leerProducto(p, v);
        End;
      // Calcular monto total de la venta
      tick.montoTotalDeVenta := 0;
      UltProducto := tick.detalle;
      While (UltProducto <> Nil) Do
        Begin
          tick.montoTotalDeVenta := tick.montoTotalDeVenta + UltProducto^.dato.
                                    cantidadDeUnidadesVendidas * UltProducto^.
                                    dato.precioUnitario;
          UltProducto := UltProducto^.sig;
        End;
      // Agrego un nuevo ticket
      agregarUnNuevoTicket(L, UltTicket, tick);
      // Creo un nuevo número de ticket
      tick.codigoDeVenta := tick.codigoDeVenta + 1;
    End;
End;

// Me dedico al inciso C, función para poder meterlo dentro del Writeln
Function informarCantidad(L: listaTicket; codBuscado: integer): integer;

Var 
  ListaProductos: listaDetalle;
  contTotal: integer;
Begin
  // Inicializo el contador en 0
  contTotal := 0;
  // Recorro la lista de tickets
  While (L <> Nil) Do
    Begin
      // Entro a la lista de detalle del ticket actual
      ListaProductos := L^.dato.detalle;
      // Recorro la lista de detalle del ticket actual
      While (ListaProductos <> Nil) Do
        Begin
          // Si el código de producto es igual al código buscado
          If (ListaProductos^.dato.codProducto = codBuscado) Then
            Begin
              // Incremento el contador
              contTotal := contTotal + ListaProductos^.dato.
                           cantidadDeUnidadesVendidas;
            End;
          // Cambio al siguiente detalle
          ListaProductos := ListaProductos^.sig;
        End;
      // Cambio al siguiente ticket
      L := L^.sig;
    End;
  // Informo el contador
  informarCantidad := contTotal;
End;

Var 
  v: vTabla;
  Ltickets: listaTicket;
  codProducBuscado: integer;
Begin
  randomize;

{ Randomize inicia la generación de números aleatorios, usando una semilla cuyo valor se toma a partir del reloj interno del equipo. Por eso, debes usarlo sólo una vez. Si lo usas varias veces para generar varios números (o, de forma más general, varias secuencias de números), es probable que todas las secuencias comiencen en el mismo instante, por lo que tendrán la misma semilla y, por tanto, serán exactamente la misma secuencia. }
  cargarVtabla(v);
  inicializarLista(Ltickets);
  leerVentas(Ltickets, v);



// Implementar un módulo que reciba la estructura generada en el inciso a) y un código de producto y retorne la cantidad de unidades vendidas de ese código de producto
  writeln(

  'Ingrese un código de producto para saber la cantidad de unidades vendidas: '
  );
  readln(codProducBuscado);
  writeln('La cantidad total de productos vendidos de código ',
          codProducBuscado, ' es: ', informarCantidad(Ltickets, codProducBuscado
  ));
End.
