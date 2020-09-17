#include<stdio.h>
#include<stdlib.h>
#include"pilha.h"

typedef struct elm Elm;
 struct elm{
   int info;
   Elm* prox;
};
struct pilha{
  int Tamanho;
  Elm* Topo;
};


Pilha* Cria_Pilha()
{
    Pilha* p=(Pilha*)malloc(sizeof(Pilha));

    if(p==NULL)return NULL;

    p->Tamanho=0;
    p->Topo=NULL;

    return p;
}

int Tamanho_Pilha(Pilha* p)
{
    if(p==NULL)return -1;

    return p->Tamanho;
}

int Empilha(Pilha* p,int i)
{
    if(p==NULL)return -1;

    Elm* n=(Elm*)malloc(sizeof(Elm));

    if(n==NULL)return 0;


      n->info=i;

      n->prox=p->Topo;
      p->Topo=n;
      p->Tamanho++;
      return 1;
}
int Desempilha(Pilha* p,int* i)
{
    if(p==NULL)return -1;

    if(p->Tamanho==0)return 0;
    *i=p->Topo->info;

    Elm* aux =p->Topo;

    p->Topo=p->Topo->prox;

     p->Tamanho--;
    free(aux);

    return 1;
}

int Verifica_Elem(Pilha* p,int i)
{
    if(p==NULL)return -1;

    Elm* aux = p->Topo;

    while(aux!=NULL && aux->info!= i )
    {
        aux=aux->prox;
    }
    if(aux==NULL)return 0;

    return 1;
}

void Libera_Pilha(Pilha**p)
{
    if((*p)==NULL)return;

    Elm* aux;
    Elm* aux2;

    aux=(*p)->Topo;
    aux2=NULL;

    while(aux!=NULL)
    {
        aux2=aux;
        aux=aux->prox;
        free(aux2);

    }
    free(*p);

    *p=NULL;



}
