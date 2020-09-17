#include <stdio.h>
#include <stdlib.h>
#include "Grafo_Matriz_Naodirecionado.h"
#define separador "\n========================\n"
int main()
{
    Grafo* g;

    g=Cria_grafo(6);
    Insere_Aresta(g,0,1,1);
    Insere_Aresta(g,0,2,1);
    Insere_Aresta(g,1,2,1);
    Insere_Aresta(g,1,4,1);
    Insere_Aresta(g,1,3,1);
    Insere_Aresta(g,2,4,1);
    Insere_Aresta(g,3,4,1);
    Insere_Aresta(g,3,5,1);


   //Busca_profundidadeIterativa(g,0);

  int flag= Busca_LarguraRecursivo(g,0);
  if(!flag)
  {
      printf("erro");
  }else if(flag==-1)
  {
      printf("inconsistencia");
  }
   Libera_Grafo(&g);



}
