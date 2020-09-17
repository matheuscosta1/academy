#include"selectSort.h"

void selectSort(int*v,int n)
{
    int i,interacoes,menor,aux;

    for(interacoes=0;interacoes<n-1;interacoes++)
    {
        menor=interacoes;
        for(i=interacoes;i<n;i++)
        {
            if(v[i]<v[menor])
                menor=i;
        }
        if(interacoes != menor)
        {   aux=v[menor];
            v[menor]=v[interacoes];
            v[interacoes]=aux;
        }
    }
}

void select_rec(int* v,int n)
{

    int maior,i,aux;

    maior=n;

    for(i=n-1;i>=0;i--)
    {
        if(v[i]>v[maior])
        {
            maior=i;
        }
    }
    if(maior!=n)
    {
        aux=v[n];
        v[n]=v[maior];
        v[maior]=aux;
    }
    if(n-1>1)
       select_rec(v,n-1);

}
