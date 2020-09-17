#include <stdlib.h>
#include <stdio.h>
#include "lista.h"
//#define NULL 0

Lista *criarLista() {
   Lista *l = malloc(sizeof(Lista));
   l->primeira = NULL;
   l->ultima = NULL;
   return l;
}

void inserirNoInicio (Lista * l, int i) {
   Celula *c = malloc(sizeof(Celula));
   c->conteudo = i;
   c->prox = l->primeira;
   if (vazia(l))
      l->ultima = c;
   l->primeira = c;
}

void inserirNoFinal (Lista *l, int i) {
   Celula *c = malloc(sizeof(Celula));
   c->conteudo = i;
   c->prox = NULL;
   if (! vazia(l))
      l->ultima->prox = c;
   l->ultima = c;
   if (vazia(l))
      l->primeira = c;
}

void inserirOrdenado  (Lista *l, int i) {
   Celula *aux = l->primeira;
   Celula *c;
   if (aux==NULL)
      inserirNoInicio(l,i);
   else if (aux->prox == NULL || aux->conteudo >i) {
      if (aux->conteudo > i )
         inserirNoInicio(l, i);
      else
         inserirNoFinal(l, i);
   }
   else {
      while (aux->prox != NULL && aux->prox->conteudo < i) {
          aux = aux -> prox;
      }
       c = malloc(sizeof(Celula));
       c->conteudo = i;
       c->prox = aux->prox;
       aux->prox = c;
   }
}


int ultimoElemento (Lista *l, int *resultado) {
    if (! vazia(l)) {
        *resultado = l->ultima->conteudo;
        return 1;
    }
    return 0;
}

int primeiroElemento (Lista *l, int *resultado) {
    if (! vazia(l)) {
        *resultado = l->primeira->conteudo;
        return 1;
    }
    return 0;
}

int vazia (Lista *l) {
   return l->primeira == NULL;
}

Lista* concatena (Lista *l1, Lista *l2) {
    Lista *l = criarLista();

   Celula *aux = l1->primeira;
   while (aux != NULL) {
      inserirNoFinal(l,aux->conteudo);
      aux = aux -> prox;
   }
   aux = l2->primeira;
   while (aux != NULL) {
      inserirNoFinal(l,aux->conteudo);
      aux = aux -> prox;
   }
   return l;
}

int  contaOcorrencias (Lista *l, int num) {
   Celula *aux = l->primeira;
   int nroOcorrencias =0;
   while (aux != NULL) {
      if (num == aux->conteudo)
         nroOcorrencias++;
      aux = aux -> prox;
   }
   return nroOcorrencias;
}

int tamanho (Lista *l) {
    Lista *resto; int tam;
    if (l->primeira == NULL) {
        return 0;
    }
    else {
        resto = (Lista *) malloc(sizeof(Lista));
        resto->primeira = l->primeira->prox;
        //resto->ultima = l->ultima;
        tam = tamanho(resto);
        free(resto);
        return 1 + tam;
    }
}

int retornaN_esimo(Lista *l, int n) {
   Celula *aux = l->primeira;
   int i=0;
   while (aux != NULL) {
      if (i == n)
         return aux->conteudo;
      aux = aux -> prox;
      i++;
   }
   return 0;
}

void imprimir (Lista * l) {
   Celula *aux = l->primeira;
   while (aux != NULL) {
      printf(" %d ", aux->conteudo);
      aux = aux -> prox;
   }
   printf("\n");
}
