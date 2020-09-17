#include <stdio.h>
#include <stdlib.h>
#include "buscaLargura.h"
#include "fila.h"
#define BRANCO 0
#define AMARELO 1
#define VERMELHO 2
#define true 1
#define false 0

typedef struct adjacencia { //no == adjacencia
    int vertice;
    int peso;
    struct adjacencia *prox;
}ADJACENCIA;

typedef struct vertice {
    ADJACENCIA *cab;
} VERTICE;

typedef struct grafo{
    int quantidade_vertices;
    int quantidade_arestas;
    int *grau;
    Vertice *adj; // vetor de endereço para o primeiro nó **poderia ser uma lista... importando-a com um "lista.h"
}Grafo;

Grafo *cria_grafo (int numero_vertices){
    if (numero_vertices <= 0)
        return NULL;

    Grafo *G = (Grafo*) (malloc(sizeof(Grafo)));

    if (G == NULL)
        return NULL;

    G -> quantidade_vertices = numero_vertices;
    G -> quantidade_arestas = 0;

    G -> grau = (int *) calloc(numero_vertices,sizeof(int));
    if(G->grau == NULL){
        free(G);
        return NULL;
    }

    G -> adj = (VERTICE*) malloc(numero_vertices*sizeof(VERTICE)); //arranjo com vertices que contem adjacencias

    if (G->adj == NULL){
        free(G->grau);
        free(G);
        return NULL;
    }

    int i;
    for (i = 0; i< numero_vertices; i++){
        G -> adj[i].cab = NULL; //grafo sem aresta
    }
    return G;
}

ADJACENCIA *criaAdjacencia (int v, int peso){
    ADJACENCIA *temp = (ADJACENCIA *) malloc (sizeof(ADJACENCIA));

    temp -> vertice = v;
    temp -> peso = peso;
    temp -> prox = NULL;

    return temp;
}

int insere_aresta(Grafo *G, int vertice1, int vertice2, int peso){
	printf("Inserindo vertice [%d]--|%d|-->[%d]\n", vertice1, vertice2, peso);
    if ((G == NULL) || (vertice1 < 0 || vertice2 < 0) || (vertice1 >= G -> quantidade_vertices || vertice2 >= G -> quantidade_vertices))
        return false;

    ADJACENCIA *novo = criaAdjacencia(vertice2, peso);
    ADJACENCIA *novo1 = criaAdjacencia(vertice1, peso);

    novo -> prox = G -> adj[vertice1].cab;
    G -> adj[vertice1].cab = novo;

    novo1 -> prox = G -> adj[vertice2].cab;
    G -> adj[vertice2].cab = novo1;

    G -> quantidade_arestas++;
    (G -> grau[vertice1])++;
    (G -> grau[vertice2])++;
    //printf("Grau vertice1 %d\n", G -> adj[vertice1].cab->grau);
    //(G -> adj[vertice2])++;
    printf("\nGrau vertice1 [%d] = %d\n",vertice1, G -> grau[vertice1]);
    printf("Grau vertice2 [%d] = %d\n",vertice2,G -> grau[vertice2]);
    printf("\n");
    return true;

}
void imprime(Grafo *G){
    if (G == NULL)
        printf("\nGrafo inexistente\n\n");


    printf("\nVertices: %d. Arestas: %d.\n\n", G->quantidade_vertices, G->quantidade_arestas);
    printf("Vertices adjacentes aos vertices do grafo\n\n");
    int i;

    for(i=0; i<G->quantidade_vertices;i++){
        ADJACENCIA *ad = G -> adj[i].cab;
        if (ad == NULL)
            printf("\nO vertice [%d] nao possui vertices adjacentes\n", i);
        while(ad != NULL){
            if(ad -> vertice > 10000){
                    break;
            }
            printf("Vertice %d: [%d] -> [%d] = [%d]",i, i, ad->vertice, ad->peso);
            printf("\n----------------------------\n");
            ad = ad -> prox;
        }
        printf("\n");
    }
}


int verifica_aresta(Grafo *G, int vertice1, int vertice2){
    if ((G == NULL) || (vertice1 < 0 || vertice2 < 0) || (vertice1 >= G -> quantidade_vertices || vertice2 >= G -> quantidade_vertices))
        return -1;

    ADJACENCIA *aux;

    aux = G->adj[vertice1].cab;
    while(aux != NULL && aux -> vertice != vertice2){
        if(aux -> vertice > 10000) break;
        aux = aux -> prox;
    }

    if (aux == NULL || aux -> vertice > 10000 || aux -> vertice < 0) return printf("\nAresta %d -> %d nao existe\n", vertice1, vertice2);
    else return printf("\nAresta %d -> %d existe\n", vertice1, vertice2);
}

int remover_aresta(Grafo *G, int vertice1, int vertice2){
    if ((G == NULL) || (vertice1 < 0 || vertice2 < 0) || (vertice1 >= G -> quantidade_vertices || vertice2 >= G -> quantidade_vertices))
        return -1;


    ADJACENCIA *aux = G -> adj[vertice1].cab;
    ADJACENCIA *ant = NULL;


    while(aux != NULL){
        if((G->adj[vertice1].cab == vertice1 || vertice2) || (G->adj[vertice2].cab == vertice2 && vertice1)){
            if (ant != NULL){
                ant -> prox = aux->prox;
            }else{
                G->adj[vertice1].cab = NULL;
                G->adj[vertice2].cab = NULL;
            }
            free(aux);
            printf("\nGrau do vertice a remover\n[%d] = %d\n[%d] = %d\n",vertice1, G -> grau[vertice1], vertice2, G->grau[vertice2]);
            (G->grau[vertice1])--;
            (G->grau[vertice2])--;
            (G->quantidade_arestas)--;
            printf("\nRemovendo vertice [%d] -> [%d]\n\n", vertice1, vertice2);
            printf("Grau vertice1 [%d] = %d\n",vertice1,G -> grau[vertice1]);
            printf("Grau vertice2 [%d] = %d\n",vertice2,G -> grau[vertice2]);

            return true;
        }
        ant = aux;
        aux = aux -> prox;
   }
}

int consulta_aresta(Grafo *G, int vertice1, int vertice2, int *peso){
    printf("\nConsulta aresta [%d] -> [%d] = [%d]\n", vertice1, vertice2, peso);
    if ((G == NULL) || (vertice1 < 0 || vertice2 < 0) || (vertice1 >= G -> quantidade_vertices || vertice2 >= G -> quantidade_vertices))
        return -1;

    ADJACENCIA *aux = G -> adj[vertice1].cab;
    while ( aux != NULL && aux -> vertice != vertice2){
        aux = aux -> prox;
    }

    if (aux == NULL) return 0;

    peso = aux -> peso;
    return printf("\nAresta [%d] -> [%d] = [%d] existe no grafo!!\n", vertice1, vertice2, peso);
}

int libera_grafo(Grafo **G){
    int i;
    ADJACENCIA *aux;
    ADJACENCIA *aux2;
    for(i=0; i < (*G) -> quantidade_vertices; i++){
        aux = (*G) -> adj[i].cab;
        while(aux != NULL){
            aux2 = aux;
            aux = aux -> prox;
            free(aux2);
        }
    }
    free((*G) -> adj);

    free((*G));
    (*G) = NULL;

    printf("\n\nGrafo liberado com sucesso!!!\n\n");
    printf("-----------------------------------------------");
}

void busca_largura(Grafo *G, int vertice){
    int visitados[G->quantidade_vertices];
    int i;
    for(i=0; i < G->quantidade_vertices; i++){
        visitados[i] = 0;
    }
    Fila *f = criarFila();
    visitados[vertice] = 1;
    printf("[%d]\t", vertice);
    inserirFinal(f, vertice);
    ADJACENCIA *aux;
    while(!vazia(f)){
        int vet = remover(f);
        aux = G -> adj[vet].cab;
        while(aux){
            if(visitados[aux -> vertice] == 0){
                visitados[aux->vertice] = 1;
                printf("[%d]\t", aux->vertice);
                inserirFinal(f, aux->vertice);
            }
            aux = aux -> prox;
       }
    }
}


