#include "grafo_matriz.h"

struct grafo_
{
    int * grau;
    int ** arestas;
    int n_arestas;
    int n_vertices;
    int is_digrafo;
};

Grafo * criar_grafo(int n_vertices, int is_digrafo){
    if(n_vertices <= 0) return NULL;
    int i, k;

    Grafo * grafo = malloc(sizeof(struct grafo_));
    if(grafo == NULL) return NULL;

    grafo->grau = calloc(n_vertices, sizeof(int));
    if(grafo->grau == NULL){
        free(grafo);
        return NULL;
    }

    grafo->arestas = malloc(n_vertices*sizeof(int *));
    if(grafo->arestas == NULL){
        free(grafo->grau); free(grafo);
        return NULL;
    }

    for(i=0; i<n_vertices; i++){
        grafo->arestas[i] = calloc(n_vertices, sizeof(int));
        if(grafo->arestas[i] == NULL){
            for(k=0; k<i; k++) free(grafo->arestas[k]);
            free(grafo->grau);
            free(grafo->arestas);
            free(grafo);
            return NULL;
        }
    }

    grafo->n_vertices = n_vertices;
    grafo->n_arestas = 0;
    grafo->is_digrafo = is_digrafo;

    return grafo;
}

int inserir_aresta(Grafo *g, int orig, int dest, int peso){
    if(g == NULL) return -1;
    if(g->n_vertices < orig || g->n_vertices < dest) return -1;
    if(!g->is_digrafo && orig == dest) return -1;

    if(g->arestas[orig][dest] != 0) return 0;

    g->arestas[orig][dest] = peso;
    if(!g->is_digrafo) g->arestas[dest][orig] = peso;

    g->grau[orig]++;
    g->grau[dest]++;
    g->n_arestas++;
    return 1;
}

int verificar_aresta(Grafo *g, int orig, int dest){
    if(g == NULL) return -1;
    if(g->n_vertices < orig || g->n_vertices < dest || orig < 0 || dest < 0) return -1;
    if(!g->is_digrafo && orig == dest) return -1;

    if(g->arestas[orig][dest] == 0) return 0;

    return 1;
}

int consultar_aresta(Grafo *g, int orig, int dest, int *peso){
    int aresta_valida = verificar_aresta(g, orig, dest);
    if(aresta_valida <= 0) return aresta_valida;

    if(peso != NULL) *peso = g->arestas[orig][dest];

    return 1;
}

int remover_aresta(Grafo * g, int orig, int dest){
    int aresta_valida = verificar_aresta(g, orig, dest);
    if(aresta_valida <= 0) return aresta_valida;

    g->arestas[orig][dest] = 0;
    if(!g->is_digrafo) g->arestas[dest][orig] = 0;
    g->grau[orig]--;
    g->grau[dest]--;
    g->n_arestas--;

    return 1;
}

void mostrar_adjacentes(Grafo *g, int vertice){
    if(g == NULL){
        printf("Grafo inexistente\n");
        return;
    }
    if(g->n_vertices < vertice || vertice < 0){
        printf("Vértice inválido\n");
        return;
    }

    int j, aux = 0;
    for(j=0; j<g->n_vertices; j++)
        if(g->arestas[vertice][j] != 0){
            printf("%d -[%d]-> %d\t", vertice, g->arestas[vertice][j], j);
            aux = 1;
        }
    if(aux == 0) printf("O vertice [%d] não possui adjacentes\n", vertice);
}



void dfs(Grafo *g, int vertice){
      int i, j;
      int *visitados = calloc(g->n_vertices, sizeof(int));
      busca_profundidade(g, vertice,visitados, 1);

      printf("Vertices visitados:\n");
      for(i =1; i<g->n_vertices; i++){
        for(j =0; j< g->n_vertices;j++){
            if(visitados[j] == i) printf("%d->", j);
        }
      }
      printf("\n");
}

void dfs_nao_conexo(Grafo *g){
    int i, j;
    int *visitados;
    visitados = calloc(g->n_vertices, sizeof(int));
    for(i =0; i<g->n_vertices; i++)
        if(visitados[i] ==0){
            busca_profundidade(g, i,visitados, 1);
            printf("Vertices visitados:\n");
            for(i =1; i<g->n_vertices; i++){
                for(j =0; j< g->n_vertices;j++){
                    if(visitados[j] == i) printf("%d->", j);
                }
            }
            printf("\n");
        }
}

int busca_profundidade(Grafo *g, int vertice, int * visitados, int pos){
    int i;
    if(visitados == NULL) return -1;
    visitados[vertice] = pos++;
    printf("Vertice atual: %d\n", vertice);
    mostrar_adjacentes(g, vertice);
    for(i=0; i < g->n_vertices; i++){
        if(visitados[i] == 0 && g->arestas[vertice][i] != 0){
            printf("Proximo vertice: %d\n", i);
            busca_profundidade(g, i, visitados, pos);
     }
    }
    return 1;
}

int busca_profundidade_iterativa(Grafo *g,int vertice){
    int i,aux, counter = 1;
    Pilha *pilha = makePilha();
    int * visitados = calloc(g->n_vertices, sizeof(int));

    for(i=0; i<g->n_arestas; i++) if(g->arestas[vertice][i] != 0) push(pilha, i);
    visitados[vertice] = counter++;
    while((aux =pop(pilha)) != INT_MIN){
        if(visitados[aux] == 0){
            visitados[aux] = counter++;
            for(i=0; i<g->n_arestas; i++) if(g->arestas[aux][i] != 0)push(pilha, i);
        }
    }
     printf("Vertices visitados:\n");
      for(i =1; i<g->n_vertices; i++){
        for(aux =0; aux< g->n_vertices;aux++){
            if(visitados[aux] == i) printf("%d->", aux);
        }
      }
      printf("\n");
    return 1;
}

void mostrar_grafo(Grafo *g){
     if(g == NULL){
        printf("Grafo inexistente\n");
        return;
    }
    int i, j;
    printf("Vertices\tAdjacentes\n");
    for(i = 0; i < g->n_vertices; i++){
        printf("| %02d |\t", i);
        for(j =0; j < g->n_vertices; j++)
            if(g->arestas[i][j] != 0) printf(" -[%02d]->%02d", g->arestas[i][j], j);
        printf("\n");
    }
}

void liberar_grafo(Grafo ** g){
    int i;
    for(i = 0; i < (*g)->n_vertices; i++) free((*g)->arestas[i]);
    free((*g)->arestas);
    free((*g)->grau);
    free((*g));
    *g = NULL;
}