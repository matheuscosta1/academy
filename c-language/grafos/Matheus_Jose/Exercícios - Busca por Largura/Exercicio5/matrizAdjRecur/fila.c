#include <stdio.h>
#include <stdlib.h>
#include "fila.h"
typedef struct item {
    Item *proximo;
    int valor;
} Item;

typedef struct fila{
    Item *primeiro;
    Item *ultimo;
    int quantidade;
} Fila;

int tamanho;

Fila *criarFila(){
    Fila *fi = malloc(sizeof(Fila));
    fi -> primeiro = NULL;
    fi -> ultimo = NULL;
}

int vazia (Fila *f){
    return f->ultimo == NULL && f->primeiro == NULL;
}

void inserirFinal (Fila *f, int x){
    Item *item = malloc (sizeof(Item));
    item -> valor = x;
    item -> proximo = NULL;

    if(vazia(f)){
        f -> primeiro = item;
    }
    else {
        f -> ultimo -> proximo = item;
    }
    f -> ultimo = item;
    f->quantidade++;
}

int remover(Fila *f){
    Item *aux = malloc(sizeof(Item));

    if(!vazia(f)){
        aux = f -> primeiro;
        int i = aux -> valor;
        f -> primeiro = aux -> proximo;

        f->quantidade--;
        if(f -> primeiro == NULL)
            f->ultimo = NULL;
        free(aux);
        return i;
    }
    return 0;
}

void imprimir(Fila *f){
    Item *aux = f -> primeiro;
    if(f == NULL) return 1;
    while(aux != NULL)
    {
        printf("%d\t", aux -> valor);
        aux = aux -> proximo;
    }
}
