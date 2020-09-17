#include "ABB.h"
#include "Registro.h"
#include <stdio.h>
#include <stdlib.h>

struct No{
    Registro info;
    Arv sae;
    Arv sad;
};

Arv Cria_arvore()
{
    return NULL;
}

int Arvore_Vazia(Arv A)
{
    return (!A);
}

int insere_ord(Arv *A,Registro G)
{
    if(A==NULL)
        return 0;

    if((*A)==NULL)
    {
        (*A)=(Arv)malloc(sizeof(struct No));
        (*A)->info=G;
        (*A)->sae=NULL;
        (*A)->sad=NULL;
        return 1;
    }

    if(Menor_Registro((*A)->info,G) == G)
    {
       return insere_ord(&((*A)->sae),G);
    }

    return insere_ord(&((*A)->sad),G);
}

Arv remove_ord(Arv* A,int chave)
{
    if(A==NULL)
        return NULL;

    if((*A)==NULL)
        return NULL;

    if(chave<get_chave((*A)->info))
    {
        return remove_ord(&((*A)->sae),chave);
    }
    if(chave>get_chave((*A)->info))
    {
        return remove_ord(&((*A)->sad),chave);
    }

    Arv aux;
    if((*A)->sae==NULL && (*A)->sad==NULL)
    {
        aux=(*A);
        (*A)=NULL;
        return aux;
    }
    if(((*A)->sae==NULL) && (*A)->sad!=NULL)
    {
        aux=(*A);
        (*A)=(*A)->sad;
        return aux;
    }

    if((*A)->sae!=NULL && (*A)->sad==NULL)
        {
            aux=(*A);
            (*A)=(*A)->sae;
            return aux;
        }

     aux=(*A)->sae;
     while(aux->sad!=NULL)
     {
         aux=aux->sad;
     }

    Registro temp= (*A)->info;
    (*A)->info=aux->info;
    aux->info = temp;

    return remove_ord(&((*A)->sae),chave);
}

Arv busca_bin(Arv A,int chave)
{
    if(A==NULL)
        return NULL;

    if(chave == get_chave(A->info))
    return A;

    if(chave<get_chave(A->info))
    {
        return busca_bin(A->sae,chave);
    }

    return busca_bin(A->sad,chave);
}

void exibe_arvore(Arv A)
{
    if(A==NULL)
    {
        printf("<>");
        return;
    }

    printf("<%d ",get_chave(A->info));
    exibe_arvore(A->sae);
    exibe_arvore(A->sad);
    printf(">");
}

void exibe_ord(Arv A)
{
    if(A==NULL)
    {
        return;
    }

    exibe_ord(A->sae);
    imprime(A->info);
    printf("\n");
    exibe_ord(A->sad);
}

void libera_arvore(Arv* A)
{
    if(A==NULL || (*A)==NULL)
        return;

    libera_arvore(&((*A)->sae));
    libera_arvore(&((*A)->sad));
    free((*A));
    (*A)=NULL;

}

int altura_arv(Arv a)
{
    if(a==NULL)
        return -1;

    int altura1= altura_arv(a->sae);
    int altura2= altura_arv(a->sad);

    if(altura1>=altura2)
        return 1+altura1;

   return 1+altura2;
}


