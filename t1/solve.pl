% solve_eq(+Equ, -Ans) recebe em Equ uma extrutura equivalente a uma equacao do
% primeiro grau e devolve em Ans a valor em que a equacao eh satisfeita.

solve_eq(=(L,R), Ans) :-
	!,value(L, L_mul, L_sum), value(R, R_mul, R_sum),
	rearrange(L_mul, L_sum, R_mul, R_sum, Ans).

% rearrange(+L_mul, +L_sum, +R_mul, +R_sum, Ans), isola x do restante da
% equacao encontrando assim seu valor.

rearrange(0, _L_sum, 0, _R_sum, _Ans) :- !,throw(sem_variavel).

rearrange(0, L_sum, Mul, R_sum, Ans) :-
	!, Sum is L_sum - R_sum, Ans is Sum / Mul.
	
rearrange(Mul, L_sum, 0, R_sum, Ans) :-
	!, Sum is R_sum - L_sum, Ans is Sum / Mul.

rearrange(L_mul, L_sum, R_mul, R_sum, Ans) :-
	Sum is L_sum - R_sum, Mul is R_mul - L_mul, Mul =\= 0, Ans is Sum/Mul.

rearrange(L_mul, _, R_mul, _, _) :-
	Mul is R_mul - L_mul, Mul =:= 0, throw(sem_variavel).

% value(+Val, -Mul, -Sum) encontra Mul e Sum de forma que o valor em Val
% seja Mul * x + Val.

value(Val, Mul, Sum) :-
	atom(Val),! , Mul = 1, Sum = 0.

value(Val, Mul, Sum) :-
	number(Val), Mul = 0, Sum = Val.

value(+(L,R), Mul, Sum) :-
	value(L, L_mul, L_sum), value(R, R_mul, R_sum),
	Mul is L_mul + R_mul, Sum is L_sum + R_sum.

value(+(A), Mul, Sum) :-
	value(A, Mul, Sum).

value(-(L,R), Mul, Sum) :-
	value(L, L_mul, L_sum), value(R, R_mul, R_sum),
	Mul is L_mul - R_mul, Sum is L_sum - R_sum.

value(-(A), Mul, Sum) :-
	value(A, A_mul, A_sum),
	Mul is 0 - A_mul, Sum is 0 - A_sum.

value(/(L,R), Mul, Sum) :-
	value(L, L_mul, L_sum), value(R, R_mul, R_sum),
	check_denominator(R_mul, R_sum),
	Mul is L_mul / R_sum, Sum is L_sum / R_sum.

value(*(L,R), Mul, Sum) :-
	value(L, L_mul, L_sum), value(R, R_mul, R_sum),
	check_high_degree(L_mul, R_mul),
	value_mul(L_mul, L_sum, R_mul, R_sum, Mul, Sum).

value_mul(L_mul, L_sum, R_mul, R_sum, Mul, Sum) :-
	L_mul =:= 0,! , Mul is R_mul * L_sum, Sum is R_sum * L_sum.

value_mul(L_mul, L_sum, _R_mul, R_sum, Mul, Sum) :-
	Mul is L_mul * R_sum, Sum is L_sum * R_sum.

% check_high_degree(+L_mul, +R_mul) verifica se o equação tem mais de uma variavel.

check_high_degree(0, _R_mul) :- !.

check_high_degree(0.0, _R_mul) :- !.

check_high_degree(_L_mul, 0) :- !.

check_high_degree(_L_mul, 0.0) :- !.

check_high_degree(_L_mul, _R_mul) :- throw(grau_elevado).

% check_denominator(+Den_mul) verifica se o denominador possue uma variavel 
% ou se eh zero

check_denominator(0, 0) :- !, throw(div_zero).

check_denominator(0, 0.0) :- !, throw(div_zero).

check_denominator(0.0, 0) :- !, throw(div_zero).

check_denominator(0, _Den_sum) :- !.

check_denominator(0.0, _Den_sum) :- !.

check_denominator(_Den_mul, _Den_sum) :- throw(var_den).
