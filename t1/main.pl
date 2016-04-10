% Le entrada, verifica por erros, calcula resposta e imprime a resposta. 

main :- [solve], [error], [sintaxe],
	catch(read(Equ), error(Formal, _), erro(Formal)),
	catch(checa_stx(Equ), Erro, erro(Erro)),
	catch(solve_eq(Equ, Ans), Erro, erro(Erro)),
	write(Ans), nl.