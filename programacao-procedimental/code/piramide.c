#include <stdio.h>
#include <stdlib.h>

int main(){
	int i = 1, j = 1, k, h;
	printf("Digite a  altura da piramide: ");
	scanf("%d", &h);

	for(i; i<=h; i++){
		for(k = 0; k< h - i; k++) printf(" ");
		k = 1;
		for(k; k <= j; k++) printf("%d", k <= i ? k : j+1 - k);
		j +=2;
		printf("\n");
	}
	return 0;
}
