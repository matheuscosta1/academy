#include <stdio.h>
#include <stdlib.h>
#include "stack.h"


typedef struct item
{
    float valor; //valor == informação == o meu "nó"
    Item *proximo;
} Item;

typedef struct pilha
{
    Item *primeiro;
} Pilha;

Pilha *criaPilha()
{
    Pilha *x = (Pilha *) malloc(sizeof(Pilha));
    x -> primeiro = NULL;

    return x;
}

int vazia (Pilha *x)
{
    return x -> primeiro == NULL;
}

void empilhar (float i, Pilha *x)
{
    Item *p = (Item *) malloc(sizeof(Item));
    p -> valor = i;
    p -> proximo = x -> primeiro;
    x -> primeiro = p;
}

float desempilhar (Pilha *x)
{
    Item *aux;
    float i;

    if (vazia(x))
    {
        printf("A pilha está vazia!!!\n");
        exit(1); //Programa se encerra, há uma abortagem!!!
    }

    aux = x -> primeiro;
    i = aux -> valor;
    x -> primeiro = aux -> proximo;

    free(aux);

    return i;
}

void printStack (Pilha *x)
{
    Item *aux;

    for (aux = x -> primeiro; aux != NULL; aux = aux -> proximo)
        printf("%f\n", aux -> valor);
}


