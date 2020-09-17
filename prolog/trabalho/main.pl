:- use_module(utils).
:- use_module(opcoes).

inicio :-
    consult('dados.pl'),
	consult('restricao.pl'),
    repeat, nl,
    write('----------------------'), nl,
    write('1 - Inserir filme'), nl,
    write('2 - Inserir restricao'), nl,
    write('3 - Remover restricao'), nl,
    write('4 - Listar restricoes'), nl,
    write('5 - Listar filmes conforme restricoes'), nl,
    write('6 - Sair'), nl,
    write('Opcao: '),
    le_atomo(Resp),
    (Resp = 6, nl, write('Fim do programa.');
        opcao(Resp), fail).

% Opções
opcao(1) :- !,
    insere_filme.

opcao(2) :- !,
    insere_restricao.

opcao(3) :- !,
    remove_restricao.

opcao(4) :- !,
    listing(restricao).

opcao(5) :- !,
    lista_filmes.
