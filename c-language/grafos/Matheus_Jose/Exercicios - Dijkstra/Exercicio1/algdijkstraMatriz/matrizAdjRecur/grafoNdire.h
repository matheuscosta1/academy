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
void busca_largura(Grafo *G, int vertice);
void inicializa_dijkstra (Grafo *G, int *d, int *p, int s);
void relaxa_dijkstra (Grafo *G, int *d, int *p, int u, int v);
int *disjkstra(Grafo *G, int s);
void roda_dijkstra(Grafo *G, int vertice);
int existe_aberto(Grafo *G, int *aberto);
int menorDist(Grafo *G, int *aberto, int *d);
#endif // GRAFONDIRE_H_INCLUDED
