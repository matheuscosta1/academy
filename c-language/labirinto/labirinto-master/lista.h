#ifndef FILA_H_INCLUDED
#define FILA_H_INCLUDED

#include "pilha.h"

typedef struct deadpath_{
    int l;
    int c;
    struct deadpath_ *next;

} DeadEndPath;

typedef struct lista{
    DeadEndPath *first;
    DeadEndPath *last;
}Lista;



Lista *makeLista();
void printList(Lista *l, FILE *f);
void insert(Lista *list, int l ,int c);
int contains(Lista *list, int l, int c);
void destroy(Lista *l);

#endif