#include <stdio.h>
#include <stdlib.h>
#include "grafoNdire.h"

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
    printf("----------------- Construcao do Grafo -----------------\n");

    mostra_grafo(g);
    alg_disparo_profundidadeN(g, 1);
    //libera_grafo(&g);


}
