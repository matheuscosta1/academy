#include<stdio.h>
int conta(int);
int main()
{
    int a;
    printf("digite um numero: ");
	scanf("%d",&a);
	printf("o numero de casas desse numero eh %d",conta(a));
	return 0;
}
int conta(int w)
{
    int a,b,c=1;
    a=w%10;
    b=(w-a)/10;
    if(b<=0)return 1;
    else return c+conta (b);
}
