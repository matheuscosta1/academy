#include <stdio.h>
#include <time.h>
#include "fibonacciiterativo.h"
#include "fibonaccirecursivo.h"
int main (void) {
time_t t1, t2, total;
int resposta,n;

scanf("%d",&n);
t1 = time(NULL); // retorna hora atual do sistema

resposta=fibonacci_i(n);
//resposta=fibonacci_r(n);
t2 = time(NULL);
total = difftime(t2,t1); // retorna a diferença t2-t1
printf("\n\nTotal: %ld seg.\n", total);
printf("resposta=%d",resposta);
return 0;
}
