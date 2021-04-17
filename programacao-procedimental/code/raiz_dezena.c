#include<stdio.h>
#include<math.h>
int main()
{
	int a,b,c,d,soma;
	for(a=1000;a<10000;a++)
    {
        soma=0;
        b=a;
        while(b>0)
        {
            c=b%100;
            b/=100;
            soma+=c;
        }
        if(soma==sqrt(a))printf("%d\n",a);
    }
	return 0;
}
