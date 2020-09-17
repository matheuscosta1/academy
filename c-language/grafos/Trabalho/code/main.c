#include "constroi_grafo.h"
#include "utils.h"

void showMenu(int *);
void handleOption(Grafo *, int);
void carregarArestas(Grafo *);
void verVertice(Grafo *);
void verGrauVertice(Grafo *);
void verAdjacencias(Grafo *);
void verNVertices(Grafo *);
void calcularMelhorRota(Grafo *);
void verPoPAlcancados(Grafo *);
void verCobertura(Grafo *);
void liberarGrafo(Grafo *);

int main(int argc, char const *argv[])
{
    int op;
    Grafo *grafo = NULL;

    do {
        showMenu(&op);
        if (op == 1) {
            char path[100];
            int sucesso;

            printInBlock("01. Criar Grafo a partir de um arquivo", 1);
            printf("Digite o caminho do arquivo(vertices.txt): ");

            setbuf(stdin, NULL);
            scanf("%[^\n]s", path);

            if (strcmp(path, "\n")) strcpy(path, "vertices.txt");
            grafo = constroi_grafo(path);
            if (grafo != NULL) {
                sucesso = constroi_vertices(grafo, path);
                if (sucesso)printf("Grafo criado com sucesso!\n");
                else printf("Não foi possivel criar o grafo.\n");
            } else printf("Não foi possivel criar o grafo.\n");
        }
        
        if (op != 11) {
            handleOption(grafo, op);
            printf("Pressione qualquer tecla para continuar...");
            setbuf(stdin, NULL);
            getchar();
        }
    } while (op != 11);

    liberar_grafo(&grafo);
    return 0;
}

void showMenu(int * op) {
    printInBlock("Menu", 0);
    printInBlockN( 1, "Criar Grafo a partir de um arquivo", 0);
    printInBlockN( 2, "Carregar arestas a partir de um arquivo", 0);
    printInBlockN( 3, "Ver numero de vertices", 0);
    printInBlockN( 4, "Ver grau de um vertice", 0);
    printInBlockN( 5, "Ver adjacencias de um vertice", 0);
    printInBlockN( 6, "Enviar arquivo", 0);
    printInBlockN( 7, "Ver alcance por tempo", 0);
    printInBlockN( 8, "Ver cobertura", 0);
    printInBlockN( 9, "Mostrar grafo", 0);
    printInBlockN(10, "Limpar grafo", 0);
    printInBlockN(11, "Sair", 1);
    
    printf("Digite a opção desejada: ");
    setbuf(stdin, NULL);
    scanf("%d", op);
    printf("\n");
}

void handleOption(Grafo *g, int op) {
    if (op != 1 && g == NULL) printf("O grafo não existe.\n");
    else
        switch (op) {
        // case 1: carregarGrafo(g); break;
        case 2: carregarArestas(g); break;
        case 3: verVertice(g); break;
        case 4: verGrauVertice(g); break;
        case 5: verAdjacencias(g); break;
        case 6: calcularMelhorRota(g); break;
        case 7: verPoPAlcancados(g); break;
        case 8: verCobertura(g); break;
        case 9: mostrar_grafo(g); break;
        case 10: liberarGrafo(g); break;
        }
}


void carregarArestas(Grafo *g) {
    char path[100];
    int sucesso;

    printInBlock("02. Carregar arestas a partir de um arquivo", 1);
    printf("Digite o caminho do arquivo(arestas.txt): ");

    setbuf(stdin, NULL);
    scanf("%[^\n]s", path);

    if (strcmp(path, "\n")) strcpy(path, "arestas.txt");

    sucesso = constroi_arestas(g, path);

    if (sucesso) printf("Arestas criadas com sucesso!\n");
    else printf("Erro ao criar as arestas.\n");
}

void verVertice(Grafo *g) {
    printInBlock("03. Ver numero de vertices", 1);
    printf("O grafo possui %d vertices\n", num_vertices(g));
}

void verGrauVertice(Grafo *g) {
    int ver;

    printInBlock("04. Ver grau de um vertice", 1);
    printf("Digite o identificador do vertice: ");

    setbuf(stdin, NULL);
    scanf("%d", &ver);

    int grau = grau_vertice(g, ver);

    if (grau == -1)
        printf("Erro, não foi possivel identificar o vertice\n");
    else
        printf("O vertice possui grau %d.\n", grau);
}

void verAdjacencias(Grafo *g) {
    int ver;

    printInBlock("05.Ver adjacencias de um vertice", 1);
    printf("Identificador do vertice: ");

    setbuf(stdin, NULL);
    scanf("%d", &ver);

    mostrar_adjacentes(g, ver);
}

void calcularMelhorRota(Grafo *g) {
    printInBlock("06. Calcular melhor rota de dados entre dois PoPs", 1);
    int orig, dest;
    double arq_size;

    printf("Identificador do vertice de origem: ");
    scanf("%d", &orig);
    printf("Identificador do vertice de destino: ");
    scanf("%d", &dest);
    printf("Digite  o tamanho do arquivo(MB): ");
    scanf("%lf", &arq_size);

    menor_transferencia(g, orig, dest, arq_size);
}

void verPoPAlcancados(Grafo *g) {
    printInBlock("07. Ver PoPs alcancados ao enviar arquivo em funcao de tempo", 1);
    int vertice, max_p, arq;

    printf("Digite o identificador do PoP de origem: ");
    setbuf(stdin, NULL);
    scanf("%d", &vertice);
    printf("Dite a quantidade de tempo (segundos): ");
    scanf("%d", &max_p);
    
    printf("Digite o tamanho do arquivo(MB): ");
    scanf("%d", &arq);
    pops_alcancados(g, vertice, max_p, arq);
}

void verCobertura(Grafo *g) {
    printInBlock("08. Ver cobertura em funcao de PoPs", 1);
    
    int vertice, max_p;

    printf("Digite o identificador do PoP de origem: ");
    setbuf(stdin, NULL);
    scanf("%d", &vertice);
    printf("Dite a quantidade de pontos para cobrir: ");
    scanf("%d", &max_p);

    cobertura(g, vertice, max_p);
}

void liberarGrafo(Grafo *g) {
    char o;
    printf("Limpar grafo?(S/N)");
    setbuf(stdin, NULL);
    scanf("%c", &o);
    if (o == 'S' || o == 's') {
        liberar_grafo(&g);
        printf("Grafo liberado com sucesso!\n");
    }
}