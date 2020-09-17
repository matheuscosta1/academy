#include<stdio.h>
#include <stdlib.h>
#include "constroi_grafo.h"

Grafo * constroi_grafo(char *path)
{
    FILE* arq;
    char linha[50];
    int linhas = 0;

    arq = fopen(path, "r");

    if (arq == NULL)return 0;

    while (fgets(linha, 50, arq) != NULL) {
        /**Ignorar linhas vazias ou incorretas**/
        if(strlen(linha) > 5)linhas++;
    }

    fclose(arq);
    return criar_grafo(linhas);
}

int constroi_vertices(Grafo* g, char *path)
{

    FILE* arq;
    char nome[20];
    float latitude, longitude;
    int id;

    arq = fopen(path, "r");
    if (arq == NULL)return 0;

    while (fscanf(arq, "%d %s %f %f", &id, nome, &latitude, &longitude) != EOF) {
        criar_vertice(g, id, nome, latitude, longitude);
    }
    fclose(arq);
    return 1;
}

int constroi_arestas(Grafo*g, char * path)
{
    FILE* arq;
    int orig, dest, peso;

    arq = fopen(path, "r");

    if (arq == NULL)return 0;

    while (fscanf(arq, "%d %d %d", &orig, &dest, &peso) != EOF)
    {
        inserir_aresta(g, orig, dest, peso);
    }

    fclose(arq);
    return 1;

}
