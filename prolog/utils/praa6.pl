p(X):- r(X).
q(X):- s(X).
q(X):- t(X).
r(0).
r(1).
s(2).
s(3).
t(4).
t(5).

diferente(X, X):- !,fail.
diferente(_,_).

not2(X):- call(X), !, fail.
not2(_).
