#ifndef LABIRINTO_H_INCLUDED
#define LABIRINTO_H_INCLUDED
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#define TOP 0
#define BOTTOM 1
#define RIGHT 2
#define LEFT 3

int hasOneZeroAround(int **matriz, int size, int l, int c);
void printLab(int ** matriz, int s);
int **makeMatrix(int size);
int** makeLab(int size);
void printLabInFile(int **matriz, int s, FILE *f);
void makeOut(int size, int* l, int* c);
void makeWays(int **, int, int, int);
int canMove(int** matriz, int size, int l, int c, int l_saida, int c_saida);
int hasNotPathOut(int** matriz, int size, int l_out, int c_out);

#endif