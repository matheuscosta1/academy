/*
 *	Trabalho de Prolog - Três Canibais e Três Missionários
 *
 * Aluno: Rafael Valentim Silva - 11711BCC010
 *
 *	Abordagem
 * Para a resolução deste problema, verifca-se que é mais viável trabalhar com  indices
 * que marcam a quantidade de cada entidade, são elas:
 *	- a quantidade de canibais do lado inicial do rio (CN);
 *	- a quantidade de missionários do lado inicial do rio (MN);
 *	- a quantidade de canibais no outro lado do  rio (CS);
 *	- a quantidade de missionários no outro lado do rio (MS).
 * 
 * Essa indicação torna mais fácil controlar a travessia do rio, pois no problema atual,
 * o barco sempre tem que estar tripulado e através de marcações específicas  para  cada
 * elemento do conjunto fica difícil ter o o controle de quem atravessou e quem deve vol
 * tar. Com o uso de indicadores, basta simplesmente balancear a quantidade de elementos
 * de cada margem de acordo com o movimento do  barco. E, desta forma foram implentadas
 * os próximos estados e os estados permitidos.
 *   Os estados permitidos foram substituídos por estados não permitidos pelo simples fato
 * de haver menos restrições do que permissões.
 *
 *
 *
 */

% No início todos os 3 canibais e missionários estão do mesmo lado
% inicio(barco, nº canibais norte, nº missionarios norte, nº canibais sul, nº missionarios sul).
inicio([n, 3, 3, 0 , 0]).
meta([s, 0, 0, 3, 3]).

resolver:-
	inicio(Inicio),
	busca(Inicio, [Inicio], PathInvertido),
	reverse(PathInvertido, Path),
    	printarSolucao(Path).

busca(Passo, Path, Path):- meta(Passo), !.
busca(Passo, Path, Solucao):-
	proximo_estado(Passo, Prox),
	not(proibido(Prox)),
	not(member(Prox, Path)),
	busca(Prox, [Prox|Path], Solucao).

% Listando as possibilidades de 2 tripulantes
% Dois canibais 
proximo_estado([n, CN, MN, CS, MS], [s, CN1, MN, CS1, MS]):- CN1 is CN -2, CS1 is CS +2.
proximo_estado([s, CN, MN, CS, MS], [n, CN1, MN, CS1, MS]):- CN1 is CN +2, CS1 is CS -2.

% Dois missionários
proximo_estado([s, CN, MN, CS, MS], [n, CN, MN1, CS, MS1]):- MN1 is MN +2, MS1 is MS -2.
proximo_estado([n, CN, MN, CS, MS], [s, CN, MN1, CS, MS1]):- MN1 is MN -2, MS1 is MS +2.

%s Um canibal e um missionário
proximo_estado([s, CN, MN, CS, MS], [n, CN1, MN1, CS1, MS1]):- CN1 is CN +1, CS1 is CS -1, MN1 is MN +1, MS1 is MS -1.
proximo_estado([n, CN, MN, CS, MS], [s, CN1, MN1, CS1, MS1]):- CN1 is CN -1, CS1 is CS +1, MN1 is MN -1, MS1 is MS +1.

% Listando as possibilidades de um unico tripulante
% Canibal  do n para s ou de s para n
proximo_estado([n, CN, MN, CS, MS], [s, CN1, MN, CS1, MS]):- CN1 is CN -1, CS1 is CS +1.
proximo_estado([s, CN, MN, CS, MS], [n, CN1, MN, CS1, MS]):- CN1 is CN +1, CS1 is CS -1.

% Missionário de n para s ou de s para n
proximo_estado([s, CN, MN, CS, MS], [n, CN, MN1, CS, MS1]):- MN1 is MN +1, MS1 is MS -1.
proximo_estado([n, CN, MN, CS, MS], [s, CN, MN1, CS, MS1]):- MN1 is MN -1, MS1 is MS +1.



/*
 * Proibido o número de canibais em uma borda ser maior que o de missionários
 * Caso não houver nenhum missionário, o estado é permitido, portanto só se
 * é proibido caso 0 < MS < CS ou 0 < MN < CN.   
 */
proibido([_, CN, MN, CS, MS]):- (CN > MN, MN > 0); (CS > MS, MS > 0).

% proibido algum numero ser maior que tres
proibido([_, CN, MN, CS, MS]):- CN + CS > 3, MN + MS > 3.

% proibido a quantidade  de canibais ou missionarios de um lado ser menor que zero
proibido([_, CN, MN, CS, MS]):- CN < 0; MN < 0; CS < 0; MS < 0.

printarSolucao([]).
printarSolucao([X|Y]):- 
    				printarPasso(X), 
    				printarSolucao(Y).

printarPasso([s , CN, MN, CS, MS]):-
		write("\nViagem do norte para o sul"),nl,
  		write("::Norte::"),nl,
   		write("Canibais: "), write(CN),nl,
    		write("Missionarios: "), write(MN),nl,
    		write("::Sul::"), nl,
    		write("Canibais: "), write(CS),nl,
    		write("Missionarios: "), write(MS), nl.
printarPasso([n , CN, MN, CS, MS]):-
		write("\nViagem do sul para o norte"),nl,
    		write("::Norte::"),nl,
    		write("Canibais: "), write(CN),nl,
    		write("Missionarios: "), write(MN),nl,
		write("::Sul::"), nl,
    		write("Canibais: "), write(CS),nl,
 		write("Missionarios: "), write(MS),nl.
