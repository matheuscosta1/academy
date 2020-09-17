import time
import sys

def fib(n):
	if n <= 2 : return 1
	else : return (fib(n-1) + fib(n-2));

def fib_i(n):
	i = 1;
	aux = 1
	F = 0
	for i in range(n):
		F = F + aux;
		aux = F - aux;
	return F


if __name__ == '__main__':
	ns = sys.argv[1:]

	for i in range(len(ns)):
		n = int(ns[i])
		print("\nPara n=", n)
		start = time.time()*1000
		f_1 = fib(n);
		elapsed = time.time()*1000
		print("--Recursivo--\nValor:", f_1, "\nDelay: ", elapsed-start)

		start = time.time()*1000
		f_1 = fib_i(n);
		elapsed = time.time()*1000
		print("--Iterativo--\nValor:", f_1, "\nDelay: ", elapsed-start)
