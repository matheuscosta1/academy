#ifndef GRAFONDIRE_H_INCLUDED
#define GRAFONDIRE_H_INCLUDED

typedef struct grafo Grafo;

Grafo *cria_grafo (int numero_vertices);
int insere_aresta (Grafo *G, int vertice1, int vertice2, int peso);
int verifica_aresta (Grafo *G, int vertice1, int vertice2);
int remove_aresta (Grafo *G, int vertice1, int vertice2);
int consulta_aresta (Grafo *G, int vertice1, int vertice2, int *peso);
void libera_grafo(Grafo **G);
int mostra_adjacentes (Grafo *G, int vertice);
int mostra_grafo(Grafo *G);

#endif // GRAFONDIRE_H_INCLUDED
