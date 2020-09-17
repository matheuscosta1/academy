#include "ordenacoes.h"
#include "utils.h"

void main(int agrc, char ** argv){
	srand(time(NULL));
	int s = toInt(argv[1]);
	int n = toInt(argv[2]);
	int * vetor = malloc(sizeof(int)*n);
	vetor_aleatorio(vetor, n, n);

//	printVetor("\nVetor ordenado:\n", vetor, n);

	int t1 = time(NULL);
	quick_sort_insertion(vetor, 0, n, s);
	printf("Time elapsed: %lf\n", difftime(time(NULL), t1));
	//printVetor("\nVetor ordenado:\n",vetor, n);
	free(vetor);
}