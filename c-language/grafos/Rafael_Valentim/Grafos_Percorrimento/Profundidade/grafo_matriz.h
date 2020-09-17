#ifndef GRAFO_H
#define GRAFO_H

#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include "pilha.h"
typedef struct grafo_ Grafo;


Grafo * criar_grafo(int vertices, int is_digrafo);
int inserir_aresta(Grafo *, int origem, int destino, int peso);
int verificar_aresta(Grafo *, int origem, int destino);
int consultar_aresta(Grafo*, int origem, int destino, int * peso);
int remover_aresta(Grafo *, int origem, int destino);
void mostrar_adjacentes(Grafo *, int vertice);
void dfs(Grafo *, int);
void dfs_nao_conexo(Grafo *g);
int busca_profundidade(Grafo *, int, int*, int);
int busca_profundidade_iterativa(Grafo *g, int);
void mostrar_grafo(Grafo *);
void liberar_grafo(Grafo **);
#endif