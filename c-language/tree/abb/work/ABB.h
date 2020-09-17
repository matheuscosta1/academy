#ifndef ABB_H_INCLUDED
#define ABB_H_INCLUDED
#include "Registro.h"
typedef struct No* Arv;

Arv Cria_arvore();
int Arvore_Vazia(Arv a);
int insere_ord(Arv* a,Registro g);
Arv remove_ord(Arv* a,int chave);
Arv busca_bin (Arv a,int chave);
void exibe_arvore(Arv a);
void exibe_ord(Arv a);
void libera_arvore(Arv* a);
Registro Maior(Arv a);
int de_maior(Arv a);
int qtde_alunos(Arv a,int ini,int fim);
int um_filho(Arv a);
int completa(Arv a);
int altura_arv(Arv a);
Arv juntar(Arv a1,Arv a2);
int folhas(Arv a);
int intermediarios(Arv a);


#endif // ABB_H_INCLUDED
