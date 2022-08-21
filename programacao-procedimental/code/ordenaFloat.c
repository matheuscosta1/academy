#include <stdio.h>
#include <stdlib.h>
#define TAM 5

int main()
{
    int i, j, k;
    float vetor[TAM], aux=0;

    //lê os valores do vetor
    for(i=0; i<TAM; i++){
        printf("vetor[%d]= ", i); scanf("%f", &vetor[i]);
    }
    //analisa posição por posição
    for(j=0; j<=TAM-1; j++){
        for(k=j+1; k<TAM; k++){
            //troca
            if(vetor[j]>vetor[k]){
                aux=vetor[j];
                vetor[j]=vetor[k];
                vetor[k]=aux;
            }
        }
    }
    printf("\n\n");
    //imprime o vetor ordenado
    for(j=0; j<TAM; j++){
        printf("Vetor[%d]= %.2f\n", j, vetor[j]);
    }

    return 0;
}