#include "arvore_generica.h"
#include <stdlib.h>
#include <stdio.h>
#include "fila.h"

struct no {
    int info;
    struct no *esq;
    struct no *dir;
};

Arv cria_arvore(int elem){
    Arv novo = (Arv) malloc(sizeof(Arv));
    if (novo == NULL){
        return NULL;
    }

    novo -> info = elem;
    novo -> esq = NULL;
    novo -> dir = NULL;

    return novo;
}

int insere (Arv A, Arv sa){
    if (A == NULL){
        return 0;
    }

    sa -> dir = A -> esq;
    A -> esq = sa;
    return 1;
}

void exibe_arvore (Arv A){
    if (A == NULL){
        printf("<>");
    }
    else{
        printf("<");
        printf("%d", A -> info);
        exibe_arvore(A->esq);
        printf(">");
        exibe_arvore(A->dir);
    }
}

void pre_ordem (Arv A){
    if(A!=NULL){
        printf("|%d|\t", A -> info);
        pre_ordem(A->esq);
        pre_ordem(A->dir);
    }
}

void pos_ordem (Arv A){
    if(A!=NULL){
        pos_ordem(A->esq);
        pos_ordem(A->dir);
        printf("|%d|\t", A -> info);
    }
}

int altura_arvore(Arv A){
    int hmax = -1;
    Arv p = A -> esq;
    if (p == NULL){
        return 0;
    }
    else {
        int h = altura_arvore(p);
        if(h>hmax)
            hmax=h;
    }
    return altura_arvore(p->dir)+1;
}

int altura_no (Arv A, int elem){
    if(A == NULL) return -1;
    if(A->info == elem) return altura_arvore(A);
    int x,y;
    x = altura_no(A->esq, elem);
    y = altura_no(A->dir, elem);
    if(x != -1) return x;
    if(y != -1) return y;
    return -1;
}

int grau_arvore (Arv A){
    int grau=1;
    Arv arv;
    if(A->esq == NULL)
        return 0;
    for(arv = A->esq; arv != NULL;arv=arv->dir)
    {
        if(arv->dir != NULL){
           grau = grau+1;
        }
    }
    return grau;
}

int quantidade_nos(Arv A, int grau){
    int n=0, grau1 = 0;
    Arv arv= A->esq;
    if(A == NULL)
        return 0;
    while(arv!=NULL){
        n+=quantidade_nos(arv, grau);
        arv = arv->dir;
        grau1++;
    }
    if(grau1 == grau) return n+1;
    return n;
}

void largura (Arv A){
    Arv arv = A;
    Fila *f = criarFila();

    inserirFinal(f, A->esq);
    while(arv){
        printf("%d\t", arv->info);

        if(arv->dir){
            inserirFinal(f, arv->dir);
        }

        if(arv->esq){
            inserirFinal(f, arv->esq);
        }
        arv = remover(f);
    }
}

int no_folha (Arv A){
    int folha=0;
    Arv arv;
    if(A->esq == NULL)
        return 1;
    for(arv = A->esq; arv != NULL;arv=arv->dir)
    {
        folha = folha + no_folha(arv);
    }

    return folha;
}

int busca (Arv A, int elem){
    if (A == NULL){
        return 0;
    }
    if (A -> info == elem || busca(A->esq, elem) || busca(A->dir, elem)){
        return 1;
    }
    return 0;
}

int pertence(Arv A, int elem){
    Arv p;

    if(A->info == elem) return 1;
    else {
        for(p=A->esq; p!=NULL; p=p->dir){
            return 1;
        }
    }
    return 0;
}

void libera_arvore (Arv *A){
    if((*A)!=NULL){
        libera_arvore(&(*A)->esq);
        libera_arvore(&(*A)->dir);
        free(*A);
    }
    *A = NULL;
}
