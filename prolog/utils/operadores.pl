existe_em(El, [El|_]).
existe_em(El, [_|T]):- existe_em(El, T), !.

concatena([], L, L).
concatena([X|Y], L, [X|R]):- concatena(Y, L, R).

delete(El, [El| T], T).
delete(El, [H|T], [H|R]):- delete(El, T, R), !.



/*
 * DECLARAÇÃO: op:-(<Prioridade>, <Associatividade>, <Nome>).
 *
 * xfy => associatividade à direita
 * yfx => associatividade à esquerda
 * xfx => sem associatividade
 */

:-op(50, xfx, existe_em).

/*
 * TIPAGEM:  diana  eh a cantora da tv.
 *
 * PRÉ-FIXAGEM: eh(diana, a(da(cantora, tv)))
 */

eh(diana, _).
a(_).
da(_,_).

:-op(200, xfx, eh).
:-op(180, fx, a).
:-op(160, xfx, da).

% concatena LISTA1  e LISTA2 gera LISTA3
% gera(concatena(e(LISTA1, LISTA2)), LISTA3)

e(L1,L2):-concatena(L1, L2, _).

