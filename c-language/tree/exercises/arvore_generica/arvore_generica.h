#ifndef ARVORE_GENERICA_H_INCLUDED
#define ARVORE_GENERICA_H_INCLUDED
#include <stdio.h>
#include <stdlib.h>
#include "fila.h"

typedef struct no *Arv;
Arv cria_arvore(int elem);
int insere (Arv A, Arv sa);
void exibe_arvore (Arv A);
int busca (Arv A, int elem);
void libera_arvore (Arv *A);
void pre_ordem (Arv A);
void pos_ordem (Arv A);
void largura (Arv A);
int no_folha(Arv A);
int qtd_fol(Arv A);
int altura_arvore(Arv A);
int altura_no(Arv A, int elem);
int pertence(Arv A, int elem);
int grau_arvore (Arv A);
int quantidade_nos(Arv A, int grau);
#endif // ARVORE_GENERICA_H_INCLUDED
