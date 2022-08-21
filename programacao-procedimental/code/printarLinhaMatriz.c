#include <stdio.h>
#include <stdlib.h>

int main()
{
    int matriz[5][4], i, j;

    //lendo a matriz
    for(i=0; i<5; i++){
        for(j=0; j<4; j++){
            printf("\nmatriz[%2d][%2d]= ", i, j);
            scanf("%2d", &matriz[i][j]);
        }
    }
    printf("\n\n");
    //imprimindo a matriz
    for(i=0; i<5; i++){
        printf("\n");
        for(j=0; j<4; j++){
            printf(" %2d", matriz[i][j]);
        }
    }
    int N;
    //lendo N
    printf("\n\nDigite um valor para a linha N, de 0 até 4: "); scanf("%d", &N);
    if(N<0 || N>4){
        printf("\nO número digitado para N não é compatível com o número de linhas da matriz.\n");
    }
    //imprimindo os elementos de N linha
    for(i=0; i<5; i++){
        for(j=0; j<4; j++){
            if(i==N){
                printf("\n\nmatriz[%d][%d]= %d", i, j, matriz[i][j]);
            }
        }
    }

    return 0;
}