#ifndef UTILS_H
#define UTILS_H

#include <stdio.h>
#include <time.h>
#include <stdlib.h>

void printVetor(char *, int *, int);
void vetor_crescente(int *, int, int);
void vetor_decrescente(int *, int, int);
void vetor_aleatorio(int *, int, int);
int toInt(char *);
void test_rapida(void (*f)(int *, int, int), int*, int);
void test_normal(void (*f)(int *, int), int*, int);
#endif