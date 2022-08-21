#include <stdio.h>
#include <stdlib.h>

int main()
{
    int linhaMatrizA, colunaMatrizA, linhaMatrizB, colunaMatrizB;
    //lendo o número de linhas e colunas da matriz A
    printf("Insira o número de linhas e colunas, respectivamente, da matriz A: "); scanf("%d %d", &linhaMatrizA, &colunaMatrizA);
    //lendo o número de linhas e colunas da matriz B
    printf("\nInsira o número de linhas e colunas, respectivamente, da matriz B: "); scanf("%d %d", &linhaMatrizB, &colunaMatrizB);

    int matrizA[linhaMatrizA][colunaMatrizA], matrizB[linhaMatrizB][colunaMatrizB], produtoAB[linhaMatrizA][colunaMatrizB], i, j, k;
    printf("\n\n");
    //lendo a matriz A
    for(i=0; i<linhaMatrizA; i++){
        for(j=0; j<colunaMatrizA; j++){
            printf("matrizA[%2d][%2d]= ", i, j); scanf("%d", &matrizA[i][j]);
        }
    }
    printf("\n\n");
    //lendo matriz B
    for(i=0; i<linhaMatrizB; i++){
        for(j=0; j<colunaMatrizB; j++){
            printf("matrizB[%d][%d]= ", i, j); scanf("%d", &matrizB[i][j]);
        }
    }
    
    if(linhaMatrizA!=colunaMatrizB){
        printf("\n\nAs matrizes fornecidas não podem ser multiplicadas. Comece tudo de novo.");
        exit(0); // para o programa
    }

    //imprimindo a matriz A
    for(i=0; i<linhaMatrizA; i++){
        printf("\n");
        for(j=0; j<colunaMatrizA; j++){
            printf(" %2d", matrizA[i][j]);
        }
    }
    printf("\n\n");
    //imprimindo a matriz B
    for(i=0; i<linhaMatrizB; i++){
        printf("\n");
        for(j=0; j<colunaMatrizB; j++){
            printf(" %2d", matrizB[i][j]);
        }
    }
    
    //inicializando o produto
    for (i=0;i<linhaMatrizA; i++) {
        for (j=0; j<colunaMatrizB; j++) {
            produtoAB[i][j] = 0;
        }
    }

    //calculando matriz produto
    for (i=0;i<linhaMatrizA; i++) {
        for (j=0; j<colunaMatrizB; j++) {
            for (k=0; k<colunaMatrizA; k++){
                produtoAB[i][j] = produtoAB[i][j] + matrizA[i][k] * matrizB[k][j];
            }
        }
    }
    printf("\n\n");
    //imprimindo o produto das matrizes
    for(i=0; i<linhaMatrizA; i++){
        printf("\n");
        for(j=0; j<colunaMatrizB; j++){
            printf(" %2d", produtoAB[i][j]);
        }
    }


    return 0;
}