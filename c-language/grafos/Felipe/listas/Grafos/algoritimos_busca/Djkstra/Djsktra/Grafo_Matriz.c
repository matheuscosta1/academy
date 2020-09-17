#include <stdio.h>
#include <stdlib.h>
#include "Grafo_Matriz.h"
#include "fila.h"
#define separador "\n=======================\n"
#define finalizador "\n\n=====================================\n\n"
#include <limits.h>
struct grafo {
   int qtd_arestas,qtd_vertices;
   int * grau;
   int**aresta;
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

    g->aresta=(int**)malloc(sizeof(int*)*vertice);
    if(g->aresta==NULL)
    {
        free(g->grau);
        free(g);
        return NULL;
    }
    for(int i=0;i<vertice;i++)
    {
        g->aresta[i]=(int*)calloc(sizeof(int),vertice);
        if(g->aresta[i]==NULL)
        {
            for(int k=(i-1);k>=0;k--)
            {
               free(g->aresta[k]);
            }
            free(g->aresta);
            free(g->grau);
            free(g);
        }
    }

    return g;
}

int Insere_Aresta(Grafo* g,int v1,int v2,int peso)
{
    if(g==NULL)return -1;
    if((v1<0||v1>=g->qtd_vertices) && (v2<0 || v2>=g->qtd_vertices) )return -1;

    if(g->aresta[v1][v2]!=0)return 0;

   g->aresta[v1][v2]=peso;
    g->qtd_arestas++;
    g->grau[v1]++;
    g->grau[v2]++;
    return 1;
}

int Verifica_Aresta(Grafo* g ,int v1,int v2)
{
    if(g==NULL)return -1;
    if((v1<0||v1>=g->qtd_vertices) && (v2<0 || v2>=g->qtd_vertices) )return -1;


    if(g->aresta[v1][v2]==0)return 0;

    return 1;
}

int Remove_Aresta(Grafo* g,int v1,int v2)
{
    if(g==NULL)return -1;
    if((v1<0||v1>=g->qtd_vertices) && (v2<0 || v2>=g->qtd_vertices) )return -1;

    if(g->aresta[v1][v2]==0)return 0;

    g->aresta[v1][v2]=0;
    g->qtd_arestas--;
    g->grau[v1]--;
    g->grau[v2]--;
    return 1;

}

int Consulta_Aresta(Grafo *g,int v1,int v2,int* peso)
{
    if(g==NULL)return -1;
    if((v1<0||v1>=g->qtd_vertices) && (v2<0 || v2>=g->qtd_vertices) )return -1;

    if(g->aresta[v1][v2]==0)return 0;

    *peso=g->aresta[v1][v2];

    return 1;
}

void Libera_grafo(Grafo** g)
{
  if( g== NULL)return;

  for(int i=0;i < (*g)->qtd_vertices;i++)
  {
      free((*g)->aresta[i]);
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
    for(int i=0;i<g->qtd_vertices;i++)
    {
        if(g->aresta[v][i]!=0)
        {
            printf("vertice[%d]->vertice[%d]=%d\n",v,i,g->aresta[v][i]);
            sinalizador.flag=1;

        }
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
    printf("\nRelacao de adjacencias dos vertices do Grafo:\n");
    for(int i=0;i<g->qtd_vertices;i++)
    {
        for(int j=0;j<g->qtd_vertices;j++)
        {
            if(g->aresta[i][j]!=0)
            printf("Vertice[%d]->Vertice[%d]=%d\n",i,j,g->aresta[i][j]);
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
    int aux;
    int prox;
    if(origem>0)prox=0;
    else if(origem!=g->qtd_vertices-1)prox=g->qtd_vertices-1;

    for( i=0;i<g->qtd_vertices;i++){

         aux=g->aresta[origem][i];
         if(aux)
         {
             if((*Distancia)[i]!=0){
             (*Distancia)[i]=aux;
             (*ancestrais)[i]=origem;
             }
         }
    }

     //Tratando outros vertices

     int atual;
     for(int j=1;j<g->qtd_vertices-1;j++)
     {   //escolhe o um elemento da lista de distancias que ainda nao foi visitado
         for(i=0;i<g->qtd_vertices;i++){
         if(!visitados[i]&& (*Distancia)[i]!=0)
         {
             prox=i;
             break;
         }
     }//escolhe dentre os que nao foram visitados o menor!!
      for(i=0;i<g->qtd_vertices;i++){
         if(!visitados[i]&& (*Distancia)[i]!=0)
         {
             if((*Distancia)[i]<(*Distancia)[prox])
             {
                 prox=i;
             }
         }
     }

       //trata o proximo vertice
        atual = prox;
           visitados[atual]=1;

           for(i=0;i<g->qtd_vertices;i++)
           {
               aux=g->aresta[atual][i];
               if(aux)
               {
                   if(!visitados[i])
                   {


                       if((*Distancia)[i]>aux+(*Distancia)[atual])
                       {
                           (*Distancia)[i]=aux+(*Distancia)[atual];
                           (*ancestrais)[i]=atual;

                       }

                   }
               }
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
