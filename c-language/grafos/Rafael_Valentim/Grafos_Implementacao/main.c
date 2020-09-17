#include "grafo.h"

int main(int argc, char const *argv[])
{
    Grafo *grafo = criar_grafo(20, 1);
    int i;

    for(i =0; i<50; i++){
        inserir_aresta(grafo, random()%20, random()%20, random()%100);
    }
  
    mostrar_grafo(grafo);

    consultar_aresta(grafo, 6, 0, &i);
    printf("\nConsultando aresta [6][0]\n%d\n", i);
    printf("Removendo aresta[6][0]...\n");
    remover_aresta(grafo, 6, 0);
    mostrar_grafo(grafo);
    liberar_grafo(&grafo);
    printf("Tentando manipular o grafo apos sua liberação:\n");
    mostrar_grafo(grafo);
    return 0;
}