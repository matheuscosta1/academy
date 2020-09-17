#include<stdio.h>
#include <stdlib.h>
#include <time.h>

int maior_r(int *r,int n);
int main ()
{  int r[5],i;

srand(time(NULL));

for(i=1;i<=5;i++)
{
    r[i]=rand()%20;
    printf("r[%d]=%d\n",i,r[i]);
}
    return 0;
}

int maior_r(int *r,int n)
{
    int ultimo=r[n];
    int q;
    if(n==1)
    return r[n];
    else
    q=maior_r(r,n-1);
    if(q< ultimo)
        return ultimo;
    else
        return q;
}
