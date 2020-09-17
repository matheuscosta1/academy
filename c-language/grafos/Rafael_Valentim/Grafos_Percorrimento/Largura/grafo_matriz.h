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
int busca_largura(Grafo *g, int vertice);
void mostrar_grafo(Grafo *);
void liberar_grafo(Grafo **);
#endif