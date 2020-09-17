#include <stdio.h>
#include <stdlib.h>
#include "Grafo_Matriz.h"
#define separador "\n========================\n"
int main()
{
    Grafo* g;

    g=Cria_grafo(5);
    Insere_Aresta(g,0,1,1);
    Insere_Aresta(g,1,0,1);
    Insere_Aresta(g,0,3,1);
    Insere_Aresta(g,3,4,1);
    Insere_Aresta(g,4,4,1);
    Insere_Aresta(g,4,2,1);
    Insere_Aresta(g,2,3,1);

    Busca_profundidade(g,0);


}
