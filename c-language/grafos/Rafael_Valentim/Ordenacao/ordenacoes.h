#ifndef ORDENACOES_H
#define ORDENACOES_H

//Simples
void bubble_sort(int*, int);
void selection_sort(int*, int);
void insertion_sort(int *,int);
void shell_sort(int*, int);

//Simples recursivas
void bubble_sort_rec(int*, int);
void selection_sort_rec(int*, int);
void insertion_sort_rec(int*, int);
/*Não use por conta própria, ao invés chame pela insertion_sort_rec(int [], int )*/
void is_rec_helper(int vec[], int p,int n);
int * selection_sort_ind(int *, int);
//Complexos
void quick_sort(int *, int, int);
void merge_sort(int *, int, int);
void intercala (int *vetor, int ini, int meio, int fim) ;
void quick_sort_insertion(int vetor[], int ini, int fim, int s);
#endif