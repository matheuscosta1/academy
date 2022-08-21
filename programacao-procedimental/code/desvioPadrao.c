#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main()
{
    int N, i;
    printf("Digite um valor para N: "); scanf("%d", &N);

    int V[N];
    float media = 0, dp=0;

    for (i=1; i<=N; i++) {
        printf("Coloque um valor para V[%d]: ", i-1); scanf("%d", &V[i-1]);
        media = media + V[i-1];
    }
    media=media/N;

    for (i=0; i<N; i++) {
        dp = dp + (media-V[i]) * (media-V[i]);
    }

    dp= dp/N;
    dp= sqrt(dp);

    printf("\nMédia: %.2f", media);
    printf("\nDesvio padrão: %.2f", dp);


    return 0;
}