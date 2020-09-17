#include "ordenacoes.h"
#include "utils.h"
void main(void){
	int * vetor = malloc(sizeof(int)*100);

	printf("Selection sort recursivo:\n");
	test_normal(selection_sort_rec, vetor, 10);

	printf("Insertion sort recursivo\n");
	test_normal(insertion_sort_rec, vetor, 10);

	printf("Bubble sort recursivo\n");
	test_normal(bubble_sort_rec, vetor, 10);

	free(vetor);
}