#include <stdio.h>
#include <stdlib.h>
#include "algDijkstra.h"
#include "fila.h"

int main()
{
    Grafo *g = cria_grafo(8);
    printf("-------------- Construcao do Grafo --------------\n\n");
    insere_aresta(g,0, 1, 2); //printf("\n");
    insere_aresta(g,0, 2, 1); //printf("\n");
    insere_aresta(g,1, 3, 4); //printf("\n");
    insere_aresta(g,1, 2, 6); //printf("\n");
    insere_aresta(g,1, 4, 7); //printf("\n");
    insere_aresta(g,2, 4, 10); //printf("\n");
    insere_aresta(g,4, 3, 2); //printf("\n");
    insere_aresta(g,3, 5, 5); //printf("\n");
    imprime(g);
    int *r = disjkstra(g, 0);
    roda_dijkstra(g, 0);

    //busca_largura(g, 0);

}


