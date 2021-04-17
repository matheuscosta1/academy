#include <stdio.h>

int main(){
	int x,y, ac = 1 ,divisor = 1;
	printf("Digite dois numeros inteiros(x y): ");
	scanf("%d%d", &x,&y);

	while(divisor < x/10) 	divisor *=10;
	printf("%d ", x);
	ac = x;
	while(1){
		ac = ac*(x/divisor);
		x %= divisor;
		divisor /= 10;
		if(x  == 0)break;

	}
	if(ac == y) printf("eh semente de %d",y);
	else printf(" nao eh semente de %d", y);
	return 0;
}
