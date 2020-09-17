#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

void bubblesort(int vetor[], int n)
{
    int i, iteracao, aux;
    int troca=0, compara=0;
    for (iteracao =0; iteracao < n-1; iteracao++) //n-1 iteracoes
    {
        for (i=0; i<n-1; i++)
        {
            if(vetor[i] > vetor[i+1] ) //ordem crescente
            {
                aux = vetor[i];
                vetor[i] = vetor[i+1];
                vetor[i+1] = aux;
            }
        }
    }
}

void selectionsort(int vetor[], int n)
{
    int i, iteracao, aux, menor;
    for(iteracao = 0; iteracao < n-1; iteracao++)
    {
        menor = iteracao;
        for(i=iteracao+1; i<n; i++)
        {
            if(vetor[i] < vetor[menor])
                menor = i;

            if (iteracao != menor)
            {
                aux = vetor[iteracao];
                vetor[iteracao] = vetor[menor];
                vetor[menor] = aux;
            }
        }
    }
}

void insertionsort(int vetor[], int n)
{
    int i, iteracao, aux, elem;

    for(iteracao = 1; iteracao < n; iteracao++)
    {
        elem = vetor[iteracao];
        i = iteracao - 1;
        while(i>=0 && vetor[i] > elem)
        {
            vetor[i+1] = vetor[i];
            i--;
        }
        vetor[i+1] = elem;
    }
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

/*
  Dado um vetor de inteiros v e um inteiro n >= 0, ordena o vetor v[0..n-1] em ordem crescente.
*/
void mergesort(int *v, int n)
{
    int *c = malloc(sizeof(int) * n);
    sort(v, c, 0, n - 1);
    free(c);
}

/*
  Dado um vetor de inteiros v e dois inteiros i e f, ordena o vetor v[i..f] em ordem crescente.
  O vetor c é utilizado internamente durante a ordenação.
*/
void sort(int *v, int *c, int i, int f)
{
    if (i >= f)
        return;

    int m = (i + f) / 2;

    sort(v, c, i, m);
    sort(v, c, m + 1, f);

    /* Se v[m] <= v[m + 1], então v[i..f] já está ordenado. */
    if (v[m] <= v[m + 1])
        return;

    merge(v, c, i, m, f);
}

/*
  Dado um vetor v e três inteiros i, m e f, sendo v[i..m] e v[m+1..f] vetores ordenados,
  coloca os elementos destes vetores, em ordem crescente, no vetor em v[i..f].
*/
void merge(int *v, int *c, int i, int m, int f)
{
    int z,
        iv = i, ic = m + 1;

    for (z = i; z <= f; z++)
        c[z] = v[z];

    z = i;

    while (iv <= m && ic <= f)
    {
        /* Invariante: v[i..z] possui os valores de v[iv..m] e v[ic..f] em ordem crescente. */

        if (c[iv] < c[ic])
            v[z++] = c[iv++];
        else /* if (c[iv] > c[ic]) */
            v[z++] = c[ic++];
    }

    while (iv <= m)
        v[z++] = c[iv++];

    while (ic <= f)
        v[z++] = c[ic++];
}

void recursiveInsertionSort(int vetor[], int n)
{
    int i;
    if (n <= 1)
        return;

    //Ordena primeiro os n-1 elementos
    recursiveInsertionSort(vetor, n-1);

    //Coloca o último elemento na sua verdadeira posição
    // no array ordenado
    int last = vetor[n-1];
    int j = n-2;

    //Move os elementos do array [0..i-1] que
    //são maiores que o anterior para uma posição a frente

    while(j>=0 && vetor[j]>last)
    {
        vetor[j+1] = vetor[j];
        j--;
    }
    vetor[j+1] = last;
}


void swap(int arr[], int i, int j)
{
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}

void recursiveSelectionSort(int arr[], int i, int n)
{

    int min = i;
    for (int j = i + 1; j < n; j++)
    {

        if (arr[j] < arr[min])
            min = j;
    }

    swap(arr, min, i);

    if (i + 1 < n)
    {
        recursiveSelectionSort(arr, i + 1, n);
    }
}

void shellsort(int *vetor, int tamanho)
{
    int i = (tamanho - 1) / 2;
    int chave, k, aux;

    while(i != 0)
    {
        do
        {
            chave = 1;
            for(k = 0; k < tamanho - i; ++k)
            {
                if(vetor[k] > vetor[k + i])
                {
                    aux = vetor[k];
                    vetor[k] = vetor[k + i];
                    vetor[k + i] = aux;
                    chave = 0;
                }
            }
        }
        while(chave == 0);
        i = i / 2;
    }
}

int *indirectSeletionSort(int *vetor, int size)
{
    int i, iteracao, aux, menor;
    int *subvetor = malloc(sizeof(int)*size);
    for (i=0; i<size; i++)
        subvetor[i] = vetor[i];

    for(iteracao = 0; iteracao < size-1; iteracao++)
    {
        menor = iteracao;
        for (i=iteracao+1; i<size; i++)
        {
            if(subvetor[i] < subvetor[menor])
                menor = i;
        }

        if (iteracao != menor)
        {
            aux = subvetor[menor];
            subvetor[menor] = subvetor[iteracao];
            subvetor[iteracao] = aux;
        }
    }
    return subvetor;
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
