:- module(utils, [le_atomo/1]).

% ------------------------------------------------------------------------------
% le_atomo: ler string/caractere sem a necessidade do ponto
le_atomo(Atomo) :-
    le_str(String),
    name(Atomo, String).
le_str(String) :-
    get0(Char),
    le_str_aux(Char, String).
    le_str_aux(-1, []) :- !. % EOF
    le_str_aux(10, []) :- !. % EOL(UNIX)
    le_str_aux(13, []) :- !. % EOL (DOS)
    le_str_aux(Char, [Char|Resto]) :-
    le_str(Resto).
% ------------------------------------------------------------------------------

% Não dá pra usar pois retorna falso e termina a execucao
break_list(L, Resultado) :-
    break_custom_list(L, 0, Resultado).
break_custom_list([H|T], Parcial, Resultado) :-
    NovaParcial is Parcial + 1,
    write(NovaParcial), write(' - '), write(H), nl,
    break_custom_list(T, NovaParcial, Resultado).

