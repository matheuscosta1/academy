#include "ordenacoes.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "utils.h"
void bubble_sort(int vec[], int n){
	int i, iteracao, aux= 0, trocas;

	for(iteracao = n-1; iteracao > 1 ;iteracao--){
		trocas = 0;
		for (i = 0; i < iteracao; i++){
			if(vec[i+1] < vec[i]){
				aux = vec[i];
				vec[i] = vec[i+1];
				vec[i+1] = aux;
				trocas = 1;
			}
		}
		if(!trocas)break; 
	}
}


void bubble_sort_rec (int vetor[], int n){
int i, aux, troca = 0;
for (i=0; i < n-1; i++)
if (vetor[i] > vetor[i+1]) {
aux = vetor[i];
vetor[i] = vetor[i+1];
vetor[i+1] = aux;
troca = 1;
}
if (troca != 0)
bubble_sort_rec (vetor, n-1);
}


void selection_sort(int vec[], int n){
	int i, iteracao, menor, aux;

	for(iteracao = 0; iteracao < n -1; iteracao++){
		menor = iteracao;
		for(i = iteracao + 1; i < n ; i++){
			if(vec[menor] > vec[i]) menor = i;
		}
		if(menor != iteracao){
		aux = vec[menor];
		vec[menor] = vec[iteracao];
		vec[iteracao] = aux;
		}
	}
}

void selection_sort_rec(int vec[], int n){
	int i, maior= n-1, aux;

	for(i=0; i< n; i++){
		if(vec[maior] < vec[i]) maior = i;
	}
	if(maior != n-1){
	aux = vec[maior];
	vec[maior] = vec[n-1];
	vec[n-1] = aux;
	}
	if(n > 0){
		selection_sort(vec, n-1);
	}
}

int * selection_sort_ind(int vec[], int n){
	int i, iteracao, menor, aux;
	int *sub_vetor = malloc(sizeof(int)*n);
	for(i =0; i<n; i++) sub_vetor[i] = vec[i];

	for(iteracao = 0; iteracao < n -1; iteracao++){
		menor = iteracao;
		for(i = iteracao + 1; i < n ; i++){
			if(sub_vetor[menor] > sub_vetor[i]) menor = i;
		}
		if(menor != iteracao){
		aux = sub_vetor[menor];
		sub_vetor[menor] = sub_vetor[iteracao];
		sub_vetor[iteracao] = aux;
		}
	}
    
	return sub_vetor;
}
void insertion_sort(int vec[], int n){
	int i, iteracao, elem;
	for(iteracao = 1; iteracao < n; iteracao++){
		elem = vec[iteracao];
		i = iteracao-1;
		while (i >= 0 && vec[i] > elem) {
		vec[i+1] = vec[i];
		i--;
		}
		vec[i+1] = elem;
	}
}

void insertion_sort_rec(int vec[], int n){
	is_rec_helper(vec, 1, n);
}

/*Não use por conta própria, ao invés chame pela insertion_sort_rec(int [], int )*/
void is_rec_helper(int vec[], int p,int n){
	int elem = vec[p];
	int i = p -1;
	while(i >=0 && vec[i] >elem){
		vec[i+1] = vec[i];
		i--;
	}
	vec[i+1] = elem;
	if(p < n) is_rec_helper(vec, p+1, n);
}

void  quick_sort(int vetor[], int inicio, int fim) {
	 int pivo, aux, i, j, meio;
   
   i = inicio;
   j = fim;
   
   meio = (int) ((i + j) / 2);
   pivo = vetor[meio];
   
   do{
      while (vetor[i] < pivo) i = i + 1;
      while (vetor[j] > pivo) j = j - 1;
      
      if(i <= j){
         aux = vetor[i];
         vetor[i] = vetor[j];
         vetor[j] = aux;
         i = i + 1;
         j = j - 1;
      }
   }while(j > i);
   
   if(inicio < j) quick_sort(vetor, inicio, j);
   if(i < fim) quick_sort(vetor, i, fim);   
}

void quick_sort_insertion(int a[], int p, int r, int s){
	int t;
	if (p < r && (r - p) > s) {
		int v = (rand()%(r-p))+p;
		int pivo = a[v];
		a[v] = a[r];
		a[r] = pivo;
		int i = p-1; int j = r;
		do {
			do { i++; } while (a[i] < pivo);
			do { j--; } while ((a[j] > pivo) && (j > p));
			if (i < j) {
				t = a[i]; 
				a[i] = a[j]; 
				a[j] = t;} 
		} while (i<j);
		a[r] = a[i]; a[i] = pivo; 
		quick_sort_insertion(a, p, i-1, s); quick_sort_insertion(a, i+1, r, s);
	
	}else{
		int i, iteracao, elem;
		for(iteracao = p+1; iteracao < r+1; iteracao++){
		elem = a[iteracao];
		i = iteracao-1;
		while (i >= p && a[i] > elem) {
		a[i+1] = a[i];
		i--;
		}
		a[i+1] = elem;
		}
	}
}

void merge_sort(int vetor[], int ini, int fim) {
	if (ini < fim) {
		int meio = floor((ini+fim)/2);
		merge_sort(vetor, ini, meio);
		merge_sort(vetor, meio+1, fim);
		intercala(vetor, ini, meio, fim);
	}
}

void intercala(int arr[], int l, int m, int r)
{
    int i, j, k;
    int n1 = m - l + 1;
    int n2 =  r - m;
 
    /* criando arrays secundarios */
    int L[n1], R[n2];
 
    for (i = 0; i < n1; i++)
        L[i] = arr[l + i];

    for (j = 0; j < n2; j++)
        R[j] = arr[m + 1+ j];
 
   
    i = 0; // Initial index of first subarray
    j = 0; // Initial index of second subarray
    k = l; // Initial index of merged subarray
    while (i < n1 && j < n2)
    {
        if (L[i] <= R[j])
        {
            arr[k] = L[i];
            i++;
        }
        else
        {
            arr[k] = R[j];
            j++;
        }
        k++;
    }
 
    /* Copy the remaining elements of L[], if there
       are any */
    while (i < n1)
    {
        arr[k] = L[i];
        i++;
        k++;
    }
 
    /* Copy the remaining elements of R[], if there
       are any */
    while (j < n2)
    {
        arr[k] = R[j];
        j++;
        k++;
    }
}


void shell_sort(int *a, int size){
 int i , j , value;
 int gap = 1;
  
 do {
  gap = 3*gap+1;
 } while(gap < size);
  
 do {
  gap /= 3;
  for(i = gap; i < size; i++) {
   value = a[i];
   j = i - gap;
    
   while (j >= 0 && value < a[j]) {
    a[j + gap] = a[j];
    j -= gap;
   }
   a[j + gap] = value;
  }
 }while(gap > 1);

}