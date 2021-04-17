#include<stdio.h>
#include<math.h>
int main()
{
    int a,i,soma=0;
    float raiz;
    printf("digite um numero: ");
    scanf("%d",&a);
    raiz=sqrt(a);
    for(i=2;i<=raiz;i++)
    {
        if(a%i==0)soma++;
    }
    if(soma==0)printf("%d e um numero primo",a);
    else printf("%d nao e um numero primo",a);
	return 0;
}
