#include<stdio.h>
int main()
{
    float n,x,j;
    printf("digite um numero: ");
    scanf("%f",&n);
    x=n/2;
    for(j=0;j<=25;j++)x=(x+(n/x))/2;
    printf("a raiz quadrada de %.2f e %.5f",n,x);
	return 0;
}
