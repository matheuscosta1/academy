#include <stdio.h>
#include <stdlib.h>
#include "lista.h"

typedef struct item{
    int vertice;
    int peso;
    Item *proximo;
}Item;

typedef struct lista{
    Item *primeiro;
    Item *ultimo;
}Lista;

Lista *criar_lista(){
    Lista *l = malloc(sizeof(Lista));
    l->primeiro = NULL;
    l->ultimo = NULL;
    return l;
}

int vazia(Lista *a){
    return a->primeiro == NULL;
}

Item * criar_item(){
    return malloc(sizeof(Item));
}

void inserir_inicio(Lista *a, int vertice, int peso){
    Item *item = malloc(sizeof(Item));
    item->vertice = vertice;
    item->peso = peso;
    if(!vazia(a))item->proximo = a->primeiro;
    else{
        item->proximo = NULL;
        a->ultimo = item;
    }
    a->primeiro = item;
}

void inserir_final(Lista *a, int vertice, int peso){
    Item *item = malloc(sizeof(Item));
    item->vertice = vertice;
    item->peso = peso;
    item->proximo = NULL;
    if(!vazia(a))a->ultimo->proximo = item;
    else a->primeiro = item;
    a->ultimo = item;
}

int contem(Lista *l, int i){
    if(l == NULL) return -1;

    Item *item = l->primeiro;
    while(item != NULL){
        if(item->vertice == i) return 1;
        item = item->proximo;
    }
    return 0;
}

int buscar_elemento(Lista *l, int elem, int * item_){
    if(l == NULL) return -1;

    Item *item = l->primeiro;
    while(item != NULL){
        if(item->vertice == elem){
            *item_ = item->peso;
            return 1;
        }
        item = item->proximo;
    }
    return 0;
}

int remover_elemento(Lista *l, int elem){
    Item *item = l->primeiro;
    Item * aux = NULL;
    while(item != NULL){
        if(item->vertice == elem){
            if(aux != NULL)aux->proximo = item->proximo;
            else l->primeiro = NULL;
            if(item->proximo == NULL) l->ultimo = aux;
            free(item);
            return 1;
        }
        aux = item;
        item = item->proximo;
    }
    return -1;
}

void mostrar_lista(Lista *a){
    Item *item = a->primeiro;
    while(item != NULL){
        printf("-[%d]->%d  ", item->peso, item->vertice);
        item = item->proximo;
    }
    printf("\n");
}

void liberar_lista(Lista ** l){
    Item *item = (*l)->primeiro;
    Item * aux = NULL;
    while(item != NULL){
        aux = item->proximo;
        free(item);
        item = aux;
    }
    free(*l);
}