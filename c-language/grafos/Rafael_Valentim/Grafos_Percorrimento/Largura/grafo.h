#ifndef GRAFO_H
#define GRAFO_H

#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include "lista.h"
#include "fila.h"
typedef struct grafo_ Grafo;


Grafo * criar_grafo(int vertices, int is_digrafo);
int inserir_aresta(Grafo *, int origem, int destino, int peso);
int verificar_aresta(Grafo *, int origem, int destino);
int consultar_aresta(Grafo*, int origem, int destino, int * peso);
int remover_aresta(Grafo *, int origem, int destino);
void mostrar_adjacentes(Grafo *, int vertice);
void disparar_busca(Grafo *, int);
int busca_largura_naoconexa(Grafo *g);
int busca_largura(Grafo *, int);
int busca_largura_rec(Grafo *g, int vertice, int *visitados, int pos);
//int busca_largura_iterativa(Grafo *g, int);
void mostrar_grafo(Grafo *);
void liberar_grafo(Grafo **);

#endif