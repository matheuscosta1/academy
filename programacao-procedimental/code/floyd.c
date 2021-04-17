#include<stdio.h>
int main()
{
	int n,a,b,c,d;
	printf("digite o tamanhao do triangulo do floyd: ");
	scanf("%d",&n);
	for(a=0;a<n;a++)
    {
        for(b=1;b<(a+2);b++)c=(b*(b+1))/2;
        d=c-a;
        while(d<=c)
        {
            printf("%d ",d);
            d++;
        }
        printf("\n");
    }
	return 0;
}
