#ifndef FILA_H_INCLUDED
#define FILA_H_INCLUDED

typedef struct item Item;
typedef struct fila Fila;
int remover(Fila *f);
void inserirFinal (Fila *f, int x);
int vazia (Fila *f);
void imprimir(Fila *f);
#endif // FILA_H_INCLUDED
