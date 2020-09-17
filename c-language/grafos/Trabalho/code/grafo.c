#include "grafo.h"


struct grafo_ {
    int n_vertices;
    int n_arestas;
    PoP ** pontos;
    Lista ** arestas;
};

struct pop_ {
    char * nome;
    int grau;
    float lat;
    float lng;
};

Grafo * criar_grafo(int n_vertices) {
    if (n_vertices <= 0) return NULL;
    int i, k;

    Grafo * grafo = malloc(sizeof(struct grafo_));
    if (grafo == NULL) return NULL;

    grafo->pontos = (PoP**) malloc(n_vertices * sizeof(PoP*));
    if (grafo->pontos == NULL) {
        free(grafo);
        return NULL;
    }

    for (i = 0; i < n_vertices; i++) {
        grafo->pontos[i] = NULL;
    }

    grafo->arestas = malloc(n_vertices * sizeof(Lista *));

    if (grafo->arestas == NULL) {
        free(grafo->pontos); free(grafo);
        return NULL;
    }

    for (i = 0; i < n_vertices; i++) grafo->arestas[i] = criar_lista();

    grafo->n_vertices = n_vertices;
    grafo->n_arestas = 0;

    return grafo;
}

int criar_vertice(Grafo *g, int pos, char *nome, float lat, float lng) {
    PoP * pop = malloc(sizeof(PoP));
    pop->lat = lat;
    pop->lng = lng;
    pop->grau = 0;
    pop->nome = malloc(sizeof(nome));
    strcpy(pop->nome, nome);
    g->pontos[pos] = (PoP*) pop;
}

int inserir_aresta(Grafo *g, int orig, int dest, int capacidade) {
    int aresta_valida = verificar_aresta(g, orig, dest);
    if (aresta_valida != 0) return aresta_valida == 1 ? 0 : -1;

    double dist = distancia(g->pontos[orig]->lat, g->pontos[orig]->lng,
                            g->pontos[dest]->lat, g->pontos[dest]->lng);
    inserir_inicio(g->arestas[orig], dest, capacidade, dist);
    inserir_inicio(g->arestas[dest], orig, capacidade, dist);

    printf("Distancia %s a %s %.10lf\n", g->pontos[orig]->nome, g->pontos[dest]->nome, dist);
    g->pontos[orig]->grau++;
    g->pontos[dest]->grau++;
    g->n_arestas++;

    return 1;
}

int verificar_aresta(Grafo *g, int orig, int dest) {
    if (g == NULL) return -1;
    if (g->n_vertices < orig || g->n_vertices < dest || orig < 0 || dest < 0 || orig == dest) return -1;
    if (g->pontos[orig] == NULL || g->pontos[dest] == NULL) return -1;

    int existe = contem(g->arestas[orig], dest);

    return existe;
}

int num_vertices(Grafo *g) {
    if (g != NULL) return g->n_vertices;
    else return -1;
}

int grau_vertice(Grafo *g, int v) {

    if (g != NULL)
        if (g->pontos[v] != NULL || g->n_vertices > v)
            return g->pontos[v]->grau;

    return -1;
}

int eh_adjacente(Grafo *g, int orig, int dest) {
    int aresta_valida = verificar_aresta(g, orig, dest);
    if (aresta_valida <= 0) return 0;

    return contem(g->arestas[orig], dest);
}

int consultar_aresta(Grafo *g, int orig, int dest, int *capacidade, double *distancia) {
    int aresta_valida = verificar_aresta(g, orig, dest);
    if (aresta_valida <= 0) return aresta_valida;

    int p;
    double d;

    buscar_elemento(g->arestas[orig], dest, &p, &d);

    if (capacidade != NULL) *capacidade = p;
    if(distancia != NULL) *distancia =  d;
    return 1;
}

int remover_aresta(Grafo * g, int orig, int dest) {
    int aresta_valida = verificar_aresta(g, orig, dest);
    if (aresta_valida <= 0) return aresta_valida;

    remover_elemento(g->arestas[orig], dest);
    remover_elemento(g->arestas[dest], orig);

    g->pontos[orig]->grau--;
    g->pontos[dest]->grau--;
    g->n_arestas--;

    return 1;
}

void mostrar_adjacentes(Grafo *g, int vertice) {
    if (g == NULL) {
        printf("Grafo inexistente\n");
        return;
    }
    if (g->n_vertices < vertice || vertice < 0) {
        printf("Vértice inválido\n");
        return;
    }
    printf("| %02d |\t", vertice);
    if (vazia(g->arestas[vertice])) printf("O vertice [%d] não possui adjacentes", vertice);
    else
        mostrar_lista(g->arestas[vertice]);
    printf("\n");
}

void mostrar_grafo(Grafo *g) {
    if (g == NULL) {
        printf("Grafo inexistente\n");
        return;
    }
    int i, j;
    printf("Vertices\tAdjacentes\n");
    for (i = 0; i < g->n_vertices; i++) {
        mostrar_adjacentes(g, i);
    }
}

void menor_transferencia(Grafo *g, int orig, int dest, double size) {
    if (g != NULL) {
        int  * rota = calloc(g->n_vertices, sizeof(int));
        double * menor_caminho;
        dijkstra(g, orig, dest, menor_caminho, rota);
        printf("\nCaminho que o caminho percorrerá:\n");
        mostrar_caminho(g, orig, dest, rota, size);
        double t = tempo_de_envio(g, orig, dest, rota, size);
        printf("\nO tempo para o envio será de %.3lfs\n", t);
    }
}

double tempo_de_envio(Grafo *g, int orig, int dest, int *rota, double arq_size){
    if(orig == dest) return 0;
    int cap;
    consultar_aresta(g, dest, rota[dest], &cap, NULL);
    return (arq_size/cap) + tempo_de_envio(g, orig, rota[dest],rota, arq_size);
}

void dijkstra(Grafo *g, int orig, int dest, double *dist, int * ancestrais) {
    if (g == NULL)return;

    int  cap, i, j, k, sucesso, aux, n_vertices = g->n_vertices;
    double d, d_aux;


    int * visitados = calloc(n_vertices , sizeof(int));
    dist = malloc(g->n_vertices * sizeof(double));

    for (i = 0 ; i < n_vertices; i++) ancestrais[i] = -1;


    for (i = 0; i < n_vertices; i++)dist[i] = INT_MAX;

    visitados[orig] = 1;

    for (i = 0; i < list_size(g->arestas[i]); i++) {
            get_elemento(g->arestas[orig], i, &j, &cap, &d);
            dist[j] = (1.0/cap)*d;
            ancestrais[j] = orig;
    }

    aux = orig;

    for ( i = 0; i < n_vertices-1; i++) {

        for (j = 0; j < n_vertices; j++)
            if (visitados[j] == 0 && dist[aux] >= dist[j])aux = j;

        visitados[aux] = 1;
        for (j = 0; j < list_size(g->arestas[aux]); j++) {
            sucesso = get_elemento(g->arestas[aux], j, &k, &cap, &d);
            if (sucesso && visitados[k] == 0) {
                d_aux = dist[aux] + (1.0/cap)*d;
                if (d_aux < dist[k]) {
                    dist[k] = d_aux;
                    ancestrais[k] = aux;
                }
            }
        }

        if(aux == dest)break;
        aux = orig;
    }

}

void mostrar_caminho(Grafo *g, int orig, int dest, int *ancestrais, double arq_size) {
    if (orig == dest)
        printf("%s", g->pontos[orig]->nome);
    else if (ancestrais[dest] == -1)
        printf("Impossível enviar de %s para %s\n", g->pontos[orig]->nome, g->pontos[dest]->nome);
    else {
        mostrar_caminho(g, orig, ancestrais[dest], ancestrais, arq_size);
        printf("->%s ", g->pontos[dest]->nome);
    }
}

void cobertura(Grafo *g, int orig, int max_p){
    int * pesos = calloc(g->n_vertices, sizeof(int));
    pesos[orig] = -1;
    printf("Cobertura de raio %d pontos a partir de %s:\n", max_p, g->pontos[orig]->nome);
    cobertura_aux(g, orig, pesos, max_p);
    int i;
    for(i=0; i<g->n_vertices; i++)if(pesos[i] > 0)printf("%s; ", g->pontos[i]->nome);
    printf("\n");
}

void cobertura_aux(Grafo *g, int orig, int *pesos, int max){
    if(max == 0)return;
    int i;
    int vertice, suc;
    for(i=0; i < g->n_vertices; i++){
        suc = get_elemento(g->arestas[orig], i, &vertice, NULL, NULL);
        if(suc){
            pesos[vertice] = 1;
            cobertura_aux(g, vertice, pesos, max-1);
        }
    }

}

double tempo_envio(Grafo *g, int orig, int dest, double size) {
    if (g != NULL) {
        int  * rota = calloc(g->n_vertices, sizeof(int));
        double * menor_caminho;
        dijkstra(g, orig, dest, menor_caminho, rota);
        double t = tempo_de_envio(g, orig, dest, rota, size);
        return t;
    }
}

void pops_alcancados(Grafo *g, int orig, double max, double size){
    int aux = max;
    float * pesos = calloc(g->n_vertices, sizeof(float));
    pesos[orig] = 0;
    printf("\nPops alcancados no tempo de %ds iniciando de %s:\n", aux, g->pontos[orig]->nome);
    pops_alcancados_aux(g, orig, pesos, max, size);
    int i;
    for(i=0; i<g->n_vertices; i++)if(pesos[i] > 0)  printf("%s; ", g->pontos[i]->nome);
    printf("\n");
}

void pops_alcancados_aux(Grafo *g, int orig, float *pesos, double max, double size){
    int i;
    int vertice, cap, suc;
    for(i=0; i < g->n_vertices; i++){

        suc = get_elemento(g->arestas[orig], i, &vertice, &cap, NULL);

        if(suc && pesos[vertice] < max){
            if(pesos[vertice]+pesos[orig]+(size/cap) <= max){
                pesos[vertice] += pesos[orig]+(size/cap);
                pops_alcancados_aux(g, vertice, pesos, max, size);
            }
        }
    }
}

void liberar_grafo(Grafo ** g) {
    if (*g == NULL) return;
    int i;
    for (i = 0; i < (*g)->n_vertices; i++) liberar_lista(&((*g)->arestas[i]));
    free((*g)->arestas);
    for (i = 0 ; i < (*g)->n_vertices; i++)
        if ((*g)->pontos[i] != NULL) {
            free((*g)->pontos[i]->nome);
            free((*g)->pontos[i]);
        }
    free((*g)->pontos);
    free((*g));
    *g = NULL;
    g = NULL;
}
