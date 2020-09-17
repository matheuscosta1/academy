#include "grafo_lista.h"


struct grafo_ {
    int n_vertices;
    int n_arestas;
    int * grau;
    int is_digrafo;
    Lista ** aresta; 
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

    grafo->aresta = malloc(n_vertices*sizeof(Lista *));

    if(grafo->aresta == NULL){
        free(grafo->grau); free(grafo);
        return NULL;
    }

    for(i =0; i < n_vertices; i++) grafo->aresta[i]= criar_lista();

    grafo->n_vertices = n_vertices;
    grafo->n_arestas = 0;
    grafo->is_digrafo = is_digrafo;
    return grafo;
}

int inserir_aresta(Grafo *g, int orig, int dest, int peso){
     int aresta_valida = verificar_aresta(g, orig, dest);
    if(aresta_valida != 0) return aresta_valida == 1 ? 0 : -1;

    inserir_final(g->aresta[orig], dest, peso);
    if(!g->is_digrafo) inserir_final(g->aresta[dest], orig, peso);

    g->grau[orig]++;
    g->grau[dest]++;
    g->n_arestas++;
    return 1;
}

int verificar_aresta(Grafo *g, int orig, int dest){
      if(g == NULL) return -1;
    if(g->n_vertices < orig || g->n_vertices < dest || orig < 0 || dest < 0) return 0;
    if(!g->is_digrafo && orig == dest) return -1;

    int existe = contem(g->aresta[orig], dest);
    return existe;
}

int consultar_aresta(Grafo *g, int orig, int dest, int *peso){
    int aresta_valida = verificar_aresta(g, orig, dest);
    if(aresta_valida <= 0) return aresta_valida;

    int p;
    buscar_elemento(g->aresta[orig], dest, &p);
    if(peso != NULL) *peso = p;
    return 1;
}

int remover_aresta(Grafo * g, int orig, int dest){
    int aresta_valida = verificar_aresta(g, orig, dest);
    if(aresta_valida <= 0) return aresta_valida;

    remover_elemento(g->aresta[orig], dest);
    if(!g->is_digrafo) remover_elemento(g->aresta[dest], orig);
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
    printf("| %02d |\t", vertice);
    if(vazia(g->aresta[vertice])) printf("O vertice [%d] não possui adjacentes", vertice);
    else
    mostrar_lista(g->aresta[vertice]);
    printf("\n");
}

void mostrar_grafo(Grafo *g){
     if(g == NULL){
        printf("Grafo inexistente\n");
        return;
    }
    int i, j;
    printf("Vertices\tAdjacentes\n");
    for(i = 0; i < g->n_vertices; i++){
       mostrar_adjacentes(g, i);
    }
}

void liberar_grafo(Grafo ** g){
    int i;
    for(i = 0; i < (*g)->n_vertices; i++) liberar_lista(&((*g)->aresta[i]));
    free((*g)->aresta);
    free((*g)->grau);
    free((*g));
    *g = NULL;
}