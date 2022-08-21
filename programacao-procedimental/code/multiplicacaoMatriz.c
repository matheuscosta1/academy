#include <stdio.h>
#include <stdlib.h>

int main()
{
    int N, L, linha, coluna;
    printf("Coloque um valor para N, que será o número de colunas e o número de posições do vetor: ");
    scanf("%d", &N);
    printf("\nColoque um valor para L, que será o número de linhas: ");
    scanf("%d", &L);

    int matriz[L][N];
    int vetor[N];
    int produto[L];

    //leitura da matriz
    for(linha=0; linha<L; linha++){
        for(coluna=0; coluna<N; coluna++){
            printf("\nmatriz[%2d][%2d]: ", linha, coluna);
            scanf("%2d", &matriz[linha][coluna]);
        }
        printf("\n");
    }

    //leitura do vetor
    for(coluna=0; coluna<N; coluna++){
        printf("\nvetor[%d]: ", coluna);
        scanf("%d", &vetor[coluna]);
    }

    //produto matriz x vetor
    for(linha=0; linha<L; linha++){
        produto[linha]=0;
        for(coluna=0; coluna<N; coluna++){
            produto[linha] = produto[linha] + matriz[linha][coluna] * vetor[coluna];
        }
    }
    //impressão da matriz
    for(linha=0; linha<L; linha++){
        printf("\n");
        for(coluna=0; coluna<N; coluna++){
            printf("%2d ", matriz[linha][coluna]);
        }
    }
    //impressão do vetor
    for(coluna=0; coluna<N; coluna++){
        printf("\nvetor[%d]: %d", coluna, vetor[coluna]);
    }
    printf("\n");
    //imprimindo o valor do produto matriz x vetor
    for(linha=0; linha<L; linha++){
        printf("\nproduto[%d]= %d", linha, produto[linha]);
    }

    return 0;
}