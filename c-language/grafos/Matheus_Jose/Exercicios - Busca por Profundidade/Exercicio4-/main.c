#include <stdio.h>
#include <stdlib.h>
#include "buscaProfun.h"
#include "stack.h"
int main()
{
    Grafo *g = cria_grafo(9);
    printf("-------------- Construcao do Grafo --------------\n\n");
    insere_aresta(g,1, 2, 3); //printf("\n");
    insere_aresta(g,1, 3, 3); //printf("\n");
    insere_aresta(g,4, 2, 3); //printf("\n");
    insere_aresta(g,5, 2, 4); //printf("\n");
    insere_aresta(g,3, 4, 4); //printf("\n");
    insere_aresta(g,5, 4, 4); //printf("\n");
    insere_aresta(g,6, 4, 4); //printf("\n");
    insere_aresta(g,6, 7, 4); //printf("\n");

    printf("Grafo nao conexo sem a inicializacao do vertice 8:\n\n");
    alg_disparo_profundidade(g, 1);

}


