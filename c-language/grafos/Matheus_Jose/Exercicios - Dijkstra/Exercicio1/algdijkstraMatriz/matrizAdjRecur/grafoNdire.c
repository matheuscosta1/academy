#include <stdio.h>
#include <stdlib.h>
#include "grafoNdire.h"
#include "fila.h"
#include "limits.h"
// Criação de um Grafo do tipo nao direcionado para Matriz de Adjacências

struct grafo {
    int quantidade_vertices;
    int quantidade_arestas;
    int *grau; //vetor com o grau dos vértices
    int **aresta; //matriz de adjacências
};

Grafo *cria_grafo (int numero_vertices){
    if (numero_vertices <= 0) // testa se o num_vertices é invalido
        return NULL;

    Grafo *G = (Grafo*) (malloc(sizeof(Grafo))); //alocacao

    if (G == NULL) // verifica se foi alocado com sucesso
        return NULL;

    G -> quantidade_vertices = numero_vertices; //preenchee os campos
    G -> quantidade_arestas = 0;

    G -> grau = (int*) calloc (numero_vertices, sizeof(int)); //aloca vetor com o grau

    if (G -> grau == NULL){
        free(G);
        return NULL;
    }

    G -> aresta = (int**) malloc (numero_vertices*sizeof(int*)); //aloca linha matriz adjacência

    if (G -> aresta == NULL){ //verifica se a alocação obteve sucesso
        free (G -> grau);
        free(G);
        return NULL;
    }

    int i, j;

    for (i=0; i < numero_vertices; i++){
        G -> aresta[i] = (int *) calloc (numero_vertices, sizeof(int)); //aloca colunas da matriz adjacência
        if (G -> aresta[i] == NULL){ // verifica sucesso alocacao colunas
            for (j=0; j < i; j++)
                free(G -> aresta[j]);
            free(G -> aresta);
            free(G -> grau);
        }
    }
    return G; // endereço do grafo retornado
}

int insere_aresta (Grafo *G, int vertice1, int vertice2, int peso){
    if (G == NULL|| ((vertice1 < 0 || vertice1 >= G -> quantidade_vertices) || (vertice2 < 0 || vertice2 >= G -> quantidade_vertices ))){ //verifica se o grafo é valido
        return printf("-1");
    }

    if (G -> aresta[vertice1][vertice2] != 0){ // isso verifica se eu já tenho criado alguma aresta (mesma)
        return printf("0");
    }

    (G -> aresta[vertice1][vertice2]) = peso;
    (G -> aresta[vertice2][vertice1]) = peso;
    //printf("%d\n", G->aresta[vertice1][vertice2]);
    (G -> quantidade_arestas)++; // quantidade de ligacoes do grafo
    //printf("%d\n", G->quantidade_arestas);
    (G -> grau[vertice1])++;
    //printf("%d\n", G->grau[vertice1]);
    (G -> grau[vertice2])++;
    //printf("%d\n", G->grau[vertice2]); // o grau do vértice serve para dizer se ele é bidirecionado ou unidirecionado. Exemplo: 1 -> 0 (uni) // 1 -> 0 e 0 -> 1 (bi)

    return 1;
}

int verifica_aresta (Grafo *G, int vertice1, int vertice2){
    if (G == NULL|| ((vertice1 < 0 || vertice1 >= G -> quantidade_vertices) || (vertice2 < 0 || vertice2 >= G -> quantidade_vertices ))) //verifica se o grafo é valido
        return printf("-1");

    if (G -> aresta[vertice1][vertice2] == 0) //verifica se existe aresta entre ambos vertices
        return printf("0");
    else return printf("1");
}

int remove_aresta (Grafo *G, int vertice1, int vertice2){
    if (G == NULL|| ((vertice1 < 0 || vertice1 >= G -> quantidade_vertices) || (vertice2 < 0 || vertice2 >= G -> quantidade_vertices ))) //verifica se o grafo é valido
        return printf("-1");

    if (G -> aresta[vertice1][vertice2] == 0) return printf("0");

    (G -> aresta[vertice1][vertice2]) = 0;
    (G->aresta[vertice2][vertice1]) = 0;
    //printf("%d\n", G->aresta[vertice1][vertice2]);
    (G -> quantidade_arestas)--;
    //printf("%d\n", G->quantidade_arestas);
    (G -> grau[vertice1])--;
     //printf("%d\n", G->grau[vertice1]);
    (G -> grau[vertice2])--;
    //printf("%d\n", G->grau[vertice2]);
    return printf("1");
}

int consulta_aresta (Grafo *G, int vertice1, int vertice2, int *peso){
    if (G == NULL|| ((vertice1 < 0 || vertice1 >= G -> quantidade_vertices) || (vertice2 < 0 || vertice2 >= G -> quantidade_vertices ))) //verifica se o grafo é valido
        return printf("-1");

    if (G -> aresta[vertice1][vertice2] == 0)
        return printf("0");

    G -> aresta[vertice1][vertice2] = peso;

    return printf("1");
}

void libera_grafo(Grafo **G){ // endereço do grafo que quero dar free
    int i;


    for (i=0; i < (*G) -> quantidade_vertices; i++)
        free((*G) -> aresta[i]);
    free((*G) -> aresta);

    free((*G) -> grau);
    free((*G));
    (*G) = NULL;
    printf("\n\n-------------------- Free no Grafo --------------------\n\n");
}

int mostra_adjacentes (Grafo *G, int vertice){
    int i;

    if((G == NULL) || (vertice < 0 || vertice >= G -> quantidade_vertices)) {
       return printf("Grafo inexistente ou vertice invalido");
    }
    else{
    int cont = 0;
        printf("Segue os vertices adjacentes ao vertice %d\n\n", vertice);
        for(i=0; i< G -> quantidade_arestas; i++){
            if(G -> aresta[vertice][i] != 0){
                printf("%d -> %d = %d\n", vertice, i, G->aresta[vertice][i]); //vertice1 = vertice; vertice2 = i; G->aresta[vertice][i] = peso
                cont++;
            }
        }
        if(cont == 0)
        return printf("O vertice %d nao possui vertices adjacentes\n", vertice);
    }
}

int mostra_grafo(Grafo *G){
    int i;

    if (G == NULL){
        return printf("Grafo Inexistente\n");
    }else if (G -> quantidade_arestas == 0){
        return printf("Grafo vazio\n");
    }else {
        for(i=0; i < G -> quantidade_vertices; i++){
            printf("\nVertice %d:\n\n", i);
            mostra_adjacentes(G, i);
            printf("-------------------------------------------------------");
        }
    }
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
    int i=0, cont=0;
    while(G->aresta[u][i] != 0&& G->aresta[u][i] != v){
        i++;
        cont++;
    }
    cont = 0;
    if(G->aresta[u][i] != 0){
        if(d[v] > d[u] + G->grau[G->aresta[u][i]]){
            d[v] = d[u] + G->grau[G->aresta[u][i]];
            p[v] = u;
        }
        cont++;
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
        int j=0;
        int cont=0;
        while(G -> aresta[u][j] !=0){
            relaxa_dijkstra(G, d, p, u, j);
            cont++;
            j++;
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
        int cont=0;
        if (G -> aresta[vertice][i] == NULL && G -> aresta[vertice][i] !=0){
            r[i] = NULL;
            cont++;
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

