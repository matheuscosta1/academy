#include "grafo_matriz.h"

int main(int argc, char const *argv[])
{
    Grafo *grafo = criar_grafo(10, 0);

    inserir_aresta(grafo, 1, 2, 1);
    inserir_aresta(grafo, 1, 3, 1);
    inserir_aresta(grafo, 2, 4, 1);
    inserir_aresta(grafo, 2, 5, 1);
    inserir_aresta(grafo, 3, 4, 1);
    inserir_aresta(grafo, 4, 6, 1);
    inserir_aresta(grafo, 6, 7, 1);
    inserir_aresta(grafo, 7, 8, 1);
    inserir_aresta(grafo, 6, 8, 1);
 
    mostrar_grafo(grafo);

    /*printf("Busca em largura recursiva:\n");
    disparar_busca(grafo, 0);
    printf("\nBusca em largura iterativa\n");*/
    busca_largura(grafo, 1);
    liberar_grafo(&grafo);
    return 0;
}