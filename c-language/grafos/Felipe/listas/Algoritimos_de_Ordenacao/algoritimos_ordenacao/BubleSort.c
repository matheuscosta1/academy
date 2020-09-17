#include"BubleSort.h"
#include<time.h>
void BubleSort(int vetor[],int n)
{
  int i,interacao,troca;
  int aux;
  for(interacao=n-1;interacao>0;interacao--)
 {
     troca=0;
      for(i=0;i<interacao;i++)
      {
          if(vetor[i]>vetor[i+1])
          {
              aux=vetor[i];
              vetor[i]=vetor[i+1];
              vetor[i+1]=aux;
              troca=1;
          }

      }
       if(troca==0)
            break;
  }
}

void BubleRecursivo(int vetor[],int n)
{
    int i,troca=0;
    int aux;


    for(i=0;i<n-1;i++)
    {
        if(vetor[i]>vetor[i+1])
        {
            aux=vetor[i];
            vetor[i]=vetor[i+1];
            vetor[i+1]=aux;
            troca=1;
        }
    }
    if(troca==0)
       return;

    BubleRecursivo(vetor,n-1);
}
void Crescente(int* v,int n )
{
Aleatorio(v,n);

QuickSort(v,0,n-1);


}

void decrescente(int* v, int n)
{
    int i,j,aux;
    Crescente(v,n);

    j=n-1;
    for(i=0;i<j;i++)
    {
        aux=v[i];
        v[i]=v[j];
        v[j]=aux;
        j--;
    }

}

void Aleatorio(int* v,int n)
{
    int i;
srand((unsigned)time(NULL));
for(i=0;i<n;i++)
{
    v[i]=rand()%501;

}
}
