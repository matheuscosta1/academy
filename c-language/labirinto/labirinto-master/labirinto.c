#include "labirinto.h"


//Define condições globais para a construção do Labrinto
int **makeLab(int size) {
    int l_out, c_out;
    srand(time(NULL));
    int **matriz = makeMatrix(size);
    makeOut(size, &l_out, &c_out);
    matriz[l_out][c_out] = 2;
    matriz[0][0] = 0;
    makeWays(matriz, size, l_out, c_out);
    printLab(matriz, size);
    return matriz;
}

/*
 * Verifica os pontos ao redor do atual, garantindo sua existência ,
 * a presença de um único zero e, caso existir uma saída ao seu redor,
 * se já existe um caminho correto.
 */
int canMove(int **matriz, int size, int l, int c, int l_out, int c_out) {
    int i = 0;

    if (!hasOneZeroAround(matriz, size, l, c)) return 0;
    if (l == l_out && c == c_out) return 0;
    if (!hasNotPathOut(matriz, size, l_out, c_out)) {
        int next = l + 1;
        if (next < size) if (matriz[next][c] == 2) return 0;
        next = l - 1;
        if (next >= 0) if (matriz[next][c] == 2) return 0;
        next = c + 1;
        if (next < size) if (matriz[l][next] == 2) return 0;
        next = c - 1;
        if (next >= 0) if (matriz[l][next] == 2) return 0;
    }
    return 1;
}

/*
 * Cria pontos aleatórios na matriz
 * onde cada ponto é precedido por outro que já faz parte do caminho.
 *
 * A capacidade de mover é determinada pela função canMove.
 *
 * Critério de parada e incremento baseado na proporção da dimensão da matriz
 * afim de preencher todos espaços nos quais possam ser realizados movimentos.
 *
 * Condição hasNotPathOut garante que o loop só será encerrado após ter pelo menos um caminho que leve à saída.
 */
void makeWays(int **matriz, int size, int l_out, int c_out) {
    int l, c;
    float counter = 0;

    do {
        c = rand() % size;
        l = rand() % size;
        if (canMove(matriz, size, l, c, l_out, c_out)) {
            matriz[l][c] = 0;
        } else {
            counter += size > 20 ? size : size >= 10 ? size / 10 : size / 2;
        }
    } while (counter < pow(size, size > 50 ? 4 : 5) || hasNotPathOut(matriz, size, l_out, c_out));
}


//Retorna se ao redor do ponto [l][c] existe 0, isto é, uma saída
int hasNotPathOut(int **matriz, int size, int l, int c) {
    int next = l + 1;
    //Quantidade de zeros  ao redor
    int zeros = 0;
    if (next < size) if (matriz[next][c] == 0) zeros++;
    next = l - 1;
    if (next >= 0) if (matriz[next][c] == 0) zeros++;
    next = c + 1;
    if (next < size) if (matriz[l][next] == 0) zeros++;
    next = c - 1;
    if (next >= 0) if (matriz[l][next] == 0) zeros++;

    return zeros == 0;
}


//Cria uma saída na borda da matriz a partir da posição [size/2][c] ou [l][size/2]
void makeOut(int size, int *linha, int *coluna) {
    int i, j;
    int saida =
            //tem-se size*4 - 4 possibilidades e nao pode ser [0,0], [0,1], [1,0], [2,0]
            rand() % ((size * 4) - 9) + 1;

    for (i = 0; i < size; i++) {
        for (j = 0; j < size; j++) {
            if (i == 0 || i == size - 1 || j == 0 || j == size - 1) {
                if (i < ceil(size / 2) && j < ceil(size / 2))continue;
                else {
                    saida--;
                }
                if (saida == 0) {
                    *linha = i;
                    *coluna = j;
                    i = i + size;
                    j = j + size;
                }
            }
        }
    }
    //Caso a matriz seja muito pequena ou não encontrou uma saída durante a iterações
    if (size < 4 || saida > 0) {
        *linha = size - 1;
        *coluna = size - 1;
    }
}


//Retorna se existe somente um zero ao redor da posição atual
int hasOneZeroAround(int **matriz, int size, int l, int c) {
    int next = l + 1;
    int zeros = 0;
    if (next < size) if (matriz[next][c] == 0) zeros++;
    next = l - 1;
    if (next >= 0) if (matriz[next][c] == 0)zeros++;
    next = c + 1;
    if (next < size) if (matriz[l][next] == 0) zeros++;
    next = c - 1;
    if (next >= 0) if (matriz[l][next] == 0) zeros++;

    return zeros == 1;
}

//retorna se a posição atual está em um dos cantos[TOP, BOTTOM, LEFT, RIGHT]
int is_edge(int size, int l, int c, int type) {

    switch (type) {
        case TOP:
            return l == 0;
        case BOTTOM:
            return l == size - 1;
        case LEFT:
            return c == 0;
        case RIGHT:
            return c == size - 1;
        default:
            return 0;
    }
}

/*
 * printa a matriz em forma de caminhos:
 * Caminhos ("0's") =>  •
 * Caminho correto =>  🐀
 * Paredes => #
 * Saída => [ ]
 */
void printLab(int **matriz, int s) {
    int i, j, k;
    printf("\n");
    for (i = 0; i < s; i++) {
        for (j = 0; j < s; j++) {
            if (i == 0 && j == 0 || matriz[i][j] == 3)printf(" 🐀");
            else if (matriz[i][j] == 9)printf(" # ");
            else if (matriz[i][j] == 0)printf(" • ");
            else printf("[ ]");
        }
        printf("\n");
    }
}

void printLabInFile(int **matriz, int s, FILE *f) {
    int i, j, k;
    fprintf(f, "\n");
    for (i = 0; i < s; i++) {
        for (j = 0; j < s; j++) {
            if (i == 0 && j == 0 || matriz[i][j] == 3)fprintf(f, " 🐀");
            else if (matriz[i][j] == 9)fprintf(f, " # ");
            else if (matriz[i][j] == 0)fprintf(f, " • ");
            else fprintf(f, "[ ]");
        }
        fprintf(f, "\n");
    }
}

//Gera uma matriz size por size dimensões
int **makeMatrix(int size) {
    int **m, i, j;
    m = malloc(size * sizeof(int *));
    for (i = 0; i < size; i++) {
        m[i] = malloc(size * sizeof(int *));
        for (j = 0; j < size; j++) m[i][j] = 9;
    }
    return m;
}