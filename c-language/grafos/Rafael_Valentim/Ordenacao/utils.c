#include "utils.h"
void vetor_crescente(int *vec,int range, int size){
		int i;
		for(i =0; i< size; i++) vec[i] = (i%range)+1;
}
void vetor_decrescente(int *vec,int range, int size){
		int i;
		for(i =0; i< size; i++) vec[i] = range - (i%range);
}
void vetor_aleatorio(int *vec,int range, int size){
		int i;
		for(i =0; i< size; i++) vec[i] = (rand()%range) + 1;
}
void printVetor(char * text, int * vetor, int n){
	int i;
	printf("---------------------------\n%s\n", text);
	for(i =0; i<n; i++) printf("%02d%s", vetor[i], i%30 == 0 && i != 0 ? "\n" : ", ");
	printf("\n");
}

int toInt(char *str){
    int res = 0;
    for (int i = 0; str[i] != '\0'; ++i)
        res = res*10 + str[i] - '0';
    return res;
}

void test_rapida(void (*f)(int *, int, int), int * vec, int size){
	vetor_crescente(vec, 500, size);
	printf("Vetor Crescente\nNão Ordenado::  %d %d %d .. %d %d %d \n", vec[0], vec[1], vec[2], vec[size-3], vec[size-2], vec[size-1]);
	clock_t t_start = clock();
	f(vec, 0, size-1);
	clock_t t_final = clock();
	printf("Ordenado:: %d %d %d .. %d %d %d \n", vec[0], vec[1], vec[2], vec[size-3], vec[size-2], vec[size-1]);
	printf("Tempo: %lf\n\n" ,((double)(t_final - t_start)/(CLOCKS_PER_SEC/1000)));
	
	vetor_decrescente(vec, 500, size);
	printf("Vetor Decrescente\nNão Ordenado::  %d %d %d .. %d %d %d \n", vec[0], vec[1], vec[2], vec[size-3], vec[size-2], vec[size-1]);
	t_start = clock();
	f(vec, 0, size-1);
	t_final = clock();
	printf("Ordenado::  %d %d %d .. %d %d %d \n", vec[0], vec[1], vec[2], vec[size-3], vec[size-2], vec[size-1]);
	printf("Tempo: %lf\n\n" ,((double)(t_final - t_start)/(CLOCKS_PER_SEC/1000)));
	
	vetor_aleatorio(vec, 500, size);
	printf("Vetor Aleatorio\nNão Ordenado::  %d %d %d .. %d %d %d \n", vec[0], vec[1], vec[2], vec[size-3], vec[size-2], vec[size-1]);
	t_start = clock();
	f(vec, 0, size-1);
	t_final = clock();
	printf("Ordenado::  %d %d %d .. %d %d %d \n", vec[0], vec[1], vec[2], vec[size-3], vec[size-2], vec[size-1]);
	printf("Tempo: %lf\n" ,((double)(t_final - t_start)/(CLOCKS_PER_SEC/1000)));
	int i =0;
	while(i++ < 20)printf("--");
	printf("\n");
}

void test_normal(void (*f)(int *, int), int * vec, int size){
	vetor_crescente(vec, 500, size);
	printf("Vetor Crescente\nNão Ordenado:: %d %d %d .. %d %d %d \n", vec[0], vec[1], vec[2], vec[size-3], vec[size-2], vec[size-1]);
	int t_start = clock();
	f(vec, size);
	int t_final = clock();
	printf("Ordenado::  %d %d %d .. %d %d %d \n", vec[0], vec[1], vec[2], vec[size-3], vec[size-2], vec[size-1]);
	printf("Tempo: %lf\n\n" ,((double)(t_final - t_start)/(CLOCKS_PER_SEC/1000)));
	
	vetor_decrescente(vec,500, size);
	printf("Vetor Decrescente\nNão Ordenado::  %d %d %d .. %d %d %d \n", vec[0], vec[1], vec[2], vec[size-3], vec[size-2], vec[size-1]);
	t_start = clock();
	f(vec, size);
	t_final = clock();
	printf("Ordenado::  %d %d %d .. %d %d %d \n", vec[0], vec[1], vec[2], vec[size-3], vec[size-2], vec[size-1]);
	printf("Tempo: %lf\n\n" ,((double)(t_final - t_start)/(CLOCKS_PER_SEC/1000)));
	
	vetor_aleatorio(vec, 500, size);
	printf("Vetor Aleatorio\nNão Ordenado::  %d %d %d .. %d %d %d \n", vec[0], vec[1], vec[2], vec[size-3], vec[size-2], vec[size-1]);
	f(vec, size);
	t_final = clock();
	printf("Ordenado::  %d %d %d .. %d %d %d \n", vec[0], vec[1], vec[2], vec[size-3], vec[size-2], vec[size-1]);
	printf("Tempo: %lf\n" ,((double)(t_final - t_start)/(CLOCKS_PER_SEC/1000)));
	int i =0;
	while(i++ < 20)printf("--");
	printf("\n");

}

