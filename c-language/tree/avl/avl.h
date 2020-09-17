#ifndef AVL_H
#define AVL_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct ponto_de_rede PontoDeRede;
typedef struct no * Arvore;
typedef struct no No;



Arvore criar_arvore();
int arvore_vazia(Arvore arv);
int insere_ordenado(Arvore * arv, int * bal, char * nome, char * loc, double cap, double traf);
Arvore busca_binaria(Arvore arv, double trafego);
void exibir_arvore(Arvore arv);
void exibir_ordenado(Arvore arv);
int balancear_esquerda(Arvore * arv);
int balancear_direita(Arvore * arv);
int rotacionar_direita(Arvore * arv);
int rotacionar_esquerda(Arvore * arv);
int rotacionar_dir_esq(Arvore * arv);
int rotacionar_esq_dir(Arvore * arv);
int numero_derivacoes(Arvore arv);
void liberar_arvore(Arvore * arv);
void exibir_pdr(PontoDeRede * pdr);
void escrever_arquivo(Arvore arv, FILE * f);
int ler_arquivo(Arvore * arv, FILE *f);
int arvores_iguais(Arvore arv1, Arvore arv2);
PontoDeRede * pdr_menor_trafego(Arvore arv);
int pontos_ociosos(Arvore arv);
int arvore_cheia(Arvore arv);
int buscar_nivel(Arvore arv, char * nome);
#endif