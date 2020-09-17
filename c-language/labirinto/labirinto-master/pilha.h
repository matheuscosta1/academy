#ifndef PILHA_H_INCLUDED
#define PILHA_H_INCLUDED
#include <stdlib.h>
#include <stdio.h>
#define IS_NODE 1
#define IS_CHILD 0
#define IS_OUT 2
typedef struct path_{
    int l;
    int c;
    int isNode;
    struct path_ *below;
}Path;

typedef struct pilha_{
    Path *top;
    Path *bottom;
} Pilha;

Pilha * makePilha();
void push(Pilha* pilha, int l, int c, int isNode);
Path *pullPath(Pilha *p);
Path *pull(Pilha *p);
void printPilha(Pilha *p, FILE *f);
void destroyPilha(Pilha *p);
#endif