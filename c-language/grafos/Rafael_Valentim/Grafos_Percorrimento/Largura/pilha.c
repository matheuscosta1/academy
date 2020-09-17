//
// Created by rafael on 02/12/17.
//

#include "pilha.h"
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
struct pilha_{
        Vertice * top;
        Vertice * bottom;
};

struct vertice_
{
    int vertice;
    Vertice *below;
};

Pilha *makePilha(){
    Pilha * p = malloc(sizeof(Pilha));
    p->top  = p->bottom = NULL;
    return p;
}

int push(Pilha *p, int vertice){
    if(p == NULL) return 0;

    Vertice * ver = malloc(sizeof(Vertice));
    ver->vertice = vertice;

    if(isPilhaVazia(p)){
        p->bottom = ver;
    }else{
        ver->below = p->top;
    }
    p->top = ver;
    return  1;
}

int pop(Pilha *p){
    if(isPilhaVazia(p)) return INT_MIN;
    Vertice *temp = p->top;
    p->top = temp->below;
    if(p->top == NULL)p->bottom = NULL;
    return  temp->vertice;
}