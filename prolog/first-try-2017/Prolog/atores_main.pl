
inicio:-
	consult("atores.pl"),
	menu.
menu:-
	write("1.Listar Atores\n2.Adiconar Ator\n3.Remover Ator\n4.Pesquisar Ator\n5.Pesquisar atores de filme\n"),
	write("6.Quantidade de aparições de um ator\n7.Excluir todas aparições de um ator\n8.Excluir filme\n9.Sair"),nl,
	write("Digite a opção desejada: "),nl,
	read(X),
	handleOption(X).

handleOption(9).

handleOption(8):-
	write("Digite o nome do filme que deseja excluir"), nl,
	read(X),
	retractall(ator(_,X,_,_)),
	tell('atores.pl'),
	listing(ator/4),
	told, 
	write("Todos os atores do filme foram removidos"),nl,nl,
	menu.

handleOption(7):-
	write("Digite o nome do ator que deseja excluir todas aparições"),nl,
	read(X),
	findall(X ,ator(X, _, _, _), Lista),
	length(Lista, Quan),
	write("Remover todas as "), write(Quan),
	write(" aparições do ator?"),nl,
	read(Op),
	yes(Op),
	retractall(ator(X, _, _, _)),
	tell('atores.pl'),
	listing(ator/4),
	told,
	write("Todos registros foram removidos"),nl,nl,
	menu;
	write("Remoção cancelada"),
	menu.
	
handleOption(6):-
	write("Digite o nome do ator"), nl,
	read(X),
	findall(X, ator(X, _, _, _), Lista),
	length(Lista, Vezes),
	write("O ator apareceu "), write(Vezes),
	write(" vezes"),nl,nl,
	menu.

handleOption(5):-
	write("Digite o nome do filme"), nl,
	read(X),
	findall(Y, ator(Y, X, _, _), Lista),
	write("Atores:"),write(Lista),
	nl,nl, menu.


handleOption(4):-
	write("Digite o nome do ator"), nl,
	read(X),
	findall(Y, ator(X, Y, _, _), Lista),
	write("Aparições:"), write(Lista), nl,
	nl, menu.
	
handleOption(3):-
	write("Digite o nome do ator que deseja remover"),nl,
	read(Ator),
	write("Digite o nome do filme do qual deseja removê-lo"), nl,
	read(Filme),
	retract(ator(Ator, Filme, _, _)),
	tell('atores.pl'),
	listing(ator/4),
	told,
	menu.


handleOption(2):-
	write("Digite o nome do ator"),nl,
	read(Nome),
	write("Digite o nome do filme"), nl,
	read(Filme),
	write("Digite o ano de lançamento"), nl,
	read(Ano),
	write("Digite o rank do filme"), nl,
	read(Rank),
	assertz(ator(Nome, Filme, Ano, Rank)),
	tell('atores.pl'),
	listing(ator/4),
	told, 
	menu.
	
handleOption(1):-
	findall([X, Y, Z], ator(X, Y, Z, _), Atores),
	showFilmes(Atores),
	menu.
	
showFilmes([]).
showFilmes([[X,Y,Z] | R]):-
	write("Nome: "),
	write(X),tab(5),
	write("Filme: "),
	write(Y),tab(5),
	write("Ano:"),
	write(Z), nl,
	showFilmes(R).
yes(sim).
