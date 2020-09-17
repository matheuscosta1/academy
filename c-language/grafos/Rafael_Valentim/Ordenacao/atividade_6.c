#include "ordenacoes.h"
#include "utils.h"

void main(int agrc, char ** argv){
	srand(time(NULL));

	int n = 10;
	int * vetor = malloc(sizeof(int)*n);
	vetor_aleatorio(vetor, n, n);

	printVetor("\nVetor ordenado:\n", vetor, n);
	int * outro_vetor= selection_sort_ind(vetor, n);
	printVetor("\nVetor ordenado:\n",outro_vetor, n);

	free(vetor);
}