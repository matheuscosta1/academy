#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/shm.h>
#include <semaphore.h>
#include <signal.h>
#include <pthread.h>
#include <time.h>

#define MEM_F1 4096
#define MEM_F2 4096

//Criando area de memoria compartilhada para f1
struct shared *f1_shared_area_ptr;
struct shared{
	sem_t mutex;	
	int num;
	int int_value[10];
	int PID;
};

//Criando area de memoria compartilhada para f1
struct shared_f2 *f2_shared_area_ptr;
struct shared_f2{	
	int num;
	int int_value[10];
	int counter_p5_p6;
	sem_t mutex;
	clock_t t0;
};

//Responsavel pelo envio de t1 a p5 via PIPE
int pipe01[2];

//Responsavel pelo envio de t1 a p6 via PIPE
int pipe02[2];

//Funcoes e variaiveis para o codigo singlethreads.c
void singleProcess();
int n;
int nF1;

//Funcoes e variaiveis para o codigo f1_to_pipe02.c
void process4(int p);
void* thread1 ( void *ptr );
void* thread2 ( void *ptr );

int max_values=1000, count = 0, size=0, counter_p5_p6=0;
int *moda = ((void*)0);
int *freq = ((void*)0);

//Variavel responsavel por contabilizar o tempo total
double total_time;

//Variaveis por tempo inicial e final
clock_t initial_time,final_time;

//funcao para interptetar os valores e definir a moda, valor maximo e minimo
void dates_interpreter(int in);

void* three_threads_p7 (void *ptr);

