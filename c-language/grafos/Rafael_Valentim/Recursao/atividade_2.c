#include <stdio.h>

void maior(int *, int, int,  int *);

int main(int argc, char **argv){
	int  sample[] = {12, 1, 2, 3, 4, 5, 6, 7, 8, 9 ,10, 13, 14, 3};
	int size = sizeof(sample)/sizeof(int);
	int m;
	maior(sample,0, size, &m);
	printf("%d\n", m);
}

void maior(int * v, int i, int tam,  int* m){
	if(i ==0) *m = v[0];
	if(i < tam-1){
		if(v[i] > *m) *m = v[i];
		i++;
		maior(v, i, tam, m);
	}else{
		if(*m < v[i]) *m = v[i];
	}
}
