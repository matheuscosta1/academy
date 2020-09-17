#include"InsertSort.h"


void InsertSort(int*v,int n)
{
int i,iteracao,elem;

for(iteracao=1;iteracao<n;iteracao++)
{
    elem = v[iteracao];
    i=iteracao-1;
    while(i>=0 && v[i]>elem)
    {
        v[i+1]=v[i];
        i--;
    }
    v[i+1]=elem;
}


}

void Insert_rec(int* v,int n,int interacao)
{
    int i,elem;
    if(interacao>=n)
        return;

    elem=v[interacao];
    i=interacao-1;
  while(i>=0 && v[i] >elem)
{

            v[i+1]=v[i];
            i--;
        }
    v[i+1]=elem;
    Insert_rec(v,n,interacao+1);
}

int** InsertSort2(int*v,int n)
{
int i,iteracao;
int**s=(int*)malloc(sizeof(int*)*n);
int* elem;
for(i=0;i<n;i++)
{
    s[i]=&v[i];
}
for(iteracao=1;iteracao<n;iteracao++)
{
    elem = s[iteracao];
    i=iteracao-1;
    while(i>=0 && *s[i]>*elem)
    {
        s[i+1]=s[i];
        i--;
    }
    s[i+1]=elem;
}

return s;
}

