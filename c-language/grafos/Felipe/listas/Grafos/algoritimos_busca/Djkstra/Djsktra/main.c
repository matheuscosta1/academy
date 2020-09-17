#include <stdio.h>
#include <stdlib.h>
#include "Grafo_Matriz.h"
#define separador "\n========================\n"
int main()
{
    Grafo* g;

    g=Cria_grafo(6);
    Insere_Aresta(g,0,2,2);
    Insere_Aresta(g,0,3,5);
    Insere_Aresta(g,1,5,2);
    Insere_Aresta(g,1,0,4);
    Insere_Aresta(g,2,3,1);
    Insere_Aresta(g,3,5,2);
    Insere_Aresta(g,4,1,1);
    Insere_Aresta(g,5,4,3);


    int* Distancia;
    int* ancestrais;

    Djsktra(g,0,&ancestrais,&Distancia);
    mostra_caminho(g,4,ancestrais,Distancia);
    free(ancestrais);
    free(Distancia);
    return 0 ;


}
