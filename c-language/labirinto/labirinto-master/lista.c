#include "lista.h"


Lista *makeLista(){
    Lista *l = malloc(sizeof(Lista));
    l->first = NULL;
    l->last = NULL;
    return l;
}

void insert(Lista *list, int l ,int c){
    DeadEndPath *p = malloc(sizeof(DeadEndPath));
    p->l = l;
    p->c = c;
    p->next = NULL;
    if(list->first == NULL){
       list->first = p;
    }
     if(list->last != NULL) list->last->next = p;
     list->last = p;
}

int contains(Lista *list, int l, int c){
    DeadEndPath *aux = list->first;
    while(aux != NULL){
        if(aux->c == c && aux->l == l)return 1;
        aux = aux->next;
    }
    return 0;
}

void printList(Lista *list, FILE *f){
    int i =0;
    DeadEndPath *aux = list->first;
    fprintf(f, "::Lista com elementos nao acessaveis::\n");
    printf("::Lista com elementos nao acessaveis::\n");
    while(aux != NULL){
        printf("[%d][%d]\n", aux->l, aux->c);
        fprintf(f, "[%d][%d]\t", aux->l, aux->c);
        if((++i)%10 == 0)fprintf(f, "\n");
        aux = aux->next;
    }
}

void destroy(Lista *list){
    DeadEndPath *aux = list->first;
    DeadEndPath now;
    while(aux != NULL){
        now = *aux;
        free(aux);
        aux = now.next;
    }
    free(list);
}