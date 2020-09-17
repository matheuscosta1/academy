#include <stdio.h>
#include <stdlib.h>
#include "arvore.h"

struct no {
    int info;
    struct no *sae;
    struct no *sad;
};

Arv cria_vazia(){
    return NULL;
}

Arv cria_arvore(int elem, Arv esq, Arv dir){
    Arv novo =  malloc (sizeof(Arv));
    if(novo == NULL)
        return NULL;

    novo -> info = elem;
    novo -> sae = esq;
    novo -> sad = dir;

    return novo;
}

void libera_arvore (Arv *A){
    if ((*A) != NULL){
        libera_arvore(&(*A)->sae);
        libera_arvore(&(*A)->sad);
        free(*A);
    }
    (*A) = NULL;
}

int arvore_vazia(Arv A){
    return A == NULL;
}

int busca(Arv A, int elem){
    if(arvore_vazia(A))
        return 0;
    else
        return A -> info == elem || busca(A->sae, elem) || busca(A->sad, elem);
}

void exibe_arvore (Arv A){
    if (A==NULL){
        printf("<>");
    }
    else
    {
        printf("<");
        printf("%d", A -> info);
        exibe_arvore(A -> sae);
        exibe_arvore(A -> sad);
        printf(">");
    }
}

int remove_folha(Arv *A, int elem){
	if ((*A) == NULL) return 0;

	if((*A)->info == elem){
        if((*A)->sae == NULL && (*A)->sad == NULL){
            free((*A));
            (*A) = NULL;
            return 1;
        }
        else {
        return 0;
        }
	}
    else {
        remove_folha(&(*A)->sae, elem);
        remove_folha(&(*A)->sad, elem);
        return 1;
    }
    return 0;
}

int altura (Arv A){
    if (A == NULL){
        return 0;
    }

    int altura_esquerda = altura(A->sae);
    int altura_direita = altura (A->sad);

    if(altura_esquerda>altura_direita) return altura_esquerda+1;
    return altura_direita+1;
}

