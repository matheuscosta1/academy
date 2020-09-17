#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

int partition(int vec[], int l, int u) {
  int i, m, temp;
  m = l;   // m: indice do ponto médio
  for(i = l+1; i<=u; i++) {
     if(vec[i] < vec[l]) { // fora de ordem
      m ++;
      temp = vec[i];  // trocar vec[i], vec[m]
      vec[i] = vec[m];
      vec[m] = temp;
     }
  }
  temp = vec[l]; // trocar vec[l], vec[m]
  vec[l] = vec[m];
  vec[m] = temp;
  return m;
}

void quicksort_rec(int vec[], int l, int u) {
  int m;
  if(l >= u)
    return;   // caso base; termina logo
  // senão: caso recursivo
  m = partition(vec, l, u);
     // partir usando pivot
  quicksort_rec(vec, l, m-1);
     // ordenar vec[l..m-1]
  quicksort_rec(vec, m+1, u);
     // ordenar vec[m+1..u]
}

void insertionSort2(int list[], int first, int last) {
        for (int i = first+1; i <= last; i++) { // Change i <= last
            int currentElement = list[i];
            int j = i-1;
            while (j>=0 && list[j]>currentElement) {
                list[j+1] = list[j];
                j--;
            }
            list[j+1] = currentElement;
        }
}

int quickSortComInsertion(int vec[], int l, int u, int s)
{
  int m;
  int size = (u+1) - l;
  if(l >= u)
    return;   // caso base; termina logo
  // senão: caso recursivo
  if(l < u){
        if(size <= s){
        insertionSort2(vec, l, u);
        }
        else{
        m = partition(vec, l, u);
        // partir usando pivot
        quicksort_rec(vec, l, m-1);
        // ordenar vec[l..m-1]
        quicksort_rec(vec, m+1, u);
        // ordenar vec[m+1..u]
        }
    }
}



void sortearAleatorio(int *vetor, int size)
{
    int i;

    for(i=0; i< vetor[size]; i++)
    {
        vetor[i] = rand() % 500;
        printf("[%d]: %d",i,vetor[i]);
        printf("\n");
    }

}

void ordemDecrescente(int *vetor, int size)
{
    int y=500, i;
    for(i=0; i<vetor[size]; i++)
    {
        vetor[i] = y;
        printf("[%d]: %d",i,vetor[i]);
        printf("\n");
        y--;
        if(y == -1)
            y=500;
    }
}

void ordemCrescente(int *vetor, int size)
{
    int x=0, i;

    for(i=0; i<vetor[size]; i++)
    {
        vetor[i] = x;
        printf("[%d]: %d",i,vetor[i]);
        printf("\n");
        x++;
        if(x == 501)
            x=0;
    }
}

int main()
{
    int size=500;
    int vetor[size];
    int i=0;
    char nome[] = "Quick Sort com Insertion";
    sortearAleatorio(vetor, size);
    //ordemCrescente(vetor, size);
    //ordemDecrescente(vetor, size);

    clock_t tempo;
    tempo = clock();

    //bubblesort(vetor, size);
    //insertionsort(vetor, size);
    //selectionsort(vetor, size);
    //quicksort_rec(vetor, 0, size);
    //mergesort(vetor, size);
    //int *a = indirectSeletionSort(vetor, size);
    //recursiveInsertionSort(vetor, size);
    //recursiveSelectionSort(vetor, 0, size);
    //shellsort(vetor, size);
    quickSortComInsertion(vetor,0,size,29);


    printf("\n\nAlgoritmo %s: \n", nome);
    printf("\n\nTempo: %f\n\n", ((clock() - tempo) / (double) CLOCKS_PER_SEC));


    printf("\nVetor em ordem\n\n");
    for(i=0; i<size; i++) //ORDENAR
    {
        printf("%d\t", vetor[i]);
    }

    /*printf("\nVetor em ordem\n\n");
    for(i=0; i<size; i++) //ORDENAR
    {
        printf("%d\t", a[i]);
    }*/ //printando o vetor selectionIndirectSort

    return 0;
}
