#include <stdio.h>
#include <stdlib.h>
#include "Grafo_listaadjacencias.h"
int main()
{
    Grafo* g;

    g=Cria_grafo(6);
    if(g==NULL)
    {
        printf("erro ao criar o grafo");
        return 0;
    }

    Insere_Aresta(g,0,3,5);
    Insere_Aresta(g,0,2,2);
    Insere_Aresta(g,1,5,2);
    Insere_Aresta(g,1,0,4);
    Insere_Aresta(g,2,3,1);
    Insere_Aresta(g,3,5,2);
    Insere_Aresta(g,4,1,1);
    Insere_Aresta(g,5,4,3);

    int*Distancia;
    int*Ancestrais;

    Djsktra(g,0,&Ancestrais,&Distancia);
   mostra_caminho(g,3,Ancestrais,Distancia);
    free(Ancestrais);
    free(Distancia);
    return 1;

}
