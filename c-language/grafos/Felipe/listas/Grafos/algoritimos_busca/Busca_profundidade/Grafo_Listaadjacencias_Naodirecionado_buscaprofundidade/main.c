#include <stdio.h>
#include <stdlib.h>
#include "Grafo_lista_Naodirecionado.h"
#define separador "\n========================\n"
int main()
{
    Grafo* g;

    g=Cria_grafo(9);
    Insere_Aresta(g,0,1,1);
    Insere_Aresta(g,0,2,1);
    Insere_Aresta(g,1,3,1);
    Insere_Aresta(g,1,4,1);
    Insere_Aresta(g,2,3,1);
    Insere_Aresta(g,3,4,1);
    Insere_Aresta(g,3,5,1);
    Insere_Aresta(g,5,6,1);
    Insere_Aresta(g,5,7,1);
    Insere_Aresta(g,6,7,1);

    Busca_profundidadeIterativa(g,0);

   Libera_Grafo(&g);



}
