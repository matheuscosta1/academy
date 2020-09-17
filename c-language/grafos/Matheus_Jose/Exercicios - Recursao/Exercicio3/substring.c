#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void substrings (char s[], int primeiroelemento, int tamanho){
    int j;
    for (int i = primeiroelemento;i<tamanho;i++){
        for(j=primeiroelemento; j<=i;j++){
            printf("%c",s[j]);
        }
        printf("\t");
    }
    if (primeiroelemento != tamanho-1){
        substrings(s, primeiroelemento+1, tamanho);
    }
    printf("\n");
}

int main(){
    clock_t tempo;
    tempo = clock();

    /*printf("A sequencia de Fibonnaci eh:\n");
    for(int i = 0; i<10000; i++){
        printf("%d\t", fib_itera(i+1));
    }*/

    char s[4] = "AED2";
    int tamanho = 4;
    substrings(s,0,tamanho);

    printf("Tempo: %f", ((clock() - tempo) / (double) CLOCKS_PER_SEC));
}
