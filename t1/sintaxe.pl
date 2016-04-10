% checa_stx(+Equ) recebe uma espressao e verifica se os elementos que nao
% sao operadores estao de acordo com o sintaxe especificada.

checa_stx(Equ) :- lista_var(Equ, L), checa_var(L). 

% lista_var(+Esp, -L) gera em L uma lista dos atomos de Esp (possiveis
% variaveis validas), tambem verifica a presença de palavras iniciadas
% com maiuscula (variaveis invalidas).

lista_var(Esp, [Esp]) :-
	atom(Esp), !.

lista_var(Esp, []) :-
	number(Esp), !.

lista_var(Esp, _) :-
	var(Esp), !, throw(inicial_maiuscula).

lista_var(=(A,B), L) :-
	!, lista_var(A, L1), lista_var(B, L2), append(L1, L2, L). 

lista_var(+(A,B), L) :-
	!, lista_var(A, L1), lista_var(B, L2), append(L1, L2, L). 

lista_var(+(A), L) :-
	!, lista_var(A, L).

lista_var(-(A,B), L) :-
	!, lista_var(A, L1), lista_var(B, L2), append(L1, L2, L).

lista_var(-(A), L) :-
	!, lista_var(A, L).

lista_var(/(A,B), L) :-
	!, lista_var(A, L1), lista_var(B, L2), append(L1, L2, L). 

lista_var(*(A,B), L) :-
	!, lista_var(A, L1), lista_var(B, L2), append(L1, L2, L).

lista_var(_, _) :- throw(espressao_inv).

% checa_var(+L) verifica se ah apenas uma variavel na equacao

checa_var([_]) :- !.

checa_var([Var1,Var2|T]) :-
	checa_var([Var2|T]), Var1 = Var2, !.

checa_var(_) :- throw(mais_de_uma_var).