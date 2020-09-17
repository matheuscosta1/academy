#include <stdio.h>
#include <stdlib.h>
#include "Grafo_listaadjacencias.h"
#include "limits.h"

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
int Djsktra(Grafo* g,int origem,int** ancestrais,int** Distancia)
{   //testando condiçoes
    if(g==NULL)return -1;

    if(origem<0 || origem>=g->qtd_vertices)return -1;

     //alocando variaveis
    int* visitados;
    visitados=(int*)calloc(sizeof(int),(g->qtd_vertices));
    if(visitados==NULL)return 0;

    (*ancestrais)=(int*)malloc(sizeof(int)*(g->qtd_vertices));
    if((*ancestrais)==NULL)
    {
        free(visitados);
        return 0;
    }

     (*Distancia)=(int*)malloc(sizeof(int)*(g->qtd_vertices));
     if((*Distancia)==NULL)
     {
         free(visitados);
         free(*ancestrais);
         return 0;
     }

     //iniciando estruturas
     int i;
     for( i=0;i<g->qtd_vertices;i++)
     {
         (*ancestrais)[i]=-1;
         (*Distancia)[i]=INT_MAX;
     }
   //Tratando a origem
    visitados[origem]=1;
    (*Distancia)[origem]=0;
    (*ancestrais)[origem]=-1;
    No*aux;

    aux=g->aresta[origem];
    while(aux!=NULL)
    {
        (*Distancia)[aux->vertice]=aux->peso;
        (*ancestrais)[aux->vertice]=origem;
        aux=aux->prox;
    }

     //Tratando outros vertices

     int atual;
     int vertice;
     int peso;
     for(int j=1;j<g->qtd_vertices-1;j++)
     {   //escolhe  um elemento da lista de distancias que ainda nao foi visitado
         for(i=0;i<g->qtd_vertices;i++){
         if(!visitados[i]&& (*Distancia)[i]!=0)
         {
             vertice=i;
             break;
         }
     }//escolhe dentre os que nao foram visitados o menor!!
      for(i=0;i<g->qtd_vertices;i++){
         if(!visitados[i]&& (*Distancia)[i]!=0)
         {
             if((*Distancia)[i]<(*Distancia)[vertice])
             {
                 vertice=i;
             }
         }
     }

       //trata o proximo vertice
        atual = vertice;
           visitados[atual]=1;
           aux=g->aresta[atual];
           vertice=g->aresta[atual]->vertice;
           peso=g->aresta[atual]->peso;
           while(aux!=NULL)
           {
                   if(!visitados[vertice])
                   {


                       if((*Distancia)[vertice]>peso+(*Distancia)[atual])
                       {
                           (*Distancia)[vertice]=peso+(*Distancia)[atual];
                           (*ancestrais)[vertice]=atual;

                       }

                   }
               aux=aux->prox;
           }

    }


    free(visitados);
return 1;
}
void mostra_caminho(Grafo* g,int Destino,int* ancestrais,int* Distancia)
{
    int aux;
    int fim=0;
    int caminho[g->qtd_vertices];
    aux=ancestrais[Destino];
    int i=1;
    caminho[0]=Destino;
    if(aux==-1)
    {
        printf("Destino nao é atingivel do vertice inicial do vetor de ancestrais;");
        return;
    }
    while(aux!=-1)
    {
        caminho[i]=aux;
        aux=ancestrais[aux];
        fim++;
        i++;
    }

    printf("Caminho de %d -> %d:\n",caminho[fim],Destino);
    for(int i=fim;i>0;i--)
    {
        printf("%d --> ",caminho[i]);
    }
    printf("%d.Distancia total=%d",caminho[0],Distancia[Destino]);
}
