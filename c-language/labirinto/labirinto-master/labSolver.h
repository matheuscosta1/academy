#ifndef LAB_SOLVER_H_INCLUDED
#define LAB_SOLVER_H_INCLUDED

#include "labirinto.h"
#include "pilha.h"
#include "lista.h"
#include <math.h>

Pilha *solveLab(int ** lab, int size);
int numZerosAround(int **matriz, int size, int c, int l);
int chegou(int **matriz, int size, int l, int c);
void findNextPath(Pilha *p, int **matriz, int size, Lista* deadEndPaths,  int l, int c, int *l_next, int *c_next, FILE *f);
void printCorrectPath(int **lab, int size, Pilha *p, FILE *f);
#endif