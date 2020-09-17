#include <stdio.h>
#include <time.h>

int fibonacci_rec(int);
int fibonacci_ite(int);
int toInt(char *);

int main(int argc, char **argv){
	time_t t1, t2;
	int count = toInt(argv[1]);	
	double intervalo = 0;
	
	time(&t1);
	int f_r =fibonacci_rec(count);
	time(&t2);

	intervalo = difftime(t2, t1);
	printf("Fibonacci recursivo: %f segundos\nValor: %d\n", intervalo, f_r);

	time(&t1);
	int f_i = fibonacci_ite(count);
	
	time(&t2);
	
	intervalo = difftime(t2, t1);
	printf("Fibonacci iterativo: %f segundos\nValor: %d\n", intervalo, f_i);
	
	return 0;
}
int fibonacci_rec(int n) {
	if (n < 2) return n;
	else return (fibonacci_rec(n-1) + fibonacci_rec(n-2));
}

int fibonacci_ite(int n) {
	int k, i = 1, F = 0;
	for (k = 1; k <= n; k++) {
		F = F + i;
		i = F - i;
	}
	return F;
}

int toInt(char *str)
{
    int res = 0;
    for (int i = 0; str[i] != '\0'; ++i)
        res = res*10 + str[i] - '0';
    return res;
}
