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

#define QUANTIDADE_EXECUCAO 10000

struct timeval  tv1, tv2; //variáveis para estipular o tempo de execução

struct shared_memory_fila_01 {
	int valores_fila[10]; //define tamanho da fila 01
	int pids[7]; //processos filhos
	int tamanho; //controla o tamanho que está a fila
	sem_t mutex; //semáforo
	int pipe_01[2], pipe_02[2]; //pipe que será utilizado para trafegar informações entre a fila 01 e a fila 02 a partir do processo P4 enviando valores para P5 e P6
	int valor, valor2; //utilizado para armazenar valores do pipe
	int contador_p5, contador_p6; //contador para sabermos quantas vezes o processo P5 e processo P6, processaram
}; //struct que representa a fila 01

struct shared_memory_fila_02 {
	int vetor[10]; //define tamanho da fila 02
	int pids[7]; //processos filhos
	int tamanho, controle; //controla o tamanho que está a fila
	int vetor_valores_desenfileirados[QUANTIDADE_EXECUCAO]; //armazena valores que foram desenfileirados da fila 02 para ser calculado, posteriormente, a moda e o valor máximo e mínimo
	int quantidadeValoresDesenfileirados; // controla a quantidade de registros que foram desenfileirados da fila 02
}; //struct que representa a fila 02


struct shared_memory_fila_01 *shared_memory_fila_01; //define um ponteiro para a fila 01
struct shared_memory_fila_02 *shared_memory_fila_02; //define um ponteiro para a fila 02


int enfileira_fila_01() {

    sem_wait(&shared_memory_fila_01->mutex); //semáforo bloquea a região crítica
    int valor = rand() % 1000 +1; //gera valores randômicos de 1 a 1000
    int i;
    if(shared_memory_fila_01->tamanho < 10) {
        shared_memory_fila_01->valores_fila[shared_memory_fila_01->tamanho] = valor; // enfileira o valor gerado na fila 01 caso a fila não esteja cheia
        shared_memory_fila_01->tamanho++; //incrementa o tamanho da fila 01

        if(shared_memory_fila_01->tamanho == 10){ //verifica se a fila está cheia para printar os valores atuais que estão na fila 01
            printf("\n[Processo P1|P2|P3 - PID: %d] - [Fila 01] - [Enfileirando]: Vetor: {", getpid());
            for(i = 0; i < shared_memory_fila_01->tamanho; i++) {
                printf("[%d] = %d",i , shared_memory_fila_01->valores_fila[i]);
                if(i != shared_memory_fila_01->tamanho - 1) printf(", ");
            }
            printf("}\n");
        }
        sem_post(&shared_memory_fila_01->mutex); //libera o semáforo
        return 1;
    } else if ((shared_memory_fila_01->tamanho == 10)) { //verifica se a fila está cheia
        printf("\n[Processo P1|P2|P3 - PID: %d] - [Fila 01] - Solicitando esvaziar: %d\n", getpid(), shared_memory_fila_01->tamanho);
        sem_post(&shared_memory_fila_01->mutex); //libera o semáforo
        kill(shared_memory_fila_01->pids[3], SIGUSR1); //manda um sinal para o processo P4 começar a desenfileirar da fila 01
        return 0;
    } else if (shared_memory_fila_01->tamanho == 0){
        sem_post(&shared_memory_fila_01->mutex); //caso a fila esteja vazia, então libera o semáforo.
        return 1;
    }
	else {
		return -1;
	}
}

int enfileira_fila_02(int valor) {
	if(shared_memory_fila_02->controle) { //variável de controle que diz se pode ou não enfileirar na fila
		int i;
		if(shared_memory_fila_02->tamanho < 10) {
			shared_memory_fila_02->vetor[shared_memory_fila_02->tamanho] = valor; // enfileira o valor gerado na fila 02 caso a fila não esteja cheia
			shared_memory_fila_02->tamanho++;

            printf("\n[Processo P5|P6 - PID: %d] - [Fila 02] - [Enfileirando] Vetor: {", getpid());  //verifica se a fila está cheia para printar os valores atuais que estão na fila 02
            for(i = 0; i < shared_memory_fila_02->tamanho; i++) {
                printf("[%d] = %d",i , shared_memory_fila_02->vetor[i]);
                if(i != shared_memory_fila_02->tamanho - 1) printf(", ");
            }
            printf("}\n\n");

			signal(shared_memory_fila_01->pids[6], SIGUSR1);  //manda um sinal para o processo P7 começar a desenfileirar da fila 02
			return 1;
		} else if ((shared_memory_fila_02->tamanho == 10 && shared_memory_fila_02->controle)) {
            printf("\n[Processo P5|P6 - PID: %d] - [Fila 02] - Solicitando esvaziar: %d\n", getpid(), shared_memory_fila_02->tamanho); //caso a fila 2 esteja cheia, então manda-se um sinal para P7 começar a desenfileirar da fila 02
			shared_memory_fila_02->controle = 0; //bloquea o acesso a fila enquanto não for tirado um elemento da fila 02
			kill(shared_memory_fila_01->pids[6], SIGUSR1); //manda um sinal para o processo P7 começar a desenfileirar da fila 02
			return 0;
		} else if (shared_memory_fila_02->tamanho == 0){
			shared_memory_fila_02->controle = 1; //caso a fila 02 esteja vazia, então pode-se continuar a colocar elementos na fila 02
			return 1;
		}
	}  else {
		return -1;
	}
}

int desenfileira_fila_01() {
	int i, valor;
	if(shared_memory_fila_01->tamanho > 0) {

		valor = shared_memory_fila_01->valores_fila[0]; // atribui à variável valor o primeiro valor da fila 01

		shared_memory_fila_01->tamanho --; //decrementa o tamanho da fila 01

		for(i = 0; i < shared_memory_fila_01->tamanho; i++) {
			shared_memory_fila_01->valores_fila[i] = shared_memory_fila_01->valores_fila[i+1]; // move os valores que sobraram da fila 01 uma casa para a esquerda, no array de elementos
		}

        if(shared_memory_fila_01->tamanho == 10){ //verifica se a fila está cheia para printar os valores atuais que estão na fila 01
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

		valor = shared_memory_fila_02->vetor[0]; // atribui à variável valor o primeiro valor da fila 02

		shared_memory_fila_02->tamanho --; //decrementa o tamanho da fila 02

		for(i = 0; i < shared_memory_fila_02->tamanho; i++) {
			shared_memory_fila_02->vetor[i] = shared_memory_fila_02->vetor[i+1]; // move os valores que sobraram da fila 02 uma casa para a esquerda, no array de elementos
		}


        printf("\n[Processo P7 - PID: %d] - [Fila 02] - [Desenfileirando] - Vetor: {", getpid()); //printa o tamanho da fila 02
        for(i = 0; i < shared_memory_fila_02->tamanho; i++) {
            printf("[%d] = %d",i , shared_memory_fila_02->vetor[i]);
            if(i == shared_memory_fila_02->tamanho - 2) printf(", ");
        }
        printf("}\n");


        sem_wait(&shared_memory_fila_01->mutex);//define região crítica
        shared_memory_fila_02->vetor_valores_desenfileirados[shared_memory_fila_02->quantidadeValoresDesenfileirados] = valor; //coloca no vetor de desenfileirados o valor desenfileirado da fila 02
        printf("\n[Processo P7 - PID: %d] - [Fila 2] - O valor %d foi desenfileirado\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t[Contador: %d]\n", getpid(), shared_memory_fila_02->vetor_valores_desenfileirados[shared_memory_fila_02->quantidadeValoresDesenfileirados], shared_memory_fila_02->quantidadeValoresDesenfileirados);
        shared_memory_fila_02->quantidadeValoresDesenfileirados++; //aumenta o contador de valores desenfileirados
        shared_memory_fila_02->controle = 1; //define a variável controle como 1, que diz que se pode enfileirar mais elementos na fila 02
        sem_post(&shared_memory_fila_01->mutex); //libera região crítica

        if(shared_memory_fila_02->quantidadeValoresDesenfileirados == QUANTIDADE_EXECUCAO){ //imprime um relatório a partir de 10000 valores desenfileirados da fila 02
            printf("\n\nRelatorio apos o consumo de %d elementos da Fila 02: \n\n", QUANTIDADE_EXECUCAO);
            gettimeofday(&tv2, NULL); //pega o tempo até esse momento da execução do programa
            printf("Tempo total de execucao: %f segundos.\n", (double) (tv2.tv_usec - tv1.tv_usec) / 1000000 + (double) (tv2.tv_sec - tv1.tv_sec)); //calcula tempo decorrido de execução
            printf("Total de valores processados por P5: %d.\nTotal de valores processados por P6: %d.\n", shared_memory_fila_01->contador_p5, shared_memory_fila_01->contador_p6); //valores processados por P5 e P6 da fila 01
            calcula_valor_maximo_e_valor_minimo(shared_memory_fila_02->vetor_valores_desenfileirados); //calcula valor maximo e valor minimo que foram processados pela fila 02.
            calcula_moda(shared_memory_fila_02->vetor_valores_desenfileirados); //calcula a moda da quantidade de valores desenfileirados.
            kill(0, SIGTERM);
        }

		return valor;
	}
	return -1;
}

void consome_fila_01_e_envia_para_p5_via_pipe_01() {
    int valor;
    int i;

    for(i = 0; i < 5; i++) {
		sem_wait(&shared_memory_fila_01->mutex); //define regiao crítica
        shared_memory_fila_01->valor = desenfileira_fila_01(); //processo P4 desenfileira da fila 01
        printf("\n[Processo P4 - PID: %d] - Está consumindo da fila 01 e enviando para o Pipe 01 o valor: %d\n", getpid(), shared_memory_fila_01->valor);
        sem_post(&shared_memory_fila_01->mutex); //libera região crítica
        write(shared_memory_fila_01->pipe_01[1], &shared_memory_fila_01->valor, sizeof(int)*sizeof(shared_memory_fila_01->valor)); //grava valor desenfilerado da fila 01 no pipe 01
        kill(shared_memory_fila_01->pids[4], SIGUSR1); //envia sinal para o processo P5 começar a processar o valor que foi gravado no pipe 01
        sleep(1);
	}
}

void consome_fila_01_e_envia_para_p6_via_pipe_02() {
    int valor;
    int i;

    for(i = 0; i < 5; i++) {
		sem_wait(&shared_memory_fila_01->mutex); //define regiao crítica
        shared_memory_fila_01->valor2 = desenfileira_fila_01(); //processo P4 desenfileira da fila 01
        printf("\n[Processo P4 - PID: %d] - Está consumindo da fila 01 e enviando para o Pipe 02 o valor: %d\n", getpid(), shared_memory_fila_01->valor2);
        sem_post(&shared_memory_fila_01->mutex); //libera região crítica
        write(shared_memory_fila_01->pipe_02[1], &shared_memory_fila_01->valor2, sizeof(int)*sizeof(shared_memory_fila_01->valor2)); //grava valor desenfilerado da fila 01 no pipe 02
        kill(shared_memory_fila_01->pids[5], SIGUSR1); //envia sinal para o processo P6 começar a processar o valor que foi gravado no pipe 02
        sleep(1);
	}
}

void thread_init_fila_01() {
	pthread_t threads[2];
    int i;

	pthread_create(&threads[0], NULL, (void*) consome_fila_01_e_envia_para_p5_via_pipe_01, NULL); //inicia thread 01 que desenfileirará da fila 01 e gravará no pipe 01 para ser consumido
	pthread_create(&threads[1], NULL, (void*) consome_fila_01_e_envia_para_p6_via_pipe_02, NULL); //inicia thread 02 que desenfileirará da fila 01 e gravará no pipe 02 para ser consumido

	for(i = 0; i < 2; i++) {
		pthread_join(threads[i], NULL); //espera até que as threads terminem a sua execução
	}
}

void consome_fila_02() {
    for(int i = 0; i < 3; i++) {
        desenfileira_fila_02(); //função que desenfileira da fila 02
        sleep(1);
    }
    shared_memory_fila_02->controle = 1; //define a fila 02 como pronta para ser enfileirada novamente
}

void thread_init_f2() {
	pthread_t threads[3];
	for(int i = 0; i < 3; i++) {
		pthread_create(&threads[i], NULL, (void*) consome_fila_02, NULL); // cria três threads a partir do processo P7 para consumir da fila 02
	}
	for(int i = 0; i < 3; i++) {
		pthread_join(threads[i], NULL); //espera até que as threads terminem a sua execução
	}
}

void p5_process(){
    read(shared_memory_fila_01->pipe_01[0],&shared_memory_fila_01->valor,sizeof(int)*sizeof(shared_memory_fila_01->valor)); //lê valor que foi gravado no pipe 01
    printf("\n[Processo P5 - PID: %d] - [Fila 02] - Enfileirando o valor: %d e variável de controle: %d\n", getpid(), shared_memory_fila_01->valor, shared_memory_fila_02->controle);
    shared_memory_fila_01->contador_p5++; //incrementa a quantidade de valores que estão sendo processados pelo processo P5
    enfileira_fila_02(shared_memory_fila_01->valor); //enfileira valor que veio do pipe 01 na fila 02
    close(shared_memory_fila_01->pipe_01[0]); //fecha o pipe 01
}


void p6_process(){
    read(shared_memory_fila_01->pipe_02[0],&shared_memory_fila_01->valor2,sizeof(int)*sizeof(shared_memory_fila_01->valor2));
    printf("\n[Processo P6 - PID: %d] - [Fila 02] - Enfileirando o valor: %d e variável de controle: %d\n", getpid(), shared_memory_fila_01->valor2, shared_memory_fila_02->controle);
    shared_memory_fila_01->contador_p6++; //incrementa a quantidade de valores que estão sendo processados pelo processo P6
    enfileira_fila_02(shared_memory_fila_01->valor2); //enfileira valor que veio do pipe 02 na fila 02
    close(shared_memory_fila_01->pipe_02[0]); //fecha o pipe 02
}

void calcula_moda(float vetor[]){ //função que calcula a quantidade de valores que mais se repetiram ao serem consumidos da fila 02
	int tamanho = shared_memory_fila_02->quantidadeValoresDesenfileirados;
	int iterador_1, iterador_2, contador[tamanho];
	float conta, moda;


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

void calcula_valor_maximo_e_valor_minimo(int *vetor){ //função que calcula o valor máximo e mínimo de elementos consumidos na fila 02
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
    gettimeofday(&tv1, NULL); //pega o tempo em que o programa se iniciou
	int status;
	int iterador, segment_id_f1, segment_size_f1 = sizeof(struct shared_memory_fila_01*); //inicia
	int segment_id_f2, segment_size_f2 = sizeof(struct shared_memory_fila_02*);
	pid_t pai = getpid(); //processo Pai

	segment_id_f1 = shmget(IPC_PRIVATE, segment_size_f1*QUANTIDADE_EXECUCAO, IPC_CREAT | 0666); // reserva certa quantidade de memória compartilhada
	shared_memory_fila_01 = (struct shared_memory_fila_01*) shmat(segment_id_f1, 0, 0); //endereço do segemento de memória compartilhada
	shmctl(segment_id_f1, IPC_STAT, NULL); //permite para manusear a memória compartilhada
	shared_memory_fila_01->tamanho = 0; //define o tamanho da fila 01 como iniciando em 0 elementos

	segment_id_f2 = shmget(IPC_PRIVATE, segment_size_f2*QUANTIDADE_EXECUCAO, IPC_CREAT | 0666); //
	shared_memory_fila_02 = (struct shared_memory_fila_02*) shmat(segment_id_f2, 0, 0);
	shmctl(segment_id_f2, IPC_STAT, NULL); //permite para manusear a memória compartilhada
	shared_memory_fila_02->tamanho = 0; //define o tamanho da fila 02 como iniciando em 0 elementos
	shared_memory_fila_02->controle = 1; //define a fila 02 como disponível para receber novos valores
    shared_memory_fila_02->quantidadeValoresDesenfileirados = 0; //define a quantidade de valores desenfileirados da fila 02 como 0.

	//semáforo
	sem_init(&shared_memory_fila_01->mutex, 1, 1); //endereço do semaforo, 0- compartilhado entre threads e 1 - compartilhado entre processos, valor inicial do semáforo

    if ( pipe(shared_memory_fila_01->pipe_01) == -1 ){ printf("Erro pipe()"); return -1; } //verifica se o pipe 01 deu sucesso
    if ( pipe(shared_memory_fila_01->pipe_02) == -1 ){ printf("Erro pipe()"); return -1; } //verifica se o pipe 02 deu sucesso

    shared_memory_fila_01->contador_p5 = 0; //define o contador de valores processador por P5 como 0.
    shared_memory_fila_01->contador_p6 = 0; //define o contador de valores processador por P6 como 0.

	int random;

	pid_t pids[7] = {-1};

	for(iterador = 0; iterador < 7; iterador++) {
		if(getpid() == pai) {
			pids[iterador] = fork(); // cria processos filhos
		} else
			break;
	}

	if(getpid() == pai) {
		for(iterador = 0; iterador < 7; iterador++) {
			shared_memory_fila_01->pids[iterador] = pids[iterador]; //coloca os processos filhos na struct da região de memória compartilhada da fila 01
		}
	} else if(pids[0] == 0) {
		srand(1234);
		for(;;) {
			enfileira_fila_01(); //P1: processo 01 enfileira elementos na fila 01
			sleep(1);
		}
	} else if(pids[1] == 0) {
		srand(4321);
 		for(;;) {
			enfileira_fila_01(); //P2: processo 02 enfileira elementos na fila 01
			sleep(1);
		}
 	} else if(pids[2] == 0) {
 		srand(1423);
 		for(;;) {
			enfileira_fila_01(); //P3: processo 03 enfileira elementos na fila 01
			sleep(1);
		}
	} else if(pids[3] == 0) {
		for(;;) {
			signal(SIGUSR1, thread_init_fila_01); //P4: processo 04 cria duas threads as quais desenfileirarão da fila 01 e gravarão no pipe 01 e pipe 02
			sleep(1);
		}
	} else if(pids[4] == 0) {
        for(;;){
            signal(SIGUSR1, p5_process); //P5: processo 05 lê valores do pipe 01 e grava na fila 02
            sleep(1);
        }

	} else if(pids[5] == 0) {
        for(;;){
            signal(SIGUSR1, p6_process); //P6: processo 06 lê valores do pipe 02 e grava na fila 02
            sleep(1);
        }
	} else if(pids[6] == 0) {
        for(;;) {
			thread_init_f2(); //P7: processo 07 desenfileira da fila 02 valores processados pelos processos P5 e P6
			sleep(1);
		}
	}

	shmdt(shared_memory_fila_01);
    shmdt(shared_memory_fila_02);
	if(getpid() == pai) {
		for(iterador = 0; iterador < 7; iterador++) {
			wait(&status); //espera pelos processos filhos
		}
		sem_destroy(&shared_memory_fila_01->mutex); //libera o semáforo da fila 01
		shmctl(segment_id_f1, IPC_RMID, 0); //libera o segmento de memória compartilhada da fila 01
		shmctl(segment_id_f2, IPC_RMID, 0); //libera o segmento de memória compartilhada da fila 02
	}

	exit(0);
}
