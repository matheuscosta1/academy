#ifndef LISTA_H_INCLUDED
#define LISTA_H_INCLUDED

typedef struct celula {
   int conteudo;
   struct celula *prox;
} Celula;

typedef struct lista {
   Celula *primeira;
   Celula *ultima;
} Lista;

Lista *criarLista();
int vazia(Lista *l);
int ultimoElemento (Lista *l, int *resultado);
int primeiroElemento (Lista *l, int *resultado);
void inserirNoInicio (Lista * l, int i);
void inserirNoFinal  (Lista *l, int i);
void inserirOrdenado  (Lista *l, int i);

Lista* concatena (Lista *l1, Lista *l2);

int  contaOcorrencias (Lista *l, int num);
int  tamanho(Lista *l);
int retornaN_esimo(Lista *l, int n);
void imprimir (Lista * l);

#endif // LISTA_H_INCLUDED
