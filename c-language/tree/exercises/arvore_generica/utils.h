#ifndef UTILS_H_INCLUDED
#define UTILS_H_INCLUDED
#define LINE 66
#include <string.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

void printInBlock(char * text, int b_line);
void printInBlockN(int n,char *text, int b_line);
double distancia(float lat1, float lng1, float lat2, float lng2);
#endif
