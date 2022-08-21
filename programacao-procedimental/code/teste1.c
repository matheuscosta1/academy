#include <stdio.h>
#include <stdlib.h>

int main()
{
    int linhas = 3, colunas = 3;
    float matriz[linhas][colunas];
    float maiorNotaEntreTodasAsProvasAtual = 0;
    float melhorNota;
    int indice;
    int contadorNota1=0, contadorNota2=0, contadorNota3=0;
    int contadorMaiorNotaEntreTodas=0;
    float maiorNotaAnterior = 0;

    for(int i=0; i < linhas ; i++) {//pra cada aluno

        melhorNota = 0;

        for(int j=0; j < colunas; j++){
            printf("matriz[%d][%d]: ", i, j); scanf("%f", &matriz[i][j]);
            printf("\n");

            if(matriz[i][j] > melhorNota) {
                melhorNota = matriz[i][j];
                indice = j;
            }

            if(matriz[i][j] >= maiorNotaEntreTodasAsProvasAtual){
                maiorNotaEntreTodasAsProvasAtual = matriz[i][j];
            }
        }
        

        if(indice == 0){
            contadorNota1++;
        } else if(indice == 1){
            contadorNota2++;
        } else {
            contadorNota3++;
        }
        
    }

    printf("Quantidade de alunos que obtiveram maior nota na prova 1: %d\n", contadorNota1);
    printf("Quantidade de alunos que obtiveram maior nota na prova 2: %d\n", contadorNota2);
    printf("Quantidade de alunos que obtiveram maior nota na prova 3: %d\n", contadorNota3);

    printf("Maior nota entre todas: %.2f e quantidade de alunos que obtiveram tal nota é: X\n", maiorNotaEntreTodasAsProvasAtual);

    return 0;
}