#include"QuickSort.h"
#include<time.h>
void QuickSort(int* v,int p,int r)
{
    int aux,pivo,a,i,j;
    //srand((unsigned)time(NULL));
    if(p<r)
    {
        a=(rand()%(r-p))+p;
        pivo=v[a];
        v[a]=v[r];
        v[r]=pivo;

       i=p-1;
       j=r;

        do
        {
           do{i++;}while(v[i]<pivo);
           do{j--;}while(v[j]>pivo);

            if(i<j)
            {
                aux=v[i];v[i]=v[j];v[j]=aux;
            }


        }while(i<j);
        v[r]=v[i];
        v[i]=pivo;
        QuickSort(v,p,i-1);
        QuickSort(v,i+1,r);
    }
}
void QuickInsert(int* v,int p,int r)
{
    int aux,pivo,a,i,j;
    //srand((unsigned)time(NULL));
    if(r-p<=1000)
        InsertSort(v,p-r+1);

    if(p<r)
    {
        a=(rand()%(r-p))+p;
        pivo=v[a];
        v[a]=v[r];
        v[r]=pivo;

       i=p-1;
       j=r;

        do
        {
           do{i++;}while(v[i]<pivo);
           do{j--;}while(v[j]>pivo);

            if(i<j)
            {
                aux=v[i];v[i]=v[j];v[j]=aux;
            }


        }while(i<j);
        v[r]=v[i];
        v[i]=pivo;
        QuickInsert(v,p,i-1);
        QuickInsert(v,i+1,r);
    }
}
