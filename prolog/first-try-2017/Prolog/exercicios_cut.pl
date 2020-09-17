p(1).
p(2):- !.
p(3).

classe(0, nulo):- !.
classe(N, positivo):- N > 0, !.
classe(_, negativo).

reparteLista([], [], []).
reparteLista([X|Y], [X|Positivos], Negativos):-
		X >= 0, !,
		reparteLista(Y, Positivos, Negativos). 
reparteLista([X|Y], Positivos, [X| Negativos]):-
		reparteLista(Y, Positivos, Negativos).

unificavel([], _, []).
unificavel([X|Y], Termo, [X|Retorno]):-
		not(not(X = Termo)), !,
		unificavel(Y, Termo, Retorno).
unificavel([_|Y], Termo, Retorno):- 
		unificavel(Y, Termo, Retorno).
