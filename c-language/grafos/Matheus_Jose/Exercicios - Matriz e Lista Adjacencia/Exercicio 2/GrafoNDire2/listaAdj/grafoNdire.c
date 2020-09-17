#include <stdio.h>
#include <stdlib.h>
#include "grafoNDire.h"

struct no {
    int vertice;
    int peso;
    struct no *prox;
};

typedef struct no No;

struct grafo{
    int quantidade_vertices;
    int quantidade_arestas;
    int *grau_vertices;
    No **aresta; // vetor de endereço para o primeiro nó **poderia ser uma lista... importando-a com um "lista.h"
};

Grafo *cria_grafo (int numero_vertices){
    if (numero_vertices <= 0)
        return NULL;

    Grafo *G = (Grafo*) (malloc(sizeof(Grafo)));

    if (G == NULL)
        return NULL;

    G -> quantidade_vertices = numero_vertices;
    G -> quantidade_arestas = 0;

    G -> grau_vertices = (int*) calloc(numero_vertices,(sizeof(int)));

    if(G -> grau_vertices == NULL){
        free(G);
        return NULL;
    }

    G -> aresta = (No **) malloc(numero_vertices*sizeof(No*));

    if (G -> aresta == NULL){
        free(G -> grau_vertices); //tenho de dar free no grau pois ele pertence à aresta
        free(G);
        return NULL;
    }

    int i, j;

    for (i=0; i < numero_vertices; i++){
        G -> aresta[i] = NULL;
    }

    return G; //retorna o grafo
}

int insere_aresta(Grafo *G, int vertice1, int vertice2, int peso){
	printf("Inserindo vertice [%d]--|%d|-->[%d]\n", vertice1, vertice2, peso);
    if ((G == NULL) || (vertice1 < 0 || vertice2 < 0) || (vertice1 >= G -> quantidade_vertices || vertice2 >= G -> quantidade_vertices))
        return -1;

    if(remove_aresta(G, vertice1, vertice2) == NULL){
        int a = insere_aresta(G, vertice1, vertice2, peso);
    }

    No *aux;

    aux = G->aresta[vertice1];

    while ((aux != NULL) && (aux->vertice != vertice2)){
        aux = aux -> prox;
    }

    No *novo = (No*) malloc(sizeof(No));
    No *novo1 = (No*) malloc(sizeof(No));

    if(novo && novo1 != NULL){
        novo-> vertice = vertice2;
        novo-> peso =  peso;
        novo-> prox = G->aresta[vertice1];
        G->aresta[vertice1] = novo;

        novo1 -> vertice = vertice1;
        novo1 -> peso =  peso;
        novo1 -> prox = G->aresta[vertice2];
        G->aresta[vertice2] = novo1;
    }

    (G -> quantidade_arestas)++;
    printf("Quantidade de arestas:%d\n",G -> quantidade_arestas);
    (G -> grau_vertices[vertice1])++;
    printf("Grau do vertice1:%d\n", G -> grau_vertices[vertice1]);
    (G -> grau_vertices[vertice2])++;
    printf("Grau do vertice2:%d\n", G -> grau_vertices[vertice2]);

    return 1;
}

void mostra_adjacentes(Grafo *G, int vertice){
    if ((G == NULL) || (vertice < 0) || (vertice >= G -> quantidade_vertices)){
        printf("Grafo inexistente ou vertice invalido\n\n");
    }

    No *aux;

    aux = G->aresta[vertice];
    if (aux == NULL){
        printf("O vertice [%d] nao possui vertices adjacentes\n\n", vertice);
    }else{
        printf("Vertices adjacentes ao vertice [%d]\n\n", vertice);
        while(aux != NULL){
                if (aux -> vertice > 10000){ return;
                }
                printf("[%d] -> [%d] = [%d]\n", vertice, aux->vertice, aux->peso);
                aux = aux -> prox;
        }
    }
}

int verifica_aresta(Grafo *G, int vertice1, int vertice2){
    if ((G == NULL) || (vertice1 < 0 || vertice2 < 0) || (vertice1 >= G -> quantidade_vertices || vertice2 >= G -> quantidade_vertices))
        return -1;

    No *aux;

    aux = G->aresta[vertice1];
    while(aux != NULL && aux -> vertice != vertice2){
        aux = aux -> prox;
    }

    if (aux == NULL) return printf("\nAresta %d -> %d nao existe\n", vertice1, vertice2);
    else return printf("\nAresta %d -> %d existe\n", vertice1, vertice2);
}

int remove_aresta(Grafo *G, int vertice1, int vertice2){
    if ((G == NULL) || (vertice1 < 0 || vertice2 < 0) || (vertice1 >= G -> quantidade_vertices || vertice2 >= G -> quantidade_vertices))
        return -1;

    No *aux = (No*) malloc(sizeof(No));
    aux = G -> aresta[vertice1];;
    No *ant;
    ant = NULL;

    while(aux != NULL && aux->vertice != vertice2){
        ant = aux;
        aux = aux -> prox;
    }
    if (aux == NULL)
    {
        return printf("\n");
    }
    if (ant == NULL){
        G->aresta[vertice1] = aux -> prox;
    }else{
        ant = aux -> prox;
    }
    free(aux); printf("\n\nFree realizado com sucesso!!!\n");
    (G->quantidade_arestas)--;
    (G->grau_vertices[vertice1])--;
    (G->grau_vertices[vertice2])--;

    return 1;
}

int consulta_aresta(Grafo *G, int vertice1, int vertice2, int *peso){
    printf("\nConsulta aresta [%d] -> [%d] = [%d]\n", vertice1, vertice2, peso);
    if ((G == NULL) || (vertice1 < 0 || vertice2 < 0) || (vertice1 >= G -> quantidade_vertices || vertice2 >= G -> quantidade_vertices))
        return -1;

    No *aux = G -> aresta[vertice1];
    while ( aux != NULL && aux -> vertice != vertice2){
        aux = aux -> prox;
    }

    if (aux == NULL) return 0;

    peso = aux -> peso;
    return printf("\nAresta [%d] -> [%d] = [%d] existe no grafo!!\n", vertice1, vertice2, peso);
}

libera_grafo(Grafo **G){
    int i;
    No *aux;
    No *aux2;
    for(i=0; i < (*G) -> quantidade_vertices; i++){
        aux = (*G) -> aresta[i];
        while(aux != NULL){
            aux2 = aux;
            aux = aux -> prox;
            free(aux2);
        }
    }
    free((*G) -> aresta);
    free((*G) -> grau_vertices);
    free((*G));
    (*G) = NULL;

    printf("\n\nGrafo liberado com sucesso!!!\n\n");
    printf("-----------------------------------------------");
}

mostra_grafo(Grafo *G){
    printf("\n----------------- Mostra grafo -----------------\n\n");
    if(G == NULL)
        printf("Grafo inexistente\n\n");

    if (G -> quantidade_arestas == 0)
        printf("Grafo vazio");
    else{
        int i;
        for (i=0; i < G-> quantidade_vertices; i++){
            mostra_adjacentes(G, i); printf("\n");
        }
    }
    printf("-----------------------------------------------");
}

