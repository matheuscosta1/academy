showMenu:-write("1- Listar  atores"), nl,
	write("2- Adicionar ator"), nl,
	write("3- Remover ator"), nl,
	write("4- Sair"), nl,
	write("Digite sua opcao"), nl,
	leAtomo(Opcao),
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
	leAtomo(Nome),
	write("Digite o nome do filme: "), nl,
	leAtomo(Filme),
	write("Ano: "), nl,
	leAtomo(Ano),
	write("Rank: "), nl,
	leAtomo(Rank),
	tell("atores.pl"),
	write("("),
	write(Nome), 
	write(","), 
	write(Filme), 
	write(","), 
	write(Ano), 
	write(","), 
	write(Rank), 
	write(")."),
	%assertz(ator(Nome, Filme, Ano, Rank)),
	told,
	showMenu.

execOp(3):-
	write("Deletar ator:"), nl,
	leAtomo(Nome),
	write("Qual o filme?"), nl,
	leAtomo(Filme),
	retract(ator(Nome, Filme, _, _)),
	showMenu.

execOp(4).

execOp(_):- write("Opção invalida!"), nl, showMenu.

contarAtor(X, N):-ator(X,_,_,_), N is 1.
chamarAtor(X):- ator(X, _, _, _).

leAtomo(Atomo) :-
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
