#include <stdio.h>
#include <stdlib.h>
#include "exerc_3.h"

int main()
{
    Grafo *g = cria_grafo(9);
    printf("-------------- Construcao do Grafo --------------\n\n");
    insere_aresta(g,0, 2, 2); //printf("\n");
    insere_aresta(g,1, 3, 3); //printf("\n");
    insere_aresta(g,2, 6, 3); //printf("\n");
    insere_aresta(g,2, 5, 3); //printf("\n");
    insere_aresta(g,3, 4, 4); //printf("\n");
    insere_aresta(g,4, 5, 4); //printf("\n");
    insere_aresta(g,4, 6, 4); //printf("\n");
    insere_aresta(g,6, 7, 4); //printf("\n");
    insere_aresta(g,6, 8, 4); //printf("\n");
    insere_aresta(g,8,2,3);
    imprime(g);
    verifica_aresta(g,6,5);
    remover_aresta(g,6,8);
    imprime(g);
    verifica_aresta(g,6,8);
    verifica_aresta(g,6,4);
    libera_grafo(&g);

}
