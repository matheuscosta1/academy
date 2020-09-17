#include <stdio.h>
#include <stdlib.h>
#include "Grafos_Listaadjacencias.h"


struct grafo {
   int qtd_arestas,qtd_vertices;
   int *grau;
   No**aresta;
};

struct no{
  int vertice;
  int peso;
  No* prox;
};


Grafo* Cria_grafo(int vertice)
{
    if(vertice<=0)
        return NULL;

    Grafo* g = (Grafo*)malloc(sizeof(Grafo));

    if(g==NULL)return g;

    g->qtd_vertices=vertice;
    g->qtd_arestas=0;

    g->grau=(int*)calloc(sizeof(int),vertice);
    if(g->grau==NULL)
    {
        free(g);
        return NULL;
    }

    g->aresta=(No**)malloc(sizeof(No*)*vertice);
    if(g->aresta==NULL)
    {
        free(g->grau);
        free(g);
        return NULL;
    }
    for(int i=0;i<g->qtd_vertices;i++)
    {
        g->aresta[i]=NULL;
    }
    return g;
}

int Insere_Aresta(Grafo* g,int v1,int v2,int peso)
{
    if(g==NULL)return -1;
    if((v1<0||v1>=g->qtd_vertices) && (v2<0 || v2>=g->qtd_vertices) )return -1;

   No* aux=g->aresta[v1];

   while(aux !=NULL && aux->vertice!=v2)
   {
       aux=aux->prox;
   }
   if(aux!=NULL)return 0;

    No* n=(No*)malloc(sizeof(No));//alocando um novo no
  if(n==NULL)return -1;

     n->vertice=v2;
     n->peso=peso;
     //colocando n na lista
     n->prox=g->aresta[v1];
     g->aresta[v1]=n;



    g->qtd_arestas++;
    g->grau[v1]++;
    g->grau[v2]++;
    return 1;
}

int Verifica_Aresta(Grafo* g ,int v1,int v2)
{
    if(g==NULL)return -1;
    if((v1<0||v1>=g->qtd_vertices) && (v2<0 || v2>=g->qtd_vertices) )return -1;

    No* aux=g->aresta[v1];

   while(aux !=NULL && aux->vertice!=v2)
   {
       aux=aux->prox;
   }
   if(aux==NULL)return 0;

    return 1;
}

int Remove_Aresta(Grafo* g,int v1,int v2)
{
    if(g==NULL)return -1;
    if((v1<0||v1>=g->qtd_vertices) && (v2<0 || v2>=g->qtd_vertices) )return -1;


   No* aux=g->aresta[v1];
   No* ant=NULL;
   while(aux !=NULL && aux->vertice!=v2)
   {   ant=aux;
       aux=aux->prox;
   }
   if(aux==NULL)return 0;

   if(ant==NULL)g->aresta[v1]=aux->prox;


   ant->prox=aux->prox;

   free(aux);




    g->qtd_arestas--;
    g->grau[v1]--;
    g->grau[v2]--;
    return 1;

}

int Consulta_Aresta(Grafo *g,int v1,int v2,int* peso)
{
    if(g==NULL)return -1;
    if((v1<0||v1>=g->qtd_vertices) && (v2<0 || v2>=g->qtd_vertices) )return -1;

    No* aux=g->aresta[v1];

   while(aux !=NULL && aux->vertice!=v2)
   {
       aux=aux->prox;
   }
   if(aux==NULL)return 0;

    *peso=aux->peso;

    return 1;
}

void Libera_grafo(Grafo** g)
{
  if( (*g)== NULL)return;

  No* aux;
  No* aux2;
  for(int i=0;i < (*g)->qtd_vertices;i++)
  {    aux=(*g)->aresta[i];
     while(aux!=NULL)
      {
          aux2=aux;
          aux=aux->prox;
          free(aux2);
      }

  }
  free((*g)->aresta);
  free((*g)->grau);
  free(*g);
   *g=NULL;

}

void mostra_adjacentes(Grafo* g,int v)
{    struct sinalizador{
       unsigned int flag : 1;
      }sinalizador;
    if(g==NULL)
    {
        printf("Grafo inconsistente");
        return;
    }

    if(v<0 || v>=g->qtd_vertices )
    {
        printf("vertice invalido!!");
        return;
    }
    sinalizador.flag=0;
    No* aux=g->aresta[v];
    while(aux!=NULL)
    {
            printf("vertice[%d]->vertice[%d]=%d\n",v,aux->vertice,aux->peso);
            sinalizador.flag=1;
            aux=aux->prox;


    }
    if(!(sinalizador.flag))printf("O vertice %d nao possui adjacentes\n",v);



}
void mostra_grafo(Grafo* g)
{
    if(g==NULL)
    {
        printf("\nGrafo nao existe!!\n");
        return;
    }
    No* aux;
    printf("\nRelacao de adjacencias dos vertices do Grafo:\n");
    for(int i=0;i<g->qtd_vertices;i++)
    {   aux=g->aresta[i];
        while (aux!=NULL)
        {
            printf("Vertice[%d]->Vertice[%d]=%d\n",i,aux->vertice,aux->peso);
            aux=aux->prox;
        }
    }

}

int Qtd_arestas(Grafo *g)
{
    if(g==NULL)return -1;

    return g->qtd_arestas;
}
int Qtd_vertices(Grafo *g)
{
    if(g==NULL)return -1;

    return g->qtd_vertices;
}

int Grau_vertice(Grafo* g,int v)
{
    if(g==NULL)return -1;

    if(v<0 || v>=g->qtd_vertices)return -1;

    return g->grau[v];

}
