#ifndef EXERC_3_H_INCLUDED
#define EXERC_3_H_INCLUDED

typedef struct grafo Grafo;
typedef struct vertice Vertice;

int insere_aresta(Grafo *G, int vertice1, int vertice2, int peso);
Grafo *cria_grafo (int numero_vertices);
void mostra_adjacentes(Grafo *G, int vertice);
int verifica_aresta(Grafo *G, int vertice1, int vertice2);
int remove_aresta(Grafo *G, int vertice1, int vertice2);
int consulta_aresta(Grafo *G, int vertice1, int vertice2, int *peso);
void libera_grafo(Grafo **G);
int remover_aresta(Grafo *G, int vertice1, int vertice2);


#endif // EXERC_3_H_INCLUDED
