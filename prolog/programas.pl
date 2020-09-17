:- use_module(library(pce)).
:- use_module(library(lists)).

joga(marcelo, futebol).
joga(marcelo, volei).

joga2ou_mais(X) :-
              joga(X,E1),
              joga(X,E2),
              E1 \= E2.

comprimento([], 0).
comprimento([H|T], X) :- comprimento(T, X1), X is X1+1.

uniao([], List, List).
uniao([List|T1], T2, [List|T3]) :- uniao(T1, T2, T3).

member(H, [H|_]).
member(H, [_|T]) :- member(H,T).

turma(aed1, [discente(peter, 60.0), discente(brad, 80.0), discente(victoria, 90.0), discente(nicole, 95)]).
turma(p1, [discente(jack, 80.0), discente(wilson, 80.0), discente(selena, 90.0), discente(britney, 90)]).

media_quantidade_itens([], 0).
media_quantidade_itens([discente(_, Notas)|T], Soma):-
    60 =< Notas,
    media_quantidade_itens(T, SomaAux),
    Soma is SomaAux+1.

quantidade_itens_real_media(Pessoa, SomaItens):-
    turma(Pessoa, L),
    media_quantidade_itens(L, SomaItens).

media_turma_cauda(Nome, Media):-
    turma(Nome, L),
    media(L,0,0,Media).

media([], Soma, Tam, Media):-
    Media is Soma/Tam.

media([discente(_, Nota)|T], Soma, Tam, Media):-
    SomaParcial is Soma+Nota,
    TamParcial is Tam+1,
    media(T, SomaParcial, TamParcial, Media).

tamanho([], 0).
tamanho([_|T], Tam) :-
    tamanho(T, TamanhoAux),
    Tam is TamanhoAux+1.

soma_com_cauda([], 0).
soma_com_cauda([discente(_|Nota)|T], Soma):-
    soma_com_cauda(T, SomaAux),
    Soma is SomaAux+Nota.

somatorio(0,[]).
somatorio(X,[Y|R]):-
    somatorio(S,R),
    X is S+Y.

media_turma_aux([], 0).
media_turma_aux(L, Media) :-
    soma_com_cauda(L, Soma),
    tamanho(L, Tam),
    Media is Soma/Tam.

media_turma_sem_cauda(Nome, Media):-
    turma(Nome, L),
    media_turma_aux(L, Media).

verifica_intersecao(X,[],[]).
verifica_intersecao(X,[X|_],[X]).
verifica_intersecao(X,[H|T],I):-
    X \= H,
    verifica_intersecao(X,T,I).

intersecao_aux([],_,Aux,Aux).
intersecao_aux([H|T], L2, Aux, Res):-
    verifica_intersecao(H, L2, I),
    append(I, Aux, IRes),
    intersecao_aux(T, L2, IRes, Res).

intersecao(L1, L2, Res):-
    intersecao_aux(L1, L2, [], Res).

adiciona(X,L,[X|L]).

deleta(H, [H|T], T).
deleta(H, [Head1|Tail1], [Head1|Tail2]):-
    deleta(H, Tail1, Tail2).

namorado(joao, tereza).
namorado(fabio, maria).

namorada(tereza, joao).
namorada(maria, fabio).

amava(X,Y) :-
    namorado(X, Y).

amava(X,Y):-
    namorada(X,Y).

morreu_de_aids(X) :-
    amava(X,Y),
    amava(Y,X).

pedido(marcelo, [item('pao', 5, 1.20), item('queijo', 0.5, 30.0), item('leite', 2, 4.00)]).
pedido(vavazin, [item('pao', 5, 2.20), item('queijo', 0.5, 35.0), item('leite', 2, 6.00)]).

quantidade_itens([], 0).
quantidade_itens([item(_, QuantidadeItens, Valor)|T], Soma):-
    quantidade_itens(T, SomaAux),
    Soma is (QuantidadeItens*Valor)+SomaAux.

quantidade_itens_real(Pessoa, SomaItens):-
    pedido(Pessoa, L),
    quantidade_itens_sem_cauda(L, 0, SomaItens).

quantidade_itens_sem_cauda([], SomaReal, SomaReal).
quantidade_itens_sem_cauda([item(_, QuantidadeItens, Valor)|T], SomaAcumulada, SomaReal):-
    SomaAux is (QuantidadeItens*Valor)+SomaAcumulada,
    quantidade_itens_sem_cauda(T, SomaAux, SomaReal).


filme(acao, jurassic_park).
filme(acao, avengers).
filme(infantil, malvado_favorito).
filme(infantil, moana).
filme(infantil, pedro_coelho).

p(1). 
p(2) :- !.
p(3). 

child(martha, charlotte).
child(charlotte, caroline).
child(caroline, laura).
child(laura, rose).

descend(X,Y) :- child(X,Y).
descend(X,Y) :- child(X,Z), descend(Z,Y).

q(blob,blug). 
q(blob,blag). 
q(blob,blig). 
q(blaf,blag). 
q(dang,dong). 
q(dang,blug). 
q(flab,blob).

mostraJanela :- new(Janela, frame('Texto da Janela')), send(Janela, open).
mostraJanelaTexto :-
    new(Janela, frame('Minha Janela')),
    new(Caixa, dialog),
    new(Texto, text('bla bla bla')),
    send(Caixa, append, Texto),
    send(Janela, append, Caixa),
    send(Janela, open).

mostraJanelaBotao :- 
    new(Janela, frame('Minha janela com botao')),
    new(Caixa, dialog),
    new(Texto, text('jsajsaijsa')),
    send(Caixa, append, Texto),
    send(Caixa, append, button(fechar, message(Janela, destroy))),
    send(Janela, append, Caixa),
    send(Janela, open).

mostraJanelaCaixaTexto(Janela, Caixa, Texto, Nome):-
    new(Janela, frame('Janela com campo de texto')),
    new(Caixa, dialog),
    new(Texto, text('Exemplo de GUI')),
    send(Caixa, append, Texto),
    send(Caixa, append, button(fechar, message(Janela, destroy))),
    send(Caixa, append, new(Nome, text_item('Digite o seu nome'))),
    send(Janela, append, Caixa),
    send(Janela, open).

recebeCampoTexto(NomeDigitado):-
    new(Caixa, dialog('Meu dialogo')),
    send(Caixa, append, new(Nome, text_item('Digite seu nome'))),
    send(Caixa, append, button(enviar, message(Caixa, return, Nome?selection))),
    get(Caixa, confirm, NomeDigitado),
    free(Caixa).

mostraOpcoes(Opcao):-
    new(Caixa, dialog('texto do menu')),
    send(Caixa, append, new(Menu, menu('opcoes'))),
    send(Menu, append, 1),
    send(Menu, append, 2),
    send(Menu, append, 3),
    send(Caixa, append, button(escolher, message(Caixa, return, Menu?selection))),
    get(Caixa, confirm, Opcao),
    free(Caixa).

main:-
    open('houses.txt', read, S),
    read(S,H1),
    read(S,H2),
    read(S,H3),
    read(S,H4),
    close(S),
    write([H1,H2,H3,H4]), nl.

main2:-
    open('houses.txt', read, S),
    readHouses(S, Houses),
    close(S),
    write(Houses), nl.

readHouses(S,[]):-
    at_end_of_stream(S).

readHouses(S,[X|L]):-
    \+ at_end_of_stream(S),
    read(S,X),
    readHouses(S,L).

main3:-
    open('houses.txt', read, S),
    readHouses_greencuts(S, Houses),
    close(S),
    write(Houses), nl.

readHouses_greencuts(S,[]):-
    at_end_of_stream(S),!.

readHreadHouses_greencutsouses(S,[X|L]):-
    \+ at_end_of_stream(S),!,
    read(S,X),
    readHouses_greencuts(S,L).

split([],[],[]).
split([X|L],[X|L1],L2):-
    X>= 0,
    split(L,L1,L2).
split([X|L],L1,[X|L2]):-
    split(L,L1,L2).


split_corte([],[],[]).
split_corte([X|L],[X|L1],L2):-
    X>= 0,
    !,
    split_corte(L,L1,L2).
split_corte([X|L],L1,[X|L2]):-
    split_corte(L,L1,L2).

fat(N, F):-
    fat_aux(N, 1, F),
    append('cache.pl'),
    write(fatorial(N, F)), write('.'), write('\n'),
    told.

fat_aux(0, F, F).
fat_aux(N, Fat_acumulado, Fat):-
    Novo_fat_acumulado is Fat_acumulado * N,
    N1 is N-1,
    fat_aux(N1, Novo_fat_acumulado, Fat).

fat_list :-
    consult('cache.pl'),
    setof(X, fatorial(_, X), L),
    write(L).

read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    read_file(Stream,L).

recebe_arquivo(ArquivoDigitado):-
    new(Caixa, dialog("Digite o nome do arquivo")),
    send(Caixa, append, new(Arquivo, text_item("Arquivo"))),
    send(Caixa, append, button(send, message(Caixa, return, Arquivo?selection))),
    get(Caixa, confirm, ArquivoDigitado),
    open(ArquivoDigitado, read, S),
    read_file(S, Lines),
    delete(Lines, 'end_of_file', Result),
    sum_list(Result, Result1),
    write(Result1), nl.

