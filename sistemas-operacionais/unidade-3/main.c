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

#define QUANTIDADE_EXECUCAO 100

int thread_id[1];

int contador_p5, contador_p6, contador_total;

clock_t tempo_inicial;

struct timeval  tv1, tv2;

struct shared_memory_fila_01 {
	int valores_fila[10];
	int pids[7];
	int pai;
	int tamanho, controle;
	sem_t mutex;
	int pipe_01[2], pipe_02[2];
	int valor, valor2;
	int contador_p5, contador_p6;
};

struct shared_memory_fila_02 {
	int vetor[10];
	int pids[7];
	int tamanho, controle;
	int contador_total;
	int vetor_valores_desenfileirados[QUANTIDADE_EXECUCAO];
	int tamanhoVetor;
};

int enfileira_fila_01();
void consome_fila_01_e_envia_para_p5_via_pipe_01();
void thread_init_fila_01();

struct shared_memory_fila_01 *shared_memory_fila_01;
struct shared_memory_fila_02 *shared_memory_fila_02;


int enfileira_fila_01() {
	if(shared_memory_fila_01->controle) {
		sem_wait(&shared_memory_fila_01->mutex);
		int valor = rand() % 1000 +1;
		int i;
		if(shared_memory_fila_01->tamanho < 10 && shared_memory_fila_01->controle) {
			shared_memory_fila_01->valores_fila[shared_memory_fila_01->tamanho] = valor;
			shared_memory_fila_01->tamanho++;

			if(shared_memory_fila_01->tamanho == 10){
                printf("\n[Processo P1|P2|P3 - PID: %d] - [Fila 01] - [Enfileirando]: Vetor: {", getpid());
                for(i = 0; i < shared_memory_fila_01->tamanho; i++) {
                    printf("[%d] = %d",i , shared_memory_fila_01->valores_fila[i]);
                    if(i != shared_memory_fila_01->tamanho - 1) printf(", ");
                }
                printf("}\n");
			}
			sem_post(&shared_memory_fila_01->mutex);
			return 1;
		} else if ((shared_memory_fila_01->tamanho == 10 && shared_memory_fila_01->controle) || (shared_memory_fila_01->tamanho > 0 && !shared_memory_fila_01->controle)) {
            printf("\n[Processo P1|P2|P3 - PID: %d] - [Fila 01] - Solicitando esvaziar: %d\n", getpid(), shared_memory_fila_01->tamanho);
			shared_memory_fila_01->controle = 0;
			sem_post(&shared_memory_fila_01->mutex);
			kill(shared_memory_fila_01->pids[3], SIGUSR1);
			return 0;
		} else if (shared_memory_fila_01->tamanho == 0 && shared_memory_fila_01->controle){
			shared_memory_fila_01->controle = 1;
			sem_post(&shared_memory_fila_01->mutex);
			return 1;
		}
	}  else {
		return -1;
	}
}

int enfileira_fila_02(int valor) {
	if(shared_memory_fila_02->controle) {
		int i;
		if(shared_memory_fila_02->tamanho < 10 && shared_memory_fila_02->controle) {
			shared_memory_fila_02->vetor[shared_memory_fila_02->tamanho] = valor;
			shared_memory_fila_02->tamanho++;

            printf("\n[Processo P5|P6 - PID: %d] - [Fila 02] - [Enfileirando] Vetor: {", getpid());
            for(i = 0; i < shared_memory_fila_02->tamanho; i++) {
                printf("[%d] = %d",i , shared_memory_fila_02->vetor[i]);
                if(i != shared_memory_fila_02->tamanho - 1) printf(", ");
            }
            printf("}\n\n");

			signal(shared_memory_fila_01->pids[6], SIGUSR1);
			return 1;
		} else if ((shared_memory_fila_02->tamanho == 10 && shared_memory_fila_02->controle) || (shared_memory_fila_02->tamanho > 0 && !shared_memory_fila_02->controle)) {
            printf("\n[Processo P5|P6 - PID: %d] - [Fila 02] - Solicitando esvaziar: %d\n", getpid(), shared_memory_fila_02->tamanho);
			shared_memory_fila_02->controle = 0;
			kill(shared_memory_fila_01->pids[6], SIGUSR1);
			return 0;
		} else if (shared_memory_fila_02->tamanho == 0 && shared_memory_fila_02->controle){
			shared_memory_fila_02->controle = 1;
			return 1;
		}
	}  else {
		return -1;
	}
}

int desenfileira_fila_01() {
	int i, valor;
	if(shared_memory_fila_01->tamanho > 0) {

		valor = shared_memory_fila_01->valores_fila[0];

		shared_memory_fila_01->tamanho --;

		for(i = 0; i < shared_memory_fila_01->tamanho; i++) {
			shared_memory_fila_01->valores_fila[i] = shared_memory_fila_01->valores_fila[i+1];
		}

        if(shared_memory_fila_01->tamanho == 10){
            printf("\n[Processo P4 - PID: %d] - [Fila 01] - [Desenfileirando] - Vetor em %d: {", getpid());
            for(i = 0; i < shared_memory_fila_01->tamanho; i++) {
                printf("[%d] = %d",i , shared_memory_fila_01->valores_fila[i]);
                if(i == shared_memory_fila_01->tamanho - 2) printf(", ");
            }
            printf("}\n");
        }

		return valor;
	}
	return -1;
}

int desenfileira_fila_02() {
	int i, valor, contador=0;
	if(shared_memory_fila_02->tamanho > 0) {

		valor = shared_memory_fila_02->vetor[0];

		shared_memory_fila_02->tamanho --;

		for(i = 0; i < shared_memory_fila_02->tamanho; i++) {
			shared_memory_fila_02->vetor[i] = shared_memory_fila_02->vetor[i+1];
		}

		if(shared_memory_fila_02->tamanho == 10){
            printf("\n[Processo P7 - PID: %d] - [Fila 02] - [Desenfileirando] - Vetor: {", getpid());
            for(i = 0; i < shared_memory_fila_02->tamanho; i++) {
                printf("[%d] = %d",i , shared_memory_fila_02->vetor[i]);
                if(i == shared_memory_fila_02->tamanho - 2) printf(", ");
            }
            printf("}\n");
        }

        sem_wait(&shared_memory_fila_01->mutex);
        shared_memory_fila_02->vetor_valores_desenfileirados[shared_memory_fila_02->tamanhoVetor] = valor;
        printf("\n[Processo P7 - PID: %d] - [Fila 2] - O valor %d foi desenfileirado\t[Contador: %d]\n", getpid(), shared_memory_fila_02->vetor_valores_desenfileirados[shared_memory_fila_02->tamanhoVetor], shared_memory_fila_02->tamanhoVetor);
        shared_memory_fila_02->tamanhoVetor++;
        sem_post(&shared_memory_fila_01->mutex);

        if(shared_memory_fila_02->tamanhoVetor == QUANTIDADE_EXECUCAO){
            printf("\n\nRelatorio apos o consumo de %d valores da Fila 02: \n\n", QUANTIDADE_EXECUCAO);
            gettimeofday(&tv2, NULL);
            printf("Tempo total de execucao: %f segundos.\n", (double) (tv2.tv_usec - tv1.tv_usec) / 1000000 + (double) (tv2.tv_sec - tv1.tv_sec));
            printf("Total de valores processados por P5: %d.\nTotal de valores processados por P6: %d.\n", shared_memory_fila_01->contador_p5, shared_memory_fila_01->contador_p6);
            calcula_valor_maximo_e_valor_minimo(shared_memory_fila_02->vetor_valores_desenfileirados);
            calcula_moda(shared_memory_fila_02->vetor_valores_desenfileirados);
            kill(0, SIGTERM);
        }

		return valor;
	}
	return -1;
}

void consome_fila_01_e_envia_para_p5_via_pipe_01() {
    int valor;
    int i;

    for(i = 0; i < 2; i++) {
		sem_wait(&shared_memory_fila_01->mutex);
        shared_memory_fila_01->valor = desenfileira_fila_01();
        printf("\n[Processo P4 - PID: %d] - Está consumindo da fila 01 e enviando para o Pipe 01 o valor: %d e variável de controle: %d\n", getpid(), shared_memory_fila_01->valor, shared_memory_fila_01->controle );
        sem_post(&shared_memory_fila_01->mutex);

        write(shared_memory_fila_01->pipe_01[1], &shared_memory_fila_01->valor, sizeof(int)*sizeof(shared_memory_fila_01->valor));
        kill(shared_memory_fila_01->pids[4], SIGUSR1);
        sleep(1);

	}
	sem_wait(&shared_memory_fila_01->mutex);
	shared_memory_fila_01->controle = 1;
	sem_post(&shared_memory_fila_01->mutex);
}

void consome_fila_01_e_envia_para_p6_via_pipe_02() {
    int valor;
    int i;

    for(i = 0; i < 2; i++) {
		sem_wait(&shared_memory_fila_01->mutex);
        shared_memory_fila_01->valor2 = desenfileira_fila_01();
        printf("\n[Processo P4 - PID: %d] - Está consumindo da fila 01 e enviando para o Pipe 02 o valor: %d e variável de controle: %d\n", getpid(), shared_memory_fila_01->valor2, shared_memory_fila_01->controle);

        sem_post(&shared_memory_fila_01->mutex);

        write(shared_memory_fila_01->pipe_02[1], &shared_memory_fila_01->valor2, sizeof(int)*sizeof(shared_memory_fila_01->valor2));
        kill(shared_memory_fila_01->pids[5], SIGUSR1);
        sleep(1);
	}
	sem_wait(&shared_memory_fila_01->mutex);
	shared_memory_fila_01->controle = 1;
	sem_post(&shared_memory_fila_01->mutex);
}

void thread_init_fila_01() {
	pthread_t threads[2];
    int i;

	pthread_create(&threads[0], NULL, (void*) consome_fila_01_e_envia_para_p5_via_pipe_01, NULL);
	pthread_create(&threads[1], NULL, (void*) consome_fila_01_e_envia_para_p6_via_pipe_02, NULL);

	for(i = 0; i < 2; i++) {
		pthread_join(threads[i], NULL);
	}
}

void consome_fila_02() {
    for(int i = 0; i < 3; i++) {
        desenfileira_fila_02();
        sleep(1);
    }

	shared_memory_fila_02->controle = 1;
}

void thread_init_f2() {
	pthread_t threads[3];
	for(int i = 0; i < 3; i++) {
		pthread_create(&threads[i], NULL, (void*) consome_fila_02, NULL);
	}
	for(int i = 0; i < 3; i++) {
		pthread_join(threads[i], NULL);
	}
}

void p5_process(){
    read(shared_memory_fila_01->pipe_01[0],&shared_memory_fila_01->valor,sizeof(int)*sizeof(shared_memory_fila_01->valor));
    printf("\n[Processo P5 - PID: %d] - Está enfileirando na Fila 02 o valor: %d\n", getpid(), shared_memory_fila_01->valor);
    shared_memory_fila_01->contador_p5++;
    enfileira_fila_02(shared_memory_fila_01->valor);
    close(shared_memory_fila_01->pipe_01[0]);
}


void p6_process(){
    read(shared_memory_fila_01->pipe_02[0],&shared_memory_fila_01->valor2,sizeof(int)*sizeof(shared_memory_fila_01->valor2));
    printf("\n[Processo P6 - PID: %d] - Está enfileirando na Fila 02 o valor: %d\n", getpid(), shared_memory_fila_01->valor2);
    shared_memory_fila_01->contador_p6++;
    enfileira_fila_02(shared_memory_fila_01->valor2);
    close(shared_memory_fila_01->pipe_02[0]);
}

void calcula_moda(float vetor[]){
	int tamanho = shared_memory_fila_02->tamanhoVetor;
	int iterador_1, iterador_2, contador[tamanho];
	float conta, moda;

    /**printf("\n[Calculo da Moda]\n Vetor: {");
    for(int i=0; i < tamanho; i++){
        printf("[%d] = %d,", i, shared_memory_fila_02->vetor_valores_desenfileirados[i]);
    }
    printf("}\n");**/

	for(iterador_1=0; iterador_1 < tamanho; iterador_1++){
        for(iterador_2 = iterador_1+1; iterador_2 < tamanho; iterador_2++){
			if(shared_memory_fila_02->vetor_valores_desenfileirados[iterador_1] == shared_memory_fila_02->vetor_valores_desenfileirados[iterador_2]){
				contador[iterador_1]++;
					if(contador[iterador_1] > conta){
						conta = contador[iterador_1];
						moda = shared_memory_fila_02->vetor_valores_desenfileirados[iterador_1];
					}
			}

        }
        contador[iterador_1] = 0;
    }
    if(conta == 0){
    	printf("\nNao existe moda.\n");
	}
	else{
		printf("\nA moda eh: %.0f.\n", moda);
	}
}

void calcula_valor_maximo_e_valor_minimo(int *vetor){
    int maximo, minimo;
    int tamanho = QUANTIDADE_EXECUCAO;

    for(int iterator=0; iterator < tamanho; iterator++){
        if (iterator == 0)
            maximo = minimo = shared_memory_fila_02->vetor_valores_desenfileirados[iterator];
        else {
            if (shared_memory_fila_02->vetor_valores_desenfileirados[iterator] > maximo)
                maximo = shared_memory_fila_02->vetor_valores_desenfileirados[iterator];
            if (shared_memory_fila_02->vetor_valores_desenfileirados[iterator] < minimo)
                minimo = shared_memory_fila_02->vetor_valores_desenfileirados[iterator];
        }
    }

    printf("O valor maximo eh: %d e o valor minimo eh: %d.", maximo, minimo);

}


int main() {
    gettimeofday(&tv1, NULL);
	int status;
	int i, segment_id_f1, segment_size_f1 = sizeof(struct shared_memory_fila_01*);
	int segment_id_f2, segment_size_f2 = sizeof(struct shared_memory_fila_02*);
	pid_t pai = getpid();
	int valor;


	segment_id_f1 = shmget(IPC_PRIVATE, segment_size_f1*QUANTIDADE_EXECUCAO, IPC_CREAT | 0666); //
	shared_memory_fila_01 = (struct shared_memory_fila_01*) shmat(segment_id_f1, 0, 0);
	shmctl(segment_id_f1, IPC_STAT, NULL);
	shared_memory_fila_01->tamanho = 0;
	shared_memory_fila_01->controle = 1;

	segment_id_f2 = shmget(IPC_PRIVATE, segment_size_f2*QUANTIDADE_EXECUCAO, IPC_CREAT | 0666); //
	shared_memory_fila_02 = (struct shared_memory_fila_02*) shmat(segment_id_f2, 0, 0);
	shmctl(segment_id_f2, IPC_STAT, NULL);
	shared_memory_fila_02->tamanho = 0;
	shared_memory_fila_02->controle = 1;
    shared_memory_fila_02->tamanhoVetor = 0;

	//semáforo
	sem_init(&shared_memory_fila_01->mutex, 1, 1);

    if ( pipe(shared_memory_fila_01->pipe_01) == -1 ){ printf("Erro pipe()"); return -1; }
    if ( pipe(shared_memory_fila_01->pipe_02) == -1 ){ printf("Erro pipe()"); return -1; }

    shared_memory_fila_01->contador_p5 = 0;
    shared_memory_fila_01->contador_p6 = 0;
    shared_memory_fila_02->contador_total = 0;

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
			shared_memory_fila_01->pids[i] = pids[i];
		}
	} else if(pids[0] == 0) {
		srand(1234);
		for(;;) {
			enfileira_fila_01();
			sleep(1);
		}
	} else if(pids[1] == 0) {
		srand(4321);
 		for(;;) {
			enfileira_fila_01();
			sleep(1);
		}
 	} else if(pids[2] == 0) {
 		srand(1423);
 		for(;;) {
			enfileira_fila_01();
			sleep(1);
		}
	} else if(pids[3] == 0) {
		for(;;) {
			signal(SIGUSR1, thread_init_fila_01);
			sleep(1);
		}
	} else if(pids[4] == 0) {
        for(;;){
            signal(SIGUSR1, p5_process);
        }

	} else if(pids[5] == 0) {
        for(;;){
            signal(SIGUSR1, p6_process);
        }
	} else if(pids[6] == 0) {
        for(;;) {
			thread_init_f2();
			sleep(1);
		}
	}

	shmdt(shared_memory_fila_01);
    shmdt(shared_memory_fila_02);
	if(getpid() == pai) {
		for(i = 0; i < 7; i++) {
			wait(&status);
		}
		sem_destroy(&shared_memory_fila_01->mutex);
		shmctl(segment_id_f1, IPC_RMID, 0);
		shmctl(segment_id_f2, IPC_RMID, 0);
	}

	exit(0);
}
