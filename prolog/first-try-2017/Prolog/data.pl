rgb(38,153,142)concatena([],L,L).
concatena([X|R],L,[X|C]) :-concatena(R,L,C).

adiciona(X,L,[X|L]).

tira(_,[],[]).
tira(X,[X|R],R).
tira(X,[Y|R],[Y|R1]) :- X \= Y, tira(X,R,R1).

tiraTodos(_, [], []).
tiraTodos(X, [X|Y], S):- tiraTodos(X, Y, S).
tiraTodos(X,[Y|Z], [Y|S]):-X \= Y, tiraTodos(X, Z, S).

contem(X,[X|_]).
contem(X, [_|Z]):- contem(X,Z).

adiciona_fim(X,L,NL) :-concatena(L,[X],NL).

ordena([], []).
ordena([X|Y], S):- ordena(Y, R1), insere(X, R1, S).

insere(X, [], [X]).
insere(X, [Y|Z], [X|[Y|Z]]):-X =< Y .
insere(X, [Y|Z], [Y|R]):- X > Y, insere(X,Z,R).

maior([X], X).
maior([X|Y], S):- maior(Y,S1),S1>X, S is S1.

sublista([], _).
sublista([X|Y], [Z|W]):- contem(X,[Z|W]), sublista(Y, [Z|W]).

permutacao([],[]).
permutacao([X|Y],R):-
