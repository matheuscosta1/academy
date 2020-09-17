hd([X|_], X).

cauda([_|Y], Y)
.
lenght([], 0).
lenght([_|Y], N):- lenght(Y, N1), N is N1+1.

sum([X], X).
sum([X|Y], S):- sum(Y, S1), S is S1+X, write(X), write("+"), write(S1), write("  ").

media([X|Y], M):- sum([X|Y], S), lenght([X|Y], E), M is S/E.

pertence(Elem, [Elem|_]).
pertence(Elem, [_|Y]):- pertence(Elem, Y).

ultimo([X|[]], X).
ultimo([_|Y], R):- ultimo(Y, R).

concatena([X|Y],[Z|W], L):-
