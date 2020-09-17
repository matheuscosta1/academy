:- module(opcoes, [
    insere_filme/0,
    insere_restricao/0,
    remove_restricao/0,
    lista_filmes/0
]).

% Inserir filme
insere_filme :-
    write('Nome do filme: '), le_atomo(Filme),
    write('Qual o genero do filme? '), le_atomo(Genero),
    write('Quem é/são o(s) protagonista(s) do filme? '), le_atomo(Atores),
    write('Quem é o(a) diretor(a) do filme? '), le_atomo(Diretor),
    write('É série ou filme? '), le_atomo(Serie),
    write('Tags: '), le_atomo(Tags),
    write('Estudio produtor: '), le_atomo(Estudio),
    assertz(filme(Filme, Genero, [Atores], Diretor, Serie, [Tags], Estudio)),
    append('dados.pl'),
    write(filme(Filme, Genero, [Atores], Diretor, Serie, [Tags], Estudio)), write('.'),
    told.

insere_restricao :-
    write('Restringir pelo o que?'), nl,
    write('Opções:'), nl,
    write('1 - Genero'), nl,
    write('2 - Ator'), nl,
    write('3 - Tags'), nl,
    write('4 - Diretor'), nl,
    write('5 - Estudio'), nl,
    write('Opcao: '), le_atomo(Opcao),
    (
        Opcao = 1,
            write('Generos disponiveis:'), nl, findall(X, genero(X), L), write(L), nl, nl,
            write('Escolha: '), le_atomo(Escolha),
            assertz(restricao(genero(Escolha))), append('restricao.pl'),
            write(restricao(genero(Escolha))), write('.\n'),
            told;
        Opcao = 2,
            write('Atores disponiveis:'), nl, findall(X, ator(_, X), L), write(L), nl, nl,
            write('Escolha: '), le_atomo(Escolha),
            assertz(restricao(ator(_, Escolha))), append('restricao.pl'),
            write(restricao(ator(_, Escolha))), write('.\n'),
            told;
        Opcao = 3,
            write('Tags disponiveis:'), nl, findall(X, tag(X), L), write(L), nl, nl,
            write('Escolha: '), le_atomo(Escolha),
            assertz(restricao(tag(Escolha))), append('restricao.pl'),
            write(restricao(tag(Escolha))), write('.\n'),
            told;
        Opcao = 4,
            write('Diretores disponiveis:'), nl, findall(X, diretor(_, X), L), write(L), nl, nl,
            write('Escolha: '), le_atomo(Escolha),
            assertz(restricao(diretor(_, Escolha))), append('restricao.pl'),
            write(restricao(diretor(_, Escolha))), write('.\n'),
            told;
        Opcao = 5,
            write('Estudios disponiveis:'), nl, findall(X, estudio(X), L), write(L), nl, nl,
            write('Escolha: '), le_atomo(Escolha),
            assertz(restricao(estudio(Escolha))), append('restricao.pl'),
            write(restricao(estudio(Escolha))), write('.\n'),
            told,
            fail
    ).

% Remover restricao
remove_restricao :-
    bagof(X, restricao(X), L),
    write('Qual restricao ira tirar?'), nl,
    write('Restricoes até o momento:'), nl,
    write(L), nl, nl,
    write('Opções:'), nl,
    write('1 - Genero'), nl,
    write('2 - Ator'), nl,
    write('3 - Tags'), nl,
    write('4 - Diretor'), nl,
    write('5 - Estudio'), nl,
    write('6 - Todas as restricoes'), nl,
	write('Opcao: '), le_atomo(Opcao),
    (
        % bagof aqui pois se tivesse apos o corte e nao tiver essa restricao vai pular
        Opcao = 1, bagof(X, restricao(genero(X)), L),
            write('Generos disponiveis:'), nl, write(L), nl, nl,
            write('Escolha: '), le_atomo(Escolha), retract(restricao(genero(Escolha))),
            tell('restricao.pl'),
            listing(restricao/1),
            told;
        Opcao = 2, bagof(X, restricao(ator(_, X)), L), !,
            write('Atores disponiveis:'), nl, write(L), nl, nl,
            write('Escolha: '), le_atomo(Escolha), retract(restricao(ator(_, Escolha))),
            tell('restricao.pl'),
            listing(restricao/1),
            told;
        Opcao = 3, bagof(X, restricao(tag(X)), L), !,
            write('Tags disponiveis:'), nl, write(L), nl, nl,
            write('Escolha: '), le_atomo(Escolha), retract(restricao(tag(Escolha))),
            tell('restricao.pl'),
            listing(restricao/1),
            told;
        Opcao = 4, bagof(X, restricao(diretor(_, X)), L), !,
            write('Diretores disponiveis:'), nl, write(L), nl, nl,
            write('Escolha: '), le_atomo(Escolha), retract(restricao(diretor(_, Escolha))),
            tell('restricao.pl'),
            listing(restricao/1),
            told;
        Opcao = 5, bagof(X, restricao(estudio(X)), L), !,
            write('Estudios disponiveis:'), nl, write(L), nl, nl,
            write('Escolha: '), le_atomo(Escolha), retract(restricao(estudio(Escolha))),
            tell('restricao.pl'),
            listing(restricao/1),
            told,
            fail;
            write('Nao ha restricao desse tipo'), nl, !
    );
    write('Nao ha restricoes'), nl, !.

% Lista filmes conforme restricoes
lista_filmes :-
    findall(X, restricao(X), L), write(L), nl, nl.

