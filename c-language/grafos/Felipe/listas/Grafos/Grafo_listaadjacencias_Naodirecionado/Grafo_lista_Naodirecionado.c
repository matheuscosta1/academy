#include <stdio.h>
#include <stdlib.h>
#include "Grafo_lista_Naodirecionado.h"
#define separador "\n========================\n"
#include "Pilha.h"
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

void Busca_profundidadeaux(Grafo* g,int v,int* visitados);

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
    if(v1==v2)return -1;
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
     //colocando n na lista de v1
     n->prox=g->aresta[v1];
     g->aresta[v1]=n;

     aux=g->aresta[v2];

   while(aux !=NULL && aux->vertice!=v1)
   {
       aux=aux->prox;
   }
   if(aux!=NULL)return 0;



    No* n1=(No*)malloc(sizeof(No));
     if(n1==NULL)return -1;
      //colocando n na lista de v2
      n1->vertice=v1;
      n1->peso=peso;
      n1->prox=g->aresta[v2];
      g->aresta[v2]=n1;


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


 aux=g->aresta[v2];
 ant=NULL;
   while(aux !=NULL && aux->vertice!=v1)
   {   ant=aux;
       aux=aux->prox;
   }
   if(aux==NULL)return 0;

   if(ant==NULL)g->aresta[v2]=aux->prox;


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

void Libera_Grafo(Grafo** g)
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

void Busca_profundidadeaux(Grafo* g,int vertice,int* visitados)
{
    visitados[vertice]=1;
    printf("%s",separador);
    printf("Vetor visitados:");
    for(int i=0;i<g->qtd_vertices;i++)
    {
        if(visitados[i]!=0)printf(" [%d] ",(i+1));
    }
    printf("%s",separador);

    printf("VerticeAtual[%d]:\n",vertice+1);
    printf("Listaadjacencias:\n");
    mostra_adjacentes(g,vertice);

    //buscar adjacentes
    No* aux=g->aresta[vertice];
    No* aux2;
    while(aux!=NULL)
    {
        if(visitados[aux->vertice]==0)
        {

            printf("\nproximo a ser chamado:vertice[%d]\n",(aux->vertice)+1);
            aux2=aux->prox;
            printf("ordem de chamada:");
            while(aux2!=NULL)
            {
                printf(" [%d] ", (aux2->vertice)+1);
                aux2=aux2->prox;
            }
        Busca_profundidadeaux(g,aux->vertice,visitados);
        }
        aux=aux->prox;

    }

}


int Busca_profundidade(Grafo *g,int vertice)
{
    if(g==NULL)return -1;

    if(vertice<0 || vertice>=Qtd_vertices(g))return -1;



    int* visitados =calloc(sizeof(int),Qtd_vertices(g));
    if (visitados==NULL)return 0;


    Busca_profundidadeaux(g,vertice,visitados);

    return 1;


}
int Todos_Busca_profundidade(Grafo *g)
{
    if(g==NULL)return -1;



    int* visitados =malloc(sizeof(int)*Qtd_vertices(g));
    if (visitados==NULL)return 0;

    for(int i=0;i<Qtd_vertices(g);i++)
    {
     printf("%s",separador);
     printf("Busca para iniciando do vertice[%d]",i+1);


      for(int j=0;j<Qtd_vertices(g);j++)visitados[j]=0;//Zerando o vetor de adjacencias
    Busca_profundidadeaux(g,i,visitados);
    }
    return 1;


}


int Busca_profundidadeIterativa(Grafo* g,int vert)
{
    if(g==NULL)return -1;

    if(vert<0 || vert>=g->qtd_vertices)return -1;

    int* visitados=calloc(sizeof(int),g->qtd_vertices);
    if(visitados==NULL)return 0;

    Pilha* p=Cria_Pilha();

    if(p==NULL)
    {
        free(visitados);
        return 0;
    }


    No* aux=g->aresta[vert];

    while(aux!=NULL)
    {
        Empilha(p,aux->vertice);
        aux=aux->prox;
    }
       Empilha(p,vert);
    int atual;
    int i;
    while(Tamanho_Pilha(p)){
          Desempilha(p,&atual);


     visitados[atual]=1;
 //funçao executada em cada no
    printf("%s",separador);
    printf("Vertice[%d]\n",atual);
    printf("Vetorvisitados:");
    for (i=0;i<g->qtd_vertices;i++)
    {
        if(visitados[i])printf(" [%d] ",i);
    }
    printf("%s",separador);
    printf("Lista Adjacencias\n");
   mostra_adjacentes(g,atual);

    printf("%s",separador);

    printf("Ordem de Tratados:");
    Pilha* p2 =Cria_Pilha();
    if(p2==NULL)
    {
        Libera_Pilha(&p);
        free(visitados);
        return 0;

    }
    while(Tamanho_Pilha(p))
    {
        Desempilha(p,&i);
        printf(" [%d] ",i);
        Empilha(p2,i);

    }
    while(Tamanho_Pilha(p2))
    {
        Desempilha(p2,&i);
        Empilha(p,i);
    }

    printf("%s",separador);

//Fim da funçao
    while(visitados[atual] && Desempilha(p,&atual));
    if(visitados[atual])
    {
        printf("\ntodos os vertices possiveis explorados!!\n");
        break;
    }

      aux=g->aresta[atual];

    while(aux!=NULL)
    {
        Empilha(p,aux->vertice);
        aux=aux->prox;
    }
        Empilha(p,atual);

    }

return 1;
}
