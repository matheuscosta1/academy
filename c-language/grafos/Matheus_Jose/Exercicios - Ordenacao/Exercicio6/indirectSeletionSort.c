#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

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
    int *a = indirectSeletionSort(vetor, size);
    //recursiveInsertionSort(vetor, size);
    //recursiveSelectionSort(vetor, 0, size);
    //shellsort(vetor, size);
    //quickSortComInsertion(vetor,0,size,29);


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
