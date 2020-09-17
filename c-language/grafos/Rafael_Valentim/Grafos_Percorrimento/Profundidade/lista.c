#include <stdio.h>
#include <stdlib.h>
#include "lista.h"

typedef struct aresta_{
    int vertice;
    int peso;
    struct aresta_ *proximo;
}Aresta;

typedef struct lista{
    Aresta *primeiro;
    int tam;
    Aresta *ultimo;
}Lista;

Lista *criar_lista(){
    Lista *l = malloc(sizeof(Lista));
    l->primeiro = NULL;
    l->tam = 0;
    l->ultimo = NULL;
    return l;
}

int vazia(Lista *a){
    return a->primeiro == NULL;
}

Aresta * criar_item(){
    return malloc(sizeof(Aresta));
}

void inserir_inicio(Lista *a, int vertice, int peso){
    Aresta *item = malloc(sizeof(Aresta));
    item->vertice = vertice;
    item->peso = peso;
    if(!vazia(a))item->proximo = a->primeiro;
    else{
        item->proximo = NULL;
        a->ultimo = item;
    }
    a->primeiro = item;
    a->tam++;
}

void inserir_final(Lista *a, int vertice, int peso){
    Aresta *item = malloc(sizeof(Aresta));
    item->vertice = vertice;
    item->peso = peso;
    item->proximo = NULL;
    if(!vazia(a))a->ultimo->proximo = item;
    else a->primeiro = item;
    a->ultimo = item;
    a->tam++;
}

int contem(Lista *l, int i){
    if(l == NULL) return -1;

    Aresta *item = l->primeiro;
    while(item != NULL){
        if(item->vertice == i) return 1;
        item = item->proximo;
    }
    return 0;
}

int buscar_elemento(Lista *l, int elem, int * item_){
    if(l == NULL) return -1;

    Aresta *item = l->primeiro;
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
    Aresta *item = l->primeiro;
    Aresta * aux = NULL;
    while(item != NULL){
        if(item->vertice == elem){
            if(aux != NULL)aux->proximo = item->proximo;
            else l->primeiro = NULL;
            if(item->proximo == NULL) l->ultimo = aux;
            free(item);
            l->tam--;
            return 1;
        }
        aux = item;
        item = item->proximo;
    }
    return -1;
}

void mostrar_lista(Lista *a){
    Aresta *item = a->primeiro;
    while(item != NULL){
        printf("-[%d]->%d  ", item->peso, item->vertice);
        item = item->proximo;
    }
    printf("\n");
}

int lista_length(Lista *l){
    return l->tam;
}

int * map_to_int(Lista *a){
    int i = 0;
    int *ints = calloc(a->tam, sizeof(int));
    Aresta *item = a->primeiro;
    while(item != NULL){
        ints[i++] = item->vertice;
        item = item->proximo;
    }
    return ints;
}

void liberar_lista(Lista ** l){
    Aresta *item = (*l)->primeiro;
    Aresta * aux = NULL;
    while(item != NULL){
        aux = item->proximo;
        free(item);
        item = aux;
    }
    free(*l);
}