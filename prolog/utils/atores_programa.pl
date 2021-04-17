%Para enontrar atores com mesmo nome 
% consult(atores), findAll(F, ator(kevin_bacon,F,_,_), L).
% R = ..[ator, X, f1, f2, f2] ==+> R = ator(X, f1, f2, f2);

inicio:-
	consult("atores.pl"),
	menu.
menu:-
	write("1.Listar Atores\n2.Adiconar Ator\n3.Remover Ator\n4.Sair"),nl,
	write("Digite a opção desejada: "),nl,
	read(X),
	handleOption(X).

handleOption(4).
handleOption(1):-
		not(listarAtores),
		nl,
		menu.

handleOption(2):-
	write("Digite o nome do ator: "), nl,
	read(Nome),
	write("Digite o nome do filme: "), nl,
	read(Filme),
	write("Ano: "), nl,
	read(Ano),
	write("Rank: "), nl,
	read(Rank),
	tell('atores.pl'),
	listing(ator/4),
	assertz(ator(Nome, Filme, Ano, Rank)),
	told,
	/* Precisa-se reconsultar o aquivo atores.pl
	*/
	inicio.

handleOption(3):-
		write("Digite o nome do ator que deseja remover"),nl,
		read(Nome),
		write("Digite o nome do filme do qual deseja removê-lo"), nl,
		read(Filme),
		removerAtor(Nome, Filme),
		menu.
listarAtores:- 
		ator(Nome, Filme, _, _),
		write("Nome: "),
		write(Nome),
		write("\t\tFilme: "),
		write(Filme),nl,
		fail.

removerAtor(Nome, Filme):-
		retract(ator(Nome,Filme, _, _)),
		tell('atores.pl'),
		listing(ator/4),
		told.


