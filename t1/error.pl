
% erro(+Erro), recebe em Erro o erro capturado pelo catch e
% imprime uma mensage de erro correspondente
erro(Erro) :-
	mensagem(Erro, Men), write('erro; '), write(Men), nl, fail.

% mensagem1(+Erro, -Men), seleciona a mensagem apropriada a ser imprimida

mensagem(error(Formal, _), Men) :- !,mensagem(Formal, Men).

mensagem(syntax_error(operator_balance), 'Operador(es) fora de lugar') :- !.

mensagem(syntax_error(operator_expected), 'Sintaxe incorreta') :- !.

mensagem(syntax_error(cannot_start_term), 'Sintaxe incorreta') :- !.

mensagem(syntax_error(end_of_file), 'Exprecao sem ponto final') :- !.

mensagem(syntax_error(operator_clash), 'Mais de um sinal de igual') :- !.

mensagem(evaluation_error(zero_divisor), 'Divisão por zero') :- !.

mensagem(sem_variavel, 'A equacao nao eh do primeiro grau') :- !.

mensagem(grau_elevado, 'A equacao nao eh do primeiro grau') :- !.

mensagem(mais_de_uma_var, 'A equacao possui mais de uma variavel') :- !.

mensagem(var_den, 'A equacao nao eh do primeiro grau') :- !.

mensagem(inicial_maiuscula, 'Variavel com inicial maiuscula') :- !.

mensagem(div_zero, 'Divisao por zero') :- !.

mensagem(espressao_inv, 'Espressao invalida') :- !.

mensagem(Erro, Erro).

% verificar characters