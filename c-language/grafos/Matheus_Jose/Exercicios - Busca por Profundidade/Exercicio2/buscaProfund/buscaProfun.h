#ifndef BUSCAPROFUN_H_INCLUDED
#define BUSCAPROFUN_H_INCLUDED

typedef struct grafo Grafo;
typedef struct vertice Vertice;

int insere_aresta(Grafo *G, int vertice1, int vertice2, int peso);
Grafo *cria_grafo (int numero_vertices);
void mostra_adjacentes(Grafo *G, int vertice);
int verifica_aresta(Grafo *G, int vertice1, int vertice2);
int remove_aresta(Grafo *G, int vertice1, int vertice2);
int consulta_aresta(Grafo *G, int vertice1, int vertice2, int *peso);
void libera_grafo(Grafo **G);
void visitaProfundidade(Grafo *G, int vertice1, int *cor);
int remove_elemento(Grafo *G, int vertice1);
int remover_aresta(Grafo *G, int vertice1, int vertice2);
void visitaProfundidadeN(Grafo *G, int i, int *cor);
void alg_disparo_profundidadeN(Grafo *G, int j);
//void busca_profundidade(Grafo *G, int i, int *cor);
void alg_disparo_profundidade(Grafo *G, int j);
void busca_profundidade(Grafo *G, int i, int *cor);
int find(Grafo *G, int u, int v);
void alg_disparo_profundidadeN(Grafo *G, int j);
void busca_profundidadeN(Grafo *G, int i, int *cor);
#endif // BUSCAPROFUN_H_INCLUDED
