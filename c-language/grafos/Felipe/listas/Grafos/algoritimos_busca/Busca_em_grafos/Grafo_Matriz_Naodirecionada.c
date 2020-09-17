#include <stdio.h>
#include <stdlib.h>
#include "Grafo_Matriz_Naodirecionada.h"
#define separador "\n==========================\n"
#define finalizador "\n\n===================================================\n\n"

#include "fila.h"
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
    if(v1==v2)return -1;

    if(g->aresta[v1][v2]!=0 )return 0;

   g->aresta[v1][v2]=peso;
   g->aresta[v2][v1]=peso;
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
    g->aresta[v2][v1]=0;
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

void Libera_Grafo(Grafo** g)
{
  if( (*g)== NULL)return;

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

int Busca_Largura(Grafo* g,int vertice)
{
    if(g==NULL)return -1;
    if(vertice <0 || vertice>=g->qtd_vertices)return -1;

    int* visitados;
    Fila* f;

    visitados=(int*)calloc(sizeof(int),g->qtd_vertices);
    if(visitados==NULL)return 0;

    f=Cria_Fila();
    if(f==NULL){free(visitados);return 0;}

    // inicio do algoritmo

  int atual=vertice;
  do{
        do{
    Remove_fila(f,&atual);
    }while(visitados[atual]&&Tamanho_fila(f));
    visitados[atual]=1;
    for(int i=0;i<g->qtd_vertices;i++)
    {
        if(g->aresta[atual][i])
        {
            if(!visitados[i])
            {
                Insere_fila(f,i);
            }
        }
    }
    //funçao
    printf("Vetor visitados:");
    for(int j=0;j<g->qtd_vertices;j++)
    {
        if(visitados[j])printf(" [%d] ",j);
    }
    printf("%s",separador);
    printf("Fila:");
    Imprime_fila(f);
    printf("%s",separador);
    printf("Lista adjacencias de [%d]:\n",atual);
    mostra_adjacentes(g,atual);

 printf("%s",finalizador);
    //fim funçao

  }while(Tamanho_fila(f));
    free(visitados);
    Libera_fila(&f);
    return 1;
}

int Todosbusca_Largura(Grafo* g)
{
    if(g==NULL)return -1;


    int* visitados;
    Fila* f;

    visitados=(int*)malloc(sizeof(int)*g->qtd_vertices);
    if(visitados==NULL)return 0;

    f=Cria_Fila();
    if(f==NULL){free(visitados);return 0;}

    // inicio do algoritmo
    int j;
    int atual;
for(int i=0;i<g->qtd_vertices;i++){
   atual=i;
  printf("vetor inicial[%d]\n",atual);
    for(j=0;j<g->qtd_vertices;j++)
    {
        visitados[j]=0;
    }
  do{
        do{
    Remove_fila(f,&atual);
    }while(visitados[atual] && Tamanho_fila(f));

    visitados[atual]=1;
    for( j=0;j<g->qtd_vertices;j++)
    {
        if(g->aresta[atual][j])
        {
            if(!visitados[j])
            {
                Insere_fila(f,j);
            }
        }
    }
    //funçao
    printf("Vetor visitados:");
    for( j=0;j<g->qtd_vertices;j++)
    {
        if(visitados[j])printf(" [%d] ",j);
    }
    printf("%s",separador);
    printf("Fila:");
    Imprime_fila(f);
    printf("%s",separador);
    printf("Lista adjacencias de [%d]:\n",atual);
    mostra_adjacentes(g,atual);

 printf("%s",finalizador);
    //fim funçao

  }while(Tamanho_fila(f));
}
    free(visitados);
    Libera_fila(&f);
    return 1;
}

int Busca_LarguraRecursivo(Grafo* g,int v)
{
    if(g==NULL)return -1;
    if(v<0 || v>g->qtd_vertices )return -1;

    int* visitados=(int*)calloc(sizeof(int),g->qtd_vertices);
    if(visitados==NULL)return 0;


       Busca_larguraaux(g,v, visitados);

    free(visitados);
return 1;
}

void Busca_larguraaux(Grafo* g,int v,int* visitados)
{
    visitados[v]=1;
    int j;
    printf("Vetor visitados:");
    for( j=0;j<g->qtd_vertices;j++)
    {
        if(visitados[j])printf(" [%d] ",j);
    }
      printf("%s",separador);
    printf("Lista adjacencias de [%d]:\n",v);
    mostra_adjacentes(g,v);
     printf("%s",finalizador);
    int i;
    for(i=0;i<g->qtd_vertices;i++)
    {
      if(g->aresta[v][i] && !visitados[i])
           Busca_larguraaux(g,i,visitados);
    }
    //funçao


}

int vertice_conectado(Grafo* g,int v)
{
  if(g==NULL)return -1;

  if(v<0 || v>=g->qtd_vertices)return -1;


  int*visitados=(int*)calloc(sizeof(int),g->qtd_vertices);
  if(visitados==NULL)return -1;


     Busca_larguraaux(g,v,visitados);


     for(int i=0;i<g->qtd_vertices;i++)
     {
         if(!visitados[i])
         {
             return 0;
         }
     }

     return 1;
}
