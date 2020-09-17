
:-op(100, fx, concatena).
:-op(120, xfy, gera).

concatena([], Lista2, Lista2).
concatena([H|T],Lista2, [H|Lista3]):- concatena(T, Lista2, Lista3).

concatena List1 e List2 gera List3:- concatena(List1, List2, List3).

:-op(100, fx, se).
:-op(120, xfx, entao).
:-op(60, yfx, e).

se X entao Y:-  not(X) | Y.

:-op(100, xfx, <==>).
:-op(20, fx, ~).
:-op(50, yfx, &).
:-op(50, yfx, $).

A & B :- not(not(A) | not(B)), !.
A $ B:- A | B, !.
~ A :- not(A), !.
A <==> B :-  A =:= B, !.
