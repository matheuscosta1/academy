#include"MergeSort.h"
#include<stdio.h>
#include<stdlib.h>
void MergeSort(int* v,int inicio,int fim)
{
    if(inicio<fim)
    {
    int meio=floor((inicio+fim)/2);

    MergeSort(v,inicio,meio);
    MergeSort(v,meio+1,fim);
    Intercala(v,inicio,meio,fim);
    }

}

void Intercala(int *v,int inicio,int meio,int fim)
{
    int p1=inicio,p2=meio+1,fim1=0,fim2=0;

    int tamanho=fim-inicio+1;

    int* aux=malloc(tamanho*sizeof(int));

    if(aux!=NULL)
    {
        int i,j,k;
        for(i=0;i<tamanho;i++)
        {
        if(!fim1 && !fim2)
        {
            if(v[p1]<v[p2])
                aux[i]=v[p1++];
            else
                aux[i]=v[p2++];

        if(p1>meio)fim1=1;
        if(p2>fim)fim2=1;
        }
        else
        {
            if(fim1)
            {
                aux[i]=v[p2++];
            }
            else
                aux[i]=v[p1++];

        }
        }
        for(j=0,k=inicio;j<tamanho;j++,k++)
        {
            v[k]=aux[j];
        }
    }
    free(aux);
}



