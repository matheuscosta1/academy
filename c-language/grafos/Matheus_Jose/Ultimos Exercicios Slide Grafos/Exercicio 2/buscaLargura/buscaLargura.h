#ifndef BUSCALARGURA_H_INCLUDED
#define BUSCALARGURA_H_INCLUDED
#include "fila.h",
typedef int bool;
typedef struct grafo Grafo;
typedef struct vertice Vertice;

int insere_aresta(Grafo *G, int vertice1, int vertice2, int peso);
Grafo *cria_grafo (int numero_vertices);
void mostra_adjacentes(Grafo *G, int vertice);
int verifica_aresta(Grafo *G, int vertice1, int vertice2);
int remove_aresta(Grafo *G, int vertice1, int vertice2);
int consulta_aresta(Grafo *G, int vertice1, int vertice2, int *peso);
int libera_grafo(Grafo **G);
int remove_elemento(Grafo *G, int vertice1);
int remover_aresta(Grafo *G, int vertice1, int vertice2);
void busca_largura(Grafo *G, int vertice);

#endif // BUSCALARGURA_H_INCLUDED
