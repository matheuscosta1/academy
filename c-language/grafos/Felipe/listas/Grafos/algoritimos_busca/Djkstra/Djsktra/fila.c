#include <stdio.h>
#include <stdlib.h>
#include "fila.h"

typedef struct no No;
 struct no
{
     int info;
     No* prox;
};

struct fila {
   int tamanho;
   No* inicio;
   No* fim;
};

Fila* Cria_Fila()
{
    Fila *f=(Fila*)malloc(sizeof(Fila));

    if(f==NULL)return NULL;

    f->tamanho=0;

    f->inicio=NULL;
    f->fim=NULL;

    return f;
}
int Tamanho_fila(Fila* f)
{
    if(f==NULL)return -1;

    return f->tamanho;
}

int Insere_fila(Fila* f,int i)
{
    if(f==NULL)return -1;

    No* aux=(No*)malloc(sizeof(No));
    if(aux==NULL)return 0;

    aux->info=i;
    aux->prox=NULL;
    if(f->tamanho==0)
    {
        f->fim=aux;
        f->inicio=aux;
    }else{
       f->fim->prox=aux;
       f->fim=aux;
    }
    f->tamanho++;
    return 1;

}

int Remove_fila(Fila*f ,int* i)
{
    if(f==NULL)return -1;
    if(f->tamanho==0)return -1;
    No* aux;


    aux=f->inicio;
    f->inicio=f->inicio->prox;

    *i=aux->info;

    if(f->tamanho==1)f->fim=NULL;
    free(aux);

    f->tamanho--;

    return 1;
}

int Libera_fila(Fila** f)
{
    if((*f)==NULL)return -1;

    No* aux = (*f)->inicio;
    No* aux2;
    while(aux!=NULL)
    {   aux2=aux;
        aux=aux->prox;
        free(aux2);
    }
    (*f)->inicio=NULL;
    (*f)->fim=NULL;
    (*f) = NULL;

    return 1;

}
void Imprime_fila(Fila* f)
{
    if(f==NULL){printf("Fila inexistente");return;}

    No* aux=f->inicio;
    while(aux!=NULL)
    {
        printf(" [%d] ",aux->info);
        aux=aux->prox;
    }

}
