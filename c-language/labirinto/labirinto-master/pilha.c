#include "pilha.h"

Pilha * makePilha(){
    Pilha * p = malloc(sizeof(Pilha));
    p->top = p->bottom = NULL;

    return p;
}

void push(Pilha* pilha, int l, int c, int isNode){
    Path *p = malloc(sizeof(Path));
    p->l = l;
    p->c = c;
    p->isNode = isNode;
    p->below = pilha->top;
    pilha->top = p;
    if(pilha->bottom == NULL) pilha->bottom = p;
}

Path *pullPath(Pilha *p){
    if(p->bottom == NULL) return NULL;
    Path *temp;
    Path *lastTry = malloc(sizeof(Path));
    lastTry->l = -2;
    lastTry->c = -2;
    while(p->top->isNode != IS_NODE){
        temp = p->top->below;
        lastTry->l = p->top->l;
        lastTry-> c = p->top->c;
        free(p->top);
        p->top = temp;
    }
    return lastTry;
}

Path * pull(Pilha *p){
 if(p->bottom == NULL) return NULL;
   Path *temp;
   temp = p->top;
   p->top = temp->below;
   return temp;
}

void destroyPilha(Pilha *p){
    Path *temp;
    while(p->top != NULL){
        temp = p->top->below;
        free(p->top);
        p->top = temp;
    }
    free(p);

}

void  printPilha(Pilha *pilha, FILE *f){
    Pilha *aux = makePilha();
    printf("\n:::::::::Pilha:::::::::\n");
    while(pilha->top != NULL){
        Path *p = pull(pilha);
        push(aux, p->l, p->c, p->isNode);
        printf("-----------\nPosição: [%d][%d]\nisNode: %d\n", p->l, p->c, p->isNode);
        fprintf(f, "-----------\nPosição: [%d][%d]\nisNode: %d\n", p->l, p->c, p->isNode);
    }
      while(aux->top != NULL){
            Path *p = pull(aux);
            push(pilha, p->l, p->c, p->isNode);
      }
    printf("::::::::::::::::::::::::::\n");
    fprintf(f, "::::::::::::::::::::::::::\n");
}