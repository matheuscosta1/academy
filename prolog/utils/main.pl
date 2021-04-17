showMenu:-write("1- Listar  atores"), nl,
	write("2- Adicionar ator"), nl,
	write("3- Remover ator"), nl,
	write("4- Sair"), nl,
	write("Digite sua opcao"), nl,
	read(Opcao),
	execOp(Opcao).

main:-
	consult("atores.pl"),
	showMenu.

execOp(1):-
	listing(ator/4),
	nl,
	showMenu.

execOp(2):-
	write("Digite o nome do ator: "), nl,
	read(Nome),
	write("Digite o nome do filme: "), nl,
	read(Filme),
	write("Ano: "), nl,
	read(Ano),
	write("Rank: "), nl,
	read(Rank),
	assertz(ator(Nome, Filme, Ano, Rank)),
	showMenu.

execOp(3):-
	write("Deletar ator:"), nl,
	read(Nome),
	retract(ator(Nome, _, _, _)),
	showMenu.

execOp(4):-abort.

contarAtor(X, N):-ator(X,_,_,_), N is 1.
chamarAtor(X):- ator(X, _, _, _).
