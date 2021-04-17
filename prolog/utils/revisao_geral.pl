%Listas

ver(X, Y, Z, [X,Y, Z|_]).

censurar_par([], []).
censurar_par([X], [X]).
censurar_par([X, _|Y], [X,censurado|R]):-
		alterar(Y, R).

contar(_, [], 0).
contar(X, [Y|_], 0):- X =\=Y.
contar(X, [X|Y], N):- 
		contar(X,Y, R),!,
		N is R+1.

deletar(_, [], []).
deletar(0, Lista, Lista).
deletar(Size, [_|Y], R):- 
		S1 is Size-1, 
		deletar(S1, Y, R).

simplificar([], []).
simplificar([Head|Tail], [(Head,Soma)|R]):- 
		contar(Head, [Head|Tail], Soma), 
		deletar(Soma,[Head|Tail], Lista2),
		!,simplificar(Lista2, R).


addN(0, _, L, L):- !.
addN(N, X, L, [X|L2]):-
		N1 is N-1, 
		addN(N1, X, L, L2).

desimplificar([(Termo, Vezes)], Res):- 
		addN(Vezes, Termo, [], Res), !.

desimplificar([(Termo, Vezes)| Resto], Res):-
		desimplificar(Resto, Res2), 
		addN(Vezes, Termo, Res2, Res).

escreverLista([]):- !.
escreverLista([X | Y]):- 
		write(X), write(", "),
		escreverLista(Y).

% Inserindo sem reptição
inserir(X, L, L):- member(X, L), !.
inserir(X, L, [X|L]).



