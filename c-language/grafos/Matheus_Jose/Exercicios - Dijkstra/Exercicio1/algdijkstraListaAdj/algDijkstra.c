#include <stdio.h>
#include <stdlib.h>
#include "algDijkstra.h"
#include <limits.h>
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

void inicializa_dijkstra (Grafo *G, int *d, int *p, int s){
   //d = distancia; p = predecessores; int s = pontoinicial
    int i;
    for(i=0; i< G->quantidade_vertices; i++){
        d[i] = INT_MAX/2; //divido por 2 porque se somado 1 ao maior inteiro, ele vira negativo
        p[i] = -1;
    }
    d[s] = 0;
}

void relaxa_dijkstra (Grafo *G, int *d, int *p, int u, int v){
    ADJACENCIA *ad = G -> adj[u].cab;
    while(ad && ad->vertice != v){
        ad = ad -> prox;
    }
    if(ad){
        if(d[v] > d[u] + ad->peso){
            d[v] = d[u] + ad->peso;
            p[v] = u;
        }
    }
}

int *disjkstra(Grafo *G, int s){
    int *d = (int*) malloc(G -> quantidade_vertices*sizeof(int));

    int p[G->quantidade_vertices];
    int aberto[G->quantidade_vertices];

    inicializa_dijkstra(G, d, p ,s);
    int i;
    for(i=0; i<G->quantidade_vertices;i++){
        aberto[i] = 1;
    }
    while(existe_aberto(G, aberto)){
        int u = menorDist(G, aberto, d);
        aberto[u] = 0;
        ADJACENCIA *ad = G->adj[u].cab;
        while(ad){
            relaxa_dijkstra(G, d, p, u, ad->vertice);
            ad = ad -> prox;
        }
    }
    return(d);
}

void roda_dijkstra(Grafo *G, int vertice){
    int *r = disjkstra(G, vertice);
    int i;
    printf("-------------------------------------------------------------------------\n\n");
    printf("Menores distancias entre o vertice de origem [%d] e os demais vertices do Grafo\n\n", vertice);
    for(i=0; i<G->quantidade_vertices;i++){
        ADJACENCIA *ad = G -> adj[i].cab;
        if (ad == NULL){
            r[i] = NULL;
            printf("Vertice %d: Impossivel chegar do vertice [%d] ao vertice [%d]\n", i ,vertice, i);
        }

        if(r[i] == NULL) continue;
        printf("Vertice %d: [%d] -> [%d] = [%d]\n", i, vertice, i, r[i]);
    }
    printf("\n-------------------------------------------------------------------------\n");
}
int existe_aberto(Grafo *G, int *aberto){
    int i;
    for(i=0; i<G->quantidade_vertices;i++){
        if(aberto[i]) return 1;
     }
    return 0;
}

int menorDist(Grafo *G, int *aberto, int *d){
    int i;
    for(i=0; i<G->quantidade_vertices; i++){
        if(aberto[i]) break;
    }
    if(i==G->quantidade_vertices) return -1;
    int menor = i;

    for(i=menor+1; i<G->quantidade_vertices;i++){
        if(aberto[i] && d[menor] > d[i]){
            menor=i;
        }
    }
    return menor;
}
