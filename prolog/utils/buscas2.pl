
resolve(Ir):-
	inicio(S),
	busca(S,S, Q),
	reverse(Q, Ir).

busca(S, P, P):- meta(S), !.
busca(S, Traco, Q):-
	proximo_estado(S,N),
	not(proibido(N)),
	\+member(N, Traco),
	busca(N, [N|Traco], Q).

inicio([n,n,n,n]).
meta([s,s,s,s]).

proximo_estado(Agr, Prox):-
	atravessar(Agr, _, Prox).

atravessar([F,L, C, R], n, [F1, L, C, R]):- troca(F, F1).
atravessar([F, F, C, R], n, [F1, F1, C, R]):-
	troca(F, F1).
atravessar([F, L, F, R], n, [F1, L, F1, R]):-
	troca(F, F1).
atravessar([F, L, C, F], n, [F1, L, C, F1]):-
	troca(F, F1).

troca(n,s).
troca(s,n).

proibido([Y,_,X,X]):- X \=Y.
proibido([Y,X,X,_]):- X \= Y.
