{1.- Se desea procesar la información de las ventas de productos de un comercio (como máximo
50).
Implementar un programa que invoque los siguientes módulos:
a. Un módulo que retorne la información de las ventas en un vector. De cada venta se conoce el
día de la venta, código del producto (entre 1 y 15) y cantidad vendida (como máximo 99
unidades). El código debe generarse automáticamente (random) y la cantidad se debe leer. El
ingreso de las ventas finaliza con el día de venta 0 (no se procesa).
b. Un módulo que muestre el contenido del vector resultante del punto a).
c. Un módulo que ordene el vector de ventas por código.
d. Un módulo que muestre el contenido del vector resultante del punto c).
e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos
valores que se ingresan como parámetros.
f. Un módulo que muestre el contenido del vector resultante del punto e).
g. Un módulo que retorne la información (ordenada por código de producto de menor a
mayor) de cada código par de producto junto a la cantidad total de productos vendidos.
h. Un módulo que muestre la información obtenida en el punto g).}
program uno;

const
  dimF = 50;

type
  venta = record
    diaVenta: integer;
    codigoProducto: integer;
    cantVendida: integer;
  end;

  ventasTotales = array [1..dimF] of venta;
  
//a. Un módulo que retorne la información de las ventas en un vector. De cada venta se conoce el día de la venta, código del producto (entre 1 y 15) y cantidad vendida (como máximo 99 unidades). El código debe generarse automáticamente (random) y la cantidad se debe leer. El ingreso de las ventas finaliza con el día de venta 0 (no se procesa).

procedure cargarVentasAVector(var vTotales: ventasTotales; var dimL: integer);
var
  aux: integer;
begin
    Writeln('Ingrese el día de venta');
    Readln(aux);
    
    if (aux <> 0) and (dimL <= dimF) then
    begin
      dimL := dimL + 1; //Esto es como si inicializara dimL en 1 
      vTotales[dimL].diaVenta := aux;
      Writeln('Ingrese la cantidad vendida');
      Readln(vTotales[dimL].cantVendida);
      vTotales[dimL].codigoProducto := random(15) + 1;
      cargarVentasAVector(vTotales, dimL);
    end;
end;

//b. Un módulo que muestre el contenido del vector resultante del punto a).
procedure muestraContVector(vTotales: ventasTotales; dimL: integer);
var
  aux: integer;
begin
  for aux := 1 to dimL do
  begin
    Writeln('Producto ', vTotales[aux].codigoProducto);
    Writeln('                         ');
    Writeln('Día de venta ', vTotales[aux].diaVenta);
    Writeln('Cantidad vendida del producto ', vTotales[aux].codigoProducto, ': ', vTotales[aux].cantVendida);
    Writeln('----------------------------------------------------')
  end;
end;
// c. Un módulo que ordene el vector de ventas por código.
procedure ordenarVentasPorCodigo(var vTotales: ventasTotales; dimL: integer);
var
  i, j, indiceMinimo: integer;
  temp: venta;
begin
  for i := 1 to dimL - 1 do
  begin
    indiceMinimo := i;

    // Encuentra el índice del códigoProducto mínimo en la parte no ordenada del array
    for j := i + 1 to dimL do
    begin
      if vTotales[j].codigoProducto < vTotales[indiceMinimo].codigoProducto then
        indiceMinimo := j;
    end;

    // Intercambia los elementos en indiceMinimo e i para ordenar el array
    temp := vTotales[i];
    vTotales[i] := vTotales[indiceMinimo];
    vTotales[indiceMinimo] := temp;
  end;
end;
// e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos valores que se ingresan como parámetros.
procedure Eliminar(var vTotales: ventasTotales; var dimL: integer);
var
  menorNum: integer;
  mayorNum: integer;
  i, dimLAux: integer;
begin
  Writeln('Ingrese los dos valores de código entre los que desea eliminar los productos');
  Readln(menorNum);
  Readln(mayorNum);

  dimLAux := 1; // Variable para rastrear la nueva dimensión del vector después de la eliminación

  for i := 1 to dimL do
  begin
    if not ((vTotales[i].codigoProducto >= menorNum) and (vTotales[i].codigoProducto <= mayorNum)) then
    begin
      // No está dentro del rango especificado, copia la venta al nuevo vector
      vTotales[dimLAux] := vTotales[i];
      dimLAux := dimLAux + 1;
    end;
  end;

  // Actualiza la nueva dimensión del vector después de la eliminación
  dimL := dimLAux - 1;
end;

// g. Un módulo que retorne la información (ordenada por código de producto de menor a mayor) de cada código par de producto junto a la cantidad total de productos vendidos.
procedure CodigosPares(var vTotales: ventasTotales; dimL: integer; var codigosPares: array of integer; var cantidadesTotales: array of integer);
var
  i: integer;
begin

// Calcula la cantidad total vendida por cada código par de producto y los pasa al array nuevo
for i := 1 to dimL do
	begin
		if (vTotales[i].codigoProducto mod 2 = 0) then
			begin
				codigosPares[vTotales[i].codigoProducto] := vTotales[i].codigoProducto;
				cantidadesTotales[vTotales[i].codigoProducto] := cantidadesTotales[vTotales[i].codigoProducto] + vTotales[i].cantVendida;
			end;
		end; 
end;

procedure mostrarContenido(codigosPares: array of integer; cantidadesTotales: array of integer);
var
  i: integer;
begin
  Writeln('Información ordenada por código de producto par');
  for i := 1 to 15 do
  begin
    if (codigosPares[i] <> 0) then
    begin
      Writeln('Código de Producto: ', codigosPares[i]);
      Writeln('Cantidad Total Vendida: ', cantidadesTotales[i]);
      Writeln('--------------------------');
    end;
  end;
end;

var
  dimL: integer;
  vTotales: ventasTotales;
  cPares, cantTotales: array[1..15] of integer;
begin
  randomize;
  cargarVentasAVector(vTotales, dimL);
  muestraContVector(vTotales, dimL);
  ordenarVentasPorCodigo(vTotales,dimL);
  Writeln('VECTOR ORDENADO');
  Writeln('----------------------');
  muestraContVector(vTotales,dimL);
  Eliminar(vTotales,dimL);
  Writeln('VECTOR CON EL RANGO ELIMINADO');
  Writeln('----------------------');
  muestraContVector(vTotales,dimL);
  codigosPares(vTotales,dimL, cPares, cantTotales);
  mostrarContenido(cPares, cantTotales);
  
end.
