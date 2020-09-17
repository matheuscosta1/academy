#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

void bubble_rec(int vetor[],int n)
{
    int i,aux, troca = 0;
    for (i=0; i <n-1; i++){
        if(vetor[i] > vetor[i+1])
        {
            aux= vetor[i];
            vetor[i] = vetor[i+1];
            vetor[i+1] =aux;
            troca = 1;
        }
    }
    if (troca != 0)
        bubble_rec (n-1, vetor);
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
    char nome[] = "Ord Recursiva";
    sortearAleatorio(vetor, size);
    //ordemCrescente(vetor, size);
    //ordemDecrescente(vetor, size);

    clock_t tempo;
    tempo = clock();
    //mergesort(vetor, size);
    //bubble_rec(vetor, size);
    recursiveInsertionSort(vetor, size);
    //recursiveSelectionSort(vetor, 0, size);

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
