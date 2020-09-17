#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int fib_recurs(int n){
    if (n<2) return n; // caso base
    else return (fib_recurs(n-1)+fib_recurs(n-2));

}

int fib_itera(int n){
    int k, i=1, F=0;

    for(k=1; k<=n;k++){
        F= F+i;
        i = F-i;
    }
    return F;
}

int main(){
    clock_t tempo;
    tempo = clock();

    printf("A sequencia de Fibonnaci eh:\n");
    for(int i = 0; i<5; i++){
        printf("%d\t", fib_recurs(i+1));
    }
    printf("\n");

    printf("Tempo: %f", ((clock() - tempo) / (double) CLOCKS_PER_SEC));
}
