% solve_eq(+Equ, -Ans) recebe em Equ uma extrutura equivalente a uma equacao do
% primeiro grau e devolve em Ans a valor em que a equacao e satisfeita.

solve_eq(Equ, Ans) :-
	Equ = =(L,R), value(L, L_mul, L_sum), value(R, R_mul, R_sum),
	rearrange(L_mul, L_sum, R_mul, R_sum, Ans).

% rearrange(+L_mul, +L_sum, +R_mul, +R_sum, Ans), isola x do restante da
% equacao encontrando assim seu valor.

rearrange(0, _L_sum, 0, _R_sum, _Ans) :- 1 = 2. % ERRO

rearrange(L_mul, _L_sum, R_mul, _R_sum, _Ans) :-
	L_mul =\= 0, R_mul =\= 0. %ERRO

rearrange(0, L_sum, Mul, R_sum, Ans) :-
	Mul =\= 0, Sum is L_sum - R_sum, Ans is Sum / Mul.
	
rearrange(Mul, L_sum, 0, R_sum, Ans) :-
	Mul =\= 0, Sum is R_sum - L_sum, Ans is Sum / Mul.

% value(+Val, -Mul, -Sum) encontra Mul e Sum de forma que o valor em Val
% seja Mul * x + Val.

value(Val, Mul, Sum) :-
	var(Val), Mul = 1, Sum = 0.

value(Val, Mul, Sum) :-
	number(Val), Mul = 0, Sum = Val.

value(+(L,R), Mul, Sum) :-
	value(L, L_mul, L_sum), value(R, R_mul, R_sum),
	check_high_degree(L_mul, R_mul),
	Mul is L_mul + R_mul, Sum is L_sum + R_sum.

value(-(L,R), Mul, Sum) :-
	value(L, L_mul, L_sum), value(R, R_mul, R_sum),
	check_high_degree(L_mul, R_mul), Mul is L_mul - R_mul,
	Sum is L_sum - R_sum.

value(/(L,R), Mul, Sum) :-
	value(L, L_mul, L_sum), value(R, R_mul, R_sum),
	check_denominator(R_mul, R_sum),
	Mul is L_mul / R_sum, Sum is L_sum / R_sum.

value(*(L,R), Mul, Sum) :-
	value(L, L_mul, L_sum), value(R, R_mul, R_sum),
	check_high_degree(L_mul, R_mul),
	value_mul(L_mul, L_sum, R_mul, R_sum, Mul, Sum).

value_mul(L_mul, L_sum, R_mul, R_sum, Mul, Sum) :-
	L_mul =:= 0, Mul is R_mul * L_sum, Sum is R_sum * L_sum.

value_mul(L_mul, L_sum, _R_mul, R_sum, Mul, Sum) :-
	L_mul =\= 0, Mul is L_mul * R_sum, Sum is L_sum * R_sum.

% check_high_degree(+L_mul, +R_mul) verifica se o equação tem mais de uma variavel.

check_high_degree(L_mul,R_mul) :-
	L_mul =\= 0, R_mul =\= 0. %ERRO

check_high_degree(L_mul, _R_mul) :-
	L_mul =:= 0.

check_high_degree(_L_mul,R_mul) :-
	R_mul =:= 0.

% check_denominator(+Den_mul) verifica se o denominador possue uma variavel 
% ou se eh zero

check_denominator(Den_mul, Den_sum) :-
	Den_mul =:= 0, Den_sum =:=0. %ERRO

check_denominator(Den_mul, _Den_sum) :-
	Den_mul =\= 0. %ERRO

check_denominator(Den_mul, Den_sum) :-
	Den_mul =:= 0, Den_sum =\=0.

% Le entrada, calcula resposta e imprime a resposta. 

:- read(Equ), solve_eq(Equ, Ans), write(Ans), nl.