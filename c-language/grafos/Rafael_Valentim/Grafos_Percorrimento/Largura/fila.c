#include "fila.h"

struct vertice_
{
    int vertice;
    Vertice *link;
};

struct fila_{
    Vertice *first;
    Vertice *last;
    int tam;
};

Fila *makeFila(){
    Fila * f = malloc(sizeof(Fila));
    f->first = NULL;
    f->last = NULL;
    f->tam = 0;
    return f;
}

int enqueue(Fila *f, int vertice){
    if(f == NULL) return 0;

    Vertice *v= malloc(sizeof(Vertice));
    v->vertice = vertice;
    v->link = NULL;
    if(isQueueEmpty(f)){
        f->first =v;
    }else{
        f->last->link = v;
    }
    f->tam ++;
    f->last = v;
    return 1;
}

 int dequeue_asint(Fila *f){
    if(isQueueEmpty(f)) return INT_MIN;

    Vertice *temp = f->first;
    f->first = f->first->link;
    if(f->first == NULL) f->last = f->first;
    f->tam--;
    return temp->vertice;
}

Vertice * dequeue(Fila *f){
    if(isQueueEmpty(f)) return NULL;

    Vertice *temp = f->first;
    f->first = f->first->link;
    if(f->first == NULL) f->last = f->first;
    f->tam--;
    return temp;
}

void print_fila(Fila *f){
    Fila *aux = makeFila();
    Vertice *v_aux;
    printf("Fila ::<-");
    while((v_aux = dequeue(f)) != NULL){
        printf("%d<-", v_aux->vertice);
        enqueue(aux, v_aux->vertice);
        free(v_aux);
    }
      while((v_aux = dequeue(aux)) != NULL){
        enqueue(f, v_aux->vertice);
        free(v_aux);
    }
    printf("\n");
}
