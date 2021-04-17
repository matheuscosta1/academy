#include<stdio.h>
int main()
{
	int a;
	printf("Sequencia de Collatz\nDigite um numero: ");
	scanf("%d",&a);
	while(a>=1)
    {
        printf("%d ",a);
        if(a%2==0)a=a/2;
        else if(a==1)break;
        else a=(a*3)+1;
    }
	return 0;
}
