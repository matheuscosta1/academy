#include <stdio.h>
#include <stdlib.h>
#include "grafoNdire.h"
#include "fila.h"
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

void busca_largura(Grafo *G, int vertice){
    int visitados[G->quantidade_vertices];
    int i;
    for(i=0; i < G->quantidade_vertices; i++){
        visitados[i] = 0;
    }
    Fila *f = criarFila();
    visitados[vertice] = 1;
    printf("Ordem de visita:\n\n");
    printf("[%d]\t", vertice);
    inserirFinal(f, vertice);
    int cont=0;
    int ultimo;

    while(!vazia(f)){
        int vet = remover(f);
        for(i=0; i<G->quantidade_vertices;i++){
            if(G->aresta[vet][i]!=0  && visitados[i] == 0){
                visitados[i] = 1;
                printf("[%d]\t", i);
                inserirFinal(f, i);
                cont++;
            }
       }
    }
}
