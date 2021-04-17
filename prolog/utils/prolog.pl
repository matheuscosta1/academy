list(Arquivo):-see(Arquivo), processa_arquivo, seen.
processa_arquivo:- read(Termo), processa_termo(Termo).
processa_termo(end_of_file):- !.
processa_termo(Termo):- write(Termo), write("."), nl, processa_arquivo.

copia(Arquivo, Destino):-see(Arquivo), tell(Destino), read(Frase), copia_frase(Frase), seen, told.
copia_frase(Frase):-write(Frase), write("."), nl, Frase= end_of_file, !.
copia_frase(_):-read(Frase2), copia_frase(Frase2).

obtem_SN(Result):- get(Char), get(_), digitado(Char, Result).
obtem_SN(Result):-nl, write("Sim ou Não?"), obtem_SN(Result).

digitado(83, sim).
digitado(115, sim).
digitado(78 , não).
digitado(110, não).

































