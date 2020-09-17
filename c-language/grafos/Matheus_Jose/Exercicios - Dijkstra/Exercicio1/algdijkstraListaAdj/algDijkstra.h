#ifndef BUSCALARGURA_H_INCLUDED
#define BUSCALARGURA_H_INCLUDED
#include "fila.h",
typedef int bool;
typedef struct grafo Grafo;
typedef struct vertice Vertice;


Grafo *cria_grafo (int numero_vertices);
int insere_aresta(Grafo *G, int vertice1, int vertice2, int peso);
void mostra_adjacentes(Grafo *G, int vertice);
int verifica_aresta(Grafo *G, int vertice1, int vertice2);
int consulta_aresta(Grafo *G, int vertice1, int vertice2, int *peso);
int libera_grafo(Grafo **G);
int remover_aresta(Grafo *G, int vertice1, int vertice2);
void inicializa_dijkstra (Grafo *G, int *d, int *p, int s);
void relaxa_dijkstra (Grafo *G, int *d, int *p, int u, int v);
int *disjkstra(Grafo *G, int s);
int existeAberto(Grafo *G, int *aberto);
int menorDist(Grafo *G, int *aberto, int *d);

#endif // BUSCALARGURA_H_INCLUDED
