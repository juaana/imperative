program NumAleatorio;
var ale , A, B, F: integer;
begin
	randomize;
	writeln('Por favor, ingrese el número más chico del rango');
	readln(A);
	writeln('Por favor, ingrese el número más grande del rango');
	readln(B);
	writeln('Por favor, ingrese el número que no debe repetirse');
	readln(F);
	ale := random (B-A+1)+A;
	while (ale <> F) do
	begin
		writeln ('El número aleatorio número ',' generado es: ', ale);
		ale := random (B-A+1)+A;
	end;
end.

