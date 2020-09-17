#ifndef ARVORE_H_INCLUDED
#define ARVORE_H_INCLUDED
#include <stdio.h>
#include <stdlib.h>

typedef struct no *Arv;
Arv cria_vazia();
int arvore_vazia(Arv A);
void libera_arvore (Arv *A);
int busca(Arv A, int elem);
void exibe_arvore (Arv A);
Arv cria_arvore(int elem, Arv esq, Arv dir);
int altura (Arv A);
int remove_folha(Arv *A, int elem);
#endif // ARVORE_H_INCLUDED
