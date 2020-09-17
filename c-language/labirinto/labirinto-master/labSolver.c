#include "labSolver.h"

//Função principal que define variáveis "globais" e define o tipo da celula  atual da matriz
Pilha *solveLab(int **matriz, int size) {
    Pilha *p = makePilha();
    int l, c, next, l_next = 0, c_next = 0, zeros;
    Lista *deadEndPaths = makeLista();
    Path *lastOne;
    FILE *f = fopen("log.txt", "w");

    fprintf(f, "\n::::::::LOG:::::::\n");
    fprintf(f, "Esse arquivo contém informações acerca do processo de resolução do labirinto\n\n");
    fprintf(f, "Tamanho : %dx%d\n\nForma:\n", size, size);
    printLabInFile(matriz, size, f);
    int i = 0;

    fprintf(f, "\n::::::Inicio do Processo de Resolucao::::::\n");
    do {
        fprintf(f, "\n-----------------\nTentando: [%d][%d]\n", l_next, c_next);
        c = c_next;
        l = l_next;
        zeros = numZerosAround(matriz, size, c, l);
        if (chegou(matriz, size, l, c)) {
            push(p, l, c, IS_OUT);
            fprintf(f, "\n::Saída encontrada::\n");
            break;
        }

        fprintf(f, "Quantidade de zeros ao redor: %d\n", zeros);
        if (p->bottom == NULL) {
            l = 0;
            c = 0;
            push(p, 0, 0, IS_NODE);
            findNextPath(p, matriz, size, deadEndPaths, l, c, &l_next, &c_next, f);
        } else if (zeros == 2) {
            fprintf(f, "Tipo: COMUM\n");
            push(p, l, c, IS_CHILD);
            findNextPath(p, matriz, size, deadEndPaths, l, c, &l_next, &c_next, f);
        } else if (zeros > 2) {

            fprintf(f, "Tipo: NÓ\n");
            //Para facilitar a manutenção de possivéis caminhos
            insert(deadEndPaths, l, c);
            push(p, l, c, IS_NODE);
            findNextPath(p, matriz, size, deadEndPaths, l, c, &l_next, &c_next, f);
        } else {
            insert(deadEndPaths, l, c);
            lastOne = pullPath(p);
            fprintf(f, "Tipo: Beco sem saida...Voltando ao nó:[%d][%d]\n", p->top->l, p->top->c);
            if (lastOne->l > 0 || lastOne->c > 0) insert(deadEndPaths, lastOne->l, lastOne->c);
            free(lastOne);
            c = p->top->c;
            l = p->top->l;
            findNextPath(p, matriz, size, deadEndPaths, l, c, &l_next, &c_next, f);
        }

        fprintf(f, "Proximo: [%d][%d]\n", l_next, c_next);
    } while (++i);
    printf("\n:::::::::::::::::::::::::::::::::::\n"
                   "Completo depois de %d tentativas\n"
                   ":::::::::::::::::::::::::::::::::::\n", i);
    fprintf(f, "\n:::::::::::::::::::::::::::::::::::\n"
                   "Completo depois de %d tentativas\n"
                   ":::::::::::::::::::::::::::::::::::\n", i);
    printPilha(p,f);
    printList(deadEndPaths, f);
    printCorrectPath(matriz, size, p, f );
    fclose(f);
    destroy(deadEndPaths);
    return p;
}

int numZerosAround(int **matriz, int size, int c, int l) {
    int next = l + 1;
    int zeros = 0;
    if (next < size) if (matriz[next][c] == 0) zeros++;
    next = l - 1;
    if (next >= 0) if (matriz[next][c] == 0)zeros++;
    next = c + 1;
    if (next < size) if (matriz[l][next] == 0) zeros++;
    next = c - 1;
    if (next >= 0) if (matriz[l][next] == 0) zeros++;

    return zeros;
}

void findNextPath(Pilha *p, int **matriz, int size, Lista *deadEndPaths, int l, int c, int *l_next, int *c_next, FILE *f) {
    int next = l + 1;
    int is00 = (c == 0 && l == 0 ? 1 : 0);
    *c_next = c;
    *l_next = l;
    if (next < size)
        if (matriz[next][c] == 0 && next != p->top->l && (is00 == 1 ? 1 : next != p->top->below->l) &&
            !contains(deadEndPaths, next, c)) {
            *l_next = next;
            *c_next = c;
        }
    next = l - 1;
    if (next >= 0)
        if (matriz[next][c] == 0 && next != p->top->l && (is00 == 1 ? 1 : next != p->top->below->l) &&
            !contains(deadEndPaths, next, c)) {
            *l_next = next;
            *c_next = c;
        }
    next = c + 1;
    if (next < size)
        if (matriz[l][next] == 0 && next != p->top->c && (is00 == 1 ? 1 : next != p->top->below->c) &&
            !contains(deadEndPaths, l, next)) {
            *l_next = l;
            *c_next = next;
        }
    next = c - 1;
    if (next >= 0)
        if (matriz[l][next] == 0 && next != p->top->c && (is00 == 1 ? 1 : next != p->top->below->c) &&
            !contains(deadEndPaths, l, next)) {
            *l_next = l;
            *c_next = next;
        }

    if (c == *c_next && l == *l_next) {

        fprintf(f, "\n-----------------\nTentou todas\n");
        pullPath(p);
        fprintf(f, "Removendo nó [%d][%d]...\n", p->top->l, p->top->c);
        pull(p);
        Path *aux = pullPath(p);
        if(aux->l >= 0)insert(deadEndPaths, aux->l, aux->c);
        free(aux);
        l = p->top->l;
        c = p->top->c;
        findNextPath(p, matriz, size, deadEndPaths, l, c, l_next, c_next, f);
    }
}

int chegou(int **matriz, int size, int l, int c) {

    int next = l + 1;
    if (next < size) if (matriz[next][c] == 2) return 1;

    next = l - 1;
    if (next >= 0) if (matriz[next][c] == 2) return 1;

    next = c + 1;
    if (next < size) if (matriz[l][next] == 2) return 1;

    next = c - 1;
    if (next >= 0) if (matriz[l][next] == 2) return 1;

    return 0;
}

void printCorrectPath(int **lab, int size, Pilha *p, FILE *f) {
    int **solvedLab = makeMatrix(size);
    int i, j;
    printf("\n::Labirinto::");
    fprintf(f, "\n::Labirinto::");
    printLab(lab, size);
    printLabInFile(lab, size, f);
    for (i = 0; i < size; i++) {
        for (j = 0; j < size; j++) {
            solvedLab[i][j] = lab[i][j];
        }
    }
    while (p->top != NULL) {
        Path *path = pull(p);
        solvedLab[path->l][path->c] = 3;
    }
    printf("\n::Resolucao::");
    fprintf(f, "\n::Resolucao::");
    printLab(solvedLab, size);
    printLabInFile(solvedLab, size, f);
}