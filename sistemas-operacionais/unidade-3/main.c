#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/shm.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <semaphore.h>
#include <pthread.h>
#include <signal.h>

struct shared_memory_f1 {
	int vetor[10]; //f1
	int pids[7]; //vetor de pids
	int tamanho, controle; //tamanho de f1, controle da f1
	sem_t mutex; //semáforo
};

struct shared_memory_f2 {
	int vetor[10]; //f1
	int pids[7]; //vetor de pids
	int tamanho, controle; //tamanho de f1, controle da f1
	sem_t mutex; //semáforo
};

int enfileira_f1();
int desenfileira_f1();
void consome_f1();
void thread_init_f1();

struct shared_memory_f1 *shared_memory_f1;
struct shared_memory_f2 *shared_memory_f2;


int enfileira_f1() {
	if(shared_memory_f1->controle) {
		sem_wait(&shared_memory_f1->mutex);
		int valor = rand() % 1000 + 1;
		int i;
		if(shared_memory_f1->tamanho < 10 && shared_memory_f1->controle) {
			printf("Processo de pid %d enfileirando em f1\n", getpid());
			shared_memory_f1->vetor[shared_memory_f1->tamanho] = valor;
			shared_memory_f1->tamanho++;
			printf("Vetor em %d: {", getpid());
			for(i = 0; i < shared_memory_f1->tamanho; i++) {
				printf("[%d] = %d",i , shared_memory_f1->vetor[i]);
				if(i != shared_memory_f1->tamanho - 1) printf(", ");
			}
			printf("}\n");
			sem_post(&shared_memory_f1->mutex);
			return 1;
		} else if ((shared_memory_f1->tamanho == 10 && shared_memory_f1->controle) || (shared_memory_f1->tamanho > 0 && !shared_memory_f1->controle)) {
			printf("Processo %d solicitando a fila esvaziar: %d\n", getpid(), shared_memory_f1->tamanho);
			shared_memory_f1->controle = 0;
			sem_post(&shared_memory_f1->mutex);
			kill(shared_memory_f1->pids[3], SIGUSR1);
			return 0;
		} else if (shared_memory_f1->tamanho == 0 && shared_memory_f1->controle){
			shared_memory_f1->controle = 1;
			sem_post(&shared_memory_f1->mutex);
			return 1;
		}
	}  else {
		return -1;
	}
}

int enfileira_f2(int valor) {
	if(shared_memory_f2->controle) {
		sem_wait(&shared_memory_f2->mutex);
		int valor = rand() % 1000 + 1;
		int i;
		if(shared_memory_f2->tamanho < 10 && shared_memory_f2->controle) {
			printf("Processo de pid %d enfileirando em f2\n", getpid());
			shared_memory_f2->vetor[shared_memory_f2->tamanho] = valor;
			shared_memory_f2->tamanho++;
			printf("Vetor em %d: {", getpid());
			for(i = 0; i < shared_memory_f2->tamanho; i++) {
				printf("[%d] = %d",i , shared_memory_f2->vetor[i]);
				if(i != shared_memory_f2->tamanho - 1) printf(", ");
			}
			printf("}\n");
			sem_post(&shared_memory_f2->mutex);
			desenfileira_f2();
			return 1;
		} else if ((shared_memory_f2->tamanho == 10 && shared_memory_f2->controle) || (shared_memory_f2->tamanho > 0 && !shared_memory_f2->controle)) {
			printf("Processo %d solicitando a fila esvaziar: %d\n", getpid(), shared_memory_f2->tamanho);
			shared_memory_f2->controle = 0;
			sem_post(&shared_memory_f2->mutex);
			kill(shared_memory_f1->pids[6], SIGUSR1);
			return 0;
		} else if (shared_memory_f2->tamanho == 0 && shared_memory_f2->controle){
			shared_memory_f2->controle = 1;
			sem_post(&shared_memory_f2->mutex);
			return 1;
		}
	}  else {
		return -1;
	}
}

int desenfileira_f1() {
	int i, valor;
	if(shared_memory_f1->tamanho > 0) {
		printf("Processo de pid %d desenfileirando em f1, tamanho da fila: %d\n", getpid(), shared_memory_f1->tamanho);
		valor = shared_memory_f1->vetor[0];
		printf("Removendo o valor %d da fila\n", valor);
		shared_memory_f1->tamanho --;
		for(i = 0; i < shared_memory_f1->tamanho; i++) {
			shared_memory_f1->vetor[i] = shared_memory_f1->vetor[i+1];
		}

		printf("Vetor em %d: {", getpid());
		for(i = 0; i < shared_memory_f1->tamanho; i++) {
			printf("[%d] = %d",i , shared_memory_f1->vetor[i]);
			if(i == shared_memory_f1->tamanho - 2) printf(", ");
		}
		printf("}\n");
		return valor;
	}
	return -1;
}

int desenfileira_f2() {
	int i, valor;
	if(shared_memory_f2->tamanho > 0) {
		printf("Processo de pid %d desenfileirando em f2, tamanho da fila: %d\n", getpid(), shared_memory_f2->tamanho);
		valor = shared_memory_f2->vetor[0];
		printf("Removendo o valor %d da fila\n", valor);
		shared_memory_f2->tamanho --;
		for(i = 0; i < shared_memory_f2->tamanho; i++) {
			shared_memory_f2->vetor[i] = shared_memory_f2->vetor[i+1];
		}

		printf("Vetor em %d: {", getpid());
		for(i = 0; i < shared_memory_f2->tamanho; i++) {
			printf("[%d] = %d",i , shared_memory_f2->vetor[i]);
			if(i == shared_memory_f2->tamanho - 2) printf(", ");
		}
		printf("}\n");
		return valor;
	}
	return -1;
}

void consome_f1() {
	int i;

    int contador = 0;

	for (i = 0; i < 5; i++) {
		sem_wait(&shared_memory_f1->mutex);
		int valor = desenfileira_f1();
		enfileira_f2(valor);
		sem_post(&shared_memory_f1->mutex);
		sleep(1);
	}
	shared_memory_f1->controle = 1;
}

void thread_init_f1() {
	int i;
	pthread_t threads[2];
	for (i = 0; i < 2; i++) {
		pthread_create(&threads[i], NULL, (void*) consome_f1, NULL);
	}
	for(i = 0; i < 2; i++) {
		pthread_join(threads[i], NULL);
	}
}

void consome_f2() {
	int i;

    sem_wait(&shared_memory_f2->mutex);
    desenfileira_f2();
    sem_post(&shared_memory_f2->mutex);
    sleep(1);

	shared_memory_f1->controle = 1;
}

void thread_init_f2() {
	int i;
	pthread_t threads[3];
	for (i = 0; i < 3; i++) {
		pthread_create(&threads[i], NULL, (void*) consome_f2, NULL);
	}
	for(i = 0; i < 3; i++) {
		pthread_join(threads[i], NULL);
	}
}

int main() {
	int status;
	int i, segment_id_f1, segment_size_f1 = sizeof(struct shared_memory_f1*);
	int segment_id_f2, segment_size_f2 = sizeof(struct shared_memory_f2*);
	pid_t pai = getpid();
	int canal[2];


	//iniciando memória compartilhada
	segment_id_f1 = shmget(IPC_PRIVATE, segment_size_f1, IPC_CREAT | 0666); //
	shared_memory_f1 = (struct shared_memory_f1*) shmat(segment_id_f1, 0, 0);
	shmctl(segment_id_f1, IPC_STAT, NULL);
	shared_memory_f1->tamanho = 0; //tamanho f1
	shared_memory_f1->controle = 1; //define a fila como enchendo na inicialização

	segment_id_f2 = shmget(IPC_PRIVATE, segment_size_f2, IPC_CREAT | 0666); //
	shared_memory_f2 = (struct shared_memory_f2*) shmat(segment_id_f2, 0, 0);
	shmctl(segment_id_f2, IPC_STAT, NULL);
	shared_memory_f2->tamanho = 0; //tamanho f2
	shared_memory_f2->controle = 1; //define a fila como enchendo na inicialização

	//semáforo
	sem_init(&shared_memory_f1->mutex, 1, 1); //endereço do semaforo, 0- compartilhado entre threads e 1 - compartilhado entre processos, valor inicial do semáforo
    sem_init(&shared_memory_f2->mutex, 1, 1);

	int random;

	pid_t pids[7] = {-1};

	for(i = 0; i < 7; i++) {
		if(getpid() == pai) {
			pids[i] = fork();
		} else
			break;
	}

	if(getpid() == pai) {
		for(i = 0; i < 7; i++) {
			shared_memory_f1->pids[i] = pids[i];
		}
		printf("Vetor de pids: {");
		for(i = 0; i < 7; i++) {
			printf("%d", shared_memory_f1->pids[i]);
			if (i != 6) printf(", ");
		}
		printf("}\n");
	} else if(pids[0] == 0) { //p1
		srand(1234);
		for(;;) {
			enfileira_f1();
			sleep(1);
		}
	} else if(pids[1] == 0) { //p2
		srand(4321);
 		for(;;) {
			enfileira_f1();
			sleep(1);
		}
 	} else if(pids[2] == 0) { //p3
 		srand(1423);
 		for(;;) {
			enfileira_f1();
			sleep(1);
		}
	} else if(pids[3] == 0) { //p4
		for(;;) {
			signal(SIGUSR1, thread_init_f1);
		}
	} else if(pids[4] == 0) { //p5

	} else if(pids[5] == 0) { //p6

	} else if(pids[6] == 0) { //p7
        for(;;) {
			signal(SIGUSR1, thread_init_f2);
		}
	}
	shmdt(shared_memory_f1);
    shmdt(shared_memory_f2);
	if(getpid() == pai) {
		for(i = 0; i < 7; i++) {
			wait(&status);
		}
		sem_destroy(&shared_memory_f1->mutex);
		sem_destroy(&shared_memory_f2->mutex);
		shmctl(segment_id_f1, IPC_RMID, 0);
		shmctl(segment_id_f2, IPC_RMID, 0);
	}

	return 0;
}
