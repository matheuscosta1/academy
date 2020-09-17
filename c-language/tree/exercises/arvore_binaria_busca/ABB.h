#ifndef ABB_H_INCLUDED
#define ABB_H_INCLUDED
#include "Registro.h"
typedef struct No* Arv;

Arv Cria_arvore();
int Arvore_Vazia(Arv A);
int insere_ord(Arv* A,Registro G);
Arv remove_ord(Arv* A,int chave);
Arv busca_bin (Arv A,int chave);
void exibe_arvore(Arv A);
void exibe_ord(Arv A);
void libera_arvore(Arv* A);
int altura_arv(Arv a);

#endif // ABB_H_INCLUDED
