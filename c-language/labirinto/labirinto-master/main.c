#include "labirinto.h"
#include "labSolver.h"
#include <string.h>

int main(int s, char **args){
    int size;

    printf("Labirinto\n");
	printf("Digite a dimensao do labirinto: ");

	if(s < 2)scanf("%d", &size);
     else size = atoi(args[1]);
    printf("\nPressione ENTER para gerar o Labirinto...");
    setbuf(stdin, NULL);
    getchar();

    int **lab = makeLab(size);

    printf("Pressione ENTER para descobrir o  caminho correto...");
    setbuf(stdin, NULL);
    getchar();

    Pilha *p = solveLab(lab, size);
    destroyPilha(p);

    printf("\n~~~ Veja o arquivo 'log.txt' para informacoes sobre a construcao da resolucao do labirinto ~~~\n\n");
    return 0;
}