#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "ordenacoes.h"
#include "utils.h"

int main(int argc, char ** args){
	srand(time(NULL));
	int i =0;
	int times[]= {100, 1000, 10000};

	int * vetor;
	while(i < 3){
		vetor = malloc(sizeof(int)*times[i]);
		printf("Teste com %d valores\n", times[i]);
		printf("\nQuick Sort\n");
		test_rapida(quick_sort, vetor, times[i]);
		printf("\nMerge Sort\n");
		test_rapida(merge_sort, vetor, times[i]);
		printf("\nBubble Sort\n");
		test_normal(bubble_sort, vetor, times[i]);
		printf("\nSelection Sort\n");
		test_normal(selection_sort, vetor, times[i]);
		printf("\nInsertion Sort\n");
		test_normal(insertion_sort, vetor, times[i]);
		printf("--------------------------------------------------------\n");
		free(vetor);
		i++;
	} 
	
	return 0;
}

