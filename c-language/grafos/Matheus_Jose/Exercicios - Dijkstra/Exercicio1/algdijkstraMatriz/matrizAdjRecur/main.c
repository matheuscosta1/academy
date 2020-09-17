#include <stdio.h>
#include <stdlib.h>
#include "grafoNdire.h"
#include "fila.h"
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

    printf("----------------- Construcao do Grafo -----------------\n");

    mostra_grafo(g);
    printf("\n");
    printf("\n\n-------------------------------------------------------\n");
    printf("Busca em largura utilizando Matriz de Adjacencia\n");
    printf("-------------------------------------------------------\n");
    disjkstra(g, 1);
    printf("\n-------------------------------------------------------\n");
    //libera_grafo(&g);


}
