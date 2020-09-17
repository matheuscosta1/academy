#include <stdio.h>
#include <stdlib.h>
#include "buscaLargura.h"
#include "fila.h"
int main()
{
    Grafo *g = cria_grafo(9);
    printf("-------------- Construcao do Grafo --------------\n\n");
    insere_aresta(g,1, 3, 2); //printf("\n");
    insere_aresta(g,1, 2, 3); //printf("\n");
    insere_aresta(g,2, 4, 3); //printf("\n");
    insere_aresta(g,3, 4, 3); //printf("\n");
    insere_aresta(g,2, 5, 3); //printf("\n");
    insere_aresta(g,5, 4, 3); //printf("\n");
    insere_aresta(g,4, 6, 3); //printf("\n");
    insere_aresta(g,6, 7, 3); //printf("\n");
    insere_aresta(g,6, 8, 3); //printf("\n");
    insere_aresta(g,7, 8, 3); //printf("\n");
    imprime(g);

    busca_largura(g, 1);

}


