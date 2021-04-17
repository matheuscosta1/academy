
%No início, estão todos na mesma margem do rio
%barco, canibal I, canibal II, canibal III, missionario I, missionario II, missionario III
inicio([n,n,n,n,n,n,n]).
%A meta é que todos estejam na outra margem
meta([s,s,s,s,s,s,s]).

resolve(P):-
	inicio(Inicio),
	busca(Inicio, [Inicio], Saida),
	reverse(P, Saida).

busca(S, P, P):-meta(S), !.
busca(S, Traco, Resposta):-
	proximo_estado(S, Prox),
	not(proibido(Prox)),
	\+member(Prox, Traco),
	busca(Prox, [Prox|Traco], Resposta).

%O barco pode ter um ou dois tripulantes

%Cobrindo os casos em que  dois tripulantes viajam
%Casos em que sempre o primeiro canibal viaja 
proximo_estado([X, C1, C1, C3, M1, M2, M3], [X1, N, N, C3, M1, M2, M3]):- troca(C1, N).
proximo_estado([X, C1, C2, C1, M1, M2, M3], [X1, N, C2, N, M1, M2, M3]):- troca(C1, N).
proximo_estado([X, C1, C2, C3, C1, M2, M3], [X1, N, C2, C3, N, M2, M3]):- troca(C1, N).
proximo_estado([X, C1, C2, C3, M1, C1, M3], [X1, N, C2, C3, M1, N, M3]):- troca(C1, N).
proximo_estado([X, C1, C2, C3, M1, M2, C1], [X1, N, C2, C3, M1, M2, N]):- troca(C1, N).

%Casos em que sempre o segundo canibal viaja
proximo_estado([X, C1, C2, C2, M1, M2, M3], [X1, C1, N, N, M1, M2, M3]):- troca(C2, N).
proximo_estado([X, C1, C2, C3, C2, M2, M3], [X1, C1, N, C3, N, M2, M3]):- troca(C2, N).
proximo_estado([X, C1, C2, C3, M1, C2, M3], [X1, C1, N, C3, M1, N, M3]):- troca(C2, N).
proximo_estado([X, C1, C2, C3, M1, M2, C2], [X1, C1, N, C3, M1, M2, N]):- troca(C2, N).

%Casos em que sempre o terceiro canibal viaja
proximo_estado([X, C1, C2, C3, C3, M2, M3], [X1, C1, C2, N, N, M2, M3]):- troca(C3, N).
proximo_estado([X, C1, C2, C3, M1, C3, M3], [X1, C1, C2, N, M1, N, M3]):- troca(C3, N).
proximo_estado([X, C1, C2, C3, M1, M2, C3], [X1, C1, C2, N, M1, M2, N]):- troca(C3, N).

%Casos em que sempre o primeiro  missionario viaja
proximo_estado([X, C1, C2, C3, M1, M1, M3], [X1, C1, C2, C3, N, N, M3]):- troca(M1, N).
proximo_estado([X, C1, C2, C3, M1, M2, M1], [X1, C1, C2, C3, N, M2, N]):- troca(M1, N).

%Casos em que sempre o segundo missionário viaja
proximo_estado([X1, C1, C2, C3, M1, M2, M2], [X1, C1, C2, C3, M1, N, N]):- troca(M2, N).

%Note que todos os casos em que o terceiro missionário sempre viaja já foram cobertos nos demais casos


%Cobrindo os casos em que apenas um tripulante viaja
proximo_estado([X, C1, C2, C3, M1, M2, M3], [X1, N, C2, C3, M1, M2, M3]):- troca(C1, N).
proximo_estado([X, C1, C2, C3, M1, M2, M3], [X1, C1, N, C3, M1, M2, M3]):- troca(C2, N).
proximo_estado([X, C1, C2, C3, M1, M2, M3], [X1, C1, C2, N, M1, M2, M3]):- troca(C3, N).
proximo_estado([X, C1, C2, C3, M1, M2, M3], [X1, C1, C2, C3, N, M2, M3]):- troca(M1, N).
proximo_estado([X, C1, C2, C3, M1, M2, M3], [X1, C1, C2, C3, M1, N, M3]):- troca(M2, N).
proximo_estado([X, C1, C2, C3, M1, M2, M3], [X1, C1, C2, C3, M1, M2, N]):- troca(M3, N).


proibido([X,X,X,X,Y,Y]):- X \= Y.
proibido([X,X,X,X,X,Y]):- X \= Y.

printarSolucao([], _).
printarSolucao([X|Y], Controle):-
		idaOuVolta(Controle),
		mostrarPasso(X),
		Controle1 is Controle+1 ,
		printarSolucao(Y, Controle1).

mostrarPasso([C1, C2, C3, M1, M2, M3]):-
		ondeC(C1, "#1"),
		ondeC(C2, "#2"),
		ondeC(C3, "#3"),
		ondeM(M1, "#1"),
		ondeM(M2, "#2"),
		ondeM(M3, "#3"), nl.			


idaOuVolta(0):- write("::Inicio::"), nl, !.
idaOuVolta(X):- X mod 2 =:= 0, write(":::Volta:::"), nl,!.
idaOuVolta(X):-write(":::Ida:::"), nl.

ondeM(n, X):- write("Missionário "), write(X), write(" no norte"), nl, !.
ondeM(s, X):- write("Missionário "), write(X), write(" no sul"), nl.
ondeC(n, X):- write("Canibal "), write(X), write(" no norte"), nl, !.
ondeC(s, X):- write("Canibal "), write(X), write(" no sul"), nl.

troca(n, s).
troca(s, n).
