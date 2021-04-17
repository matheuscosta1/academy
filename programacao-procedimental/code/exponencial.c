#include <stdio.h>

int main(){
    double i = 1,pot = 1, fatorial  = 1, exp = 1;
    int x;
    printf("(e^x)Digite x natural: ");
    scanf("%d", &x);
    while(pot/fatorial > 0.00001){
        pot = pot*x;
        fatorial= fatorial*i;
        exp += pot/fatorial;
        ++i;
    }
    printf("Resultado: %lf\n", exp);
    return 0;
}
