#include <stdio.h>
#include <stdlib.h>
#include "grafo.h"

int main()
{
    Grafo *g = cria_grafo(6);
    printf("-------------- Construcao do Grafo --------------\n\n");
    insere_aresta(g,0, 1, 2); //printf("\n");
    insere_aresta(g,1, -2, 3); //printf("\n");
    insere_aresta(g,1, 4, 3); //printf("\n");
    insere_aresta(g,0, 2, 4); //printf("\n");
    insere_aresta(g,0, 3, 4); //printf("\n");
    //insere_aresta(g, 0, 1, 5);
    //insere_aresta(g, 3, 2, 6);
    //mostra_adjacentes(g, 3);
    //mostra_grafo(g);
    //verifica_aresta(g,1,1); // nao existe aresta entre ambos return 0 //funcionando
    //verifica_aresta(g,1,0); // return 1 (existe) //funcionando
    //remove_aresta(g,1,0); //funcionando
    //consulta_aresta(g, 0, 0, 2); //funcionando
    //libera_grafo(&g); //funcionando; depois que eu der free, terei de criar outro grafo para caso queira novas operacoes
    //mostra_adjacentes(g, 1);
    //libera_grafo(&g);
    //verifica_aresta(g, 0, 1);
    //verifica_aresta(g, 1, 2);
    //remove_aresta(g,1, 2); printf("\n");
    //verifica_aresta(g, 1, 2); //remove_aresta funcionando
    //insere_aresta(g, 1, 2, 3); //printf("\n");
    //mostra_adjacentes(g,1);
    //remove_aresta(g,1,2);
    //mostra_adjacentes(g,1);
    //consulta_aresta(g, 0,3,4);
    //libera_grafo(&g);
    mostra_grafo(g);
    libera_grafo(&g);
}


