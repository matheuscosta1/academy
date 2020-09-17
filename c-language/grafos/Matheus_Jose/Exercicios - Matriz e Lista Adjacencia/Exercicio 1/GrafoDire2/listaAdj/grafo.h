#ifndef GRAFO_H_INCLUDED
#define GRAFO_H_INCLUDED

typedef struct grafo Grafo;

int insere_aresta(Grafo *G, int vertice1, int vertice2, int peso);
Grafo *cria_grafo (int numero_vertices);
void mostra_adjacentes(Grafo *G, int vertice);
int verifica_aresta(Grafo *G, int vertice1, int vertice2);
int remove_aresta(Grafo *G, int vertice1, int vertice2);
int consulta_aresta(Grafo *G, int vertice1, int vertice2, int *peso);
libera_grafo(Grafo **G);
mostra_grafo(Grafo *G);
#endif // GRAFO_H_INCLUDED
