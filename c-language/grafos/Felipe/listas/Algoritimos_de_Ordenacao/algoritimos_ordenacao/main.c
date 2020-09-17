#include <stdio.h>
#include <stdlib.h>
#include"BubleSort.h"
#include"selectSort.h"
#include"InsertSort.h"
#include"QuickSort.h"
#include"time.h"
int main()
{

   int tamanho;
   int i;
   int** s;
   time_t t1,t2,total;
   printf("digite o tamanho do vetor:");
   scanf("%d",&tamanho);


int vetor[tamanho];

   // Aleatorio(vetor,tamanho);

   //Crescente(vetor,tamanho);

    decrescente(vetor,tamanho);



   t1=clock();
   //BubleSort(vetor,tamanho);
   //selectSort(vetor,tamanho);
   //InsertSort(vetor,tamanho);
   //QuickSort(vetor,0,tamanho-1);
   //MergeSort(vetor,0,tamanho-1);
   //BubleRecursivo(vetor,tamanho);
   //Insert_rec(vetor,tamanho,1);
  // select_rec(vetor,tamanho);
    //QuickInsert(vetor,0,tamanho-1);
    s=InsertSort2(vetor,tamanho);
   t2=clock();
   total=difftime(t2,t1)*1000;

   printf("\ntempo de execucao:%ld seg.\n",total);
 /*for(i=0;i<tamanho;i++)
 {
     printf("vetor[%d]%d\n",i,vetor[i]);
 }*/

for(i=0;i<tamanho;i++)
 {
     printf("vetor[%d]%d\n",i,*s[i]);
 }

return 0;
}
