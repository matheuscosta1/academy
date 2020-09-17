#ifndef GRAFO_H
#define GRAFO_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include "utils.h"
#include "lista.h"

typedef struct grafo_ Grafo;
typedef struct pop_ PoP;

Grafo * criar_grafo(int vertices);
int criar_vertice(Grafo *g, int pos, char *nome, float lat, float lng);
int inserir_aresta(Grafo *, int origem, int destino, int peso);
int num_vertices(Grafo *g);
int grau_vertice(Grafo *g, int v);
int eh_adjacente(Grafo *g, int orig, int dest);
int verificar_aresta(Grafo *, int origem, int destino);
int consultar_aresta(Grafo*, int origem, int destino, int * peso, double *dist);
int remover_aresta(Grafo *, int origem, int destino);
void mostrar_adjacentes(Grafo *, int vertice);
void mostrar_grafo(Grafo *);
void liberar_grafo(Grafo **);

void menor_transferencia(Grafo *g, int orig, int dest, double size);
void dijkstra(Grafo *g, int orig, int dest, double *dist, int * ancestrais);
void mostrar_caminho(Grafo *g, int orig, int dest, int *ancestrais, double arq_size);
double tempo_de_envio(Grafo *g, int orig, int dest, int *rota, double arq_size);
void cobertura_aux(Grafo *g, int orig, int *pesos, int max);
void cobertura(Grafo *g, int orig, int max_p);
void pops_alcancados(Grafo *g, int orig, double max, double size);
void pops_alcancados_aux(Grafo *g, int orig, float *pesos, double max, double size);
#endif