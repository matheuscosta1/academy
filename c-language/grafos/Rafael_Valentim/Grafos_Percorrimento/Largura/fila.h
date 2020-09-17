#ifndef FILA_H
#define FILA_H
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>

#define isQueueEmpty(f) (f->first == NULL)
typedef struct fila_ Fila;
typedef struct vertice_ Vertice;

Fila *makeFila();
int enqueue(Fila *f, int);
int dequeue_asint(Fila *f);
Vertice * dequeue(Fila *f);
void print_fila(Fila *f);
#endif //FILA_H
