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


//Criando funcao para gerar numeros alatorios e compartilhar esses valores a f1
void singleProcess(){
	while(1)
	{
		sem_wait((sem_t*)&f1_shared_area_ptr->mutex);	
		//Variavel n serve para compartilhar o numero de valores 1 a 10
		n = f1_shared_area_ptr->num;
		//Verificando se os valores nao passaram do limite da fila que e 10
		if ( n < 10 )
		{	
			//Gerando valores de 1 a 1000
			f1_shared_area_ptr-> int_value[n]= 1 + (rand() % 999);
			//Incremento dos valores
			f1_shared_area_ptr-> num += 1;
			//Preparando compartilhamento na f1
			printf("Foi produzido no campo [%d] o valor [%d]\n",f1_shared_area_ptr->num, f1_shared_area_ptr->int_value[n]);
			//Verificando caso anterior ao 10 para enviar o kill
			if(n==9)
			{
				kill(f1_shared_area_ptr->PID, SIGUSR1);
				printf("Em aguardo: \n");	
			}
		}
		//Compartilando recursos
		sem_post((sem_t*)&f1_shared_area_ptr->mutex);	
	}	
}

int main()
{
  	int i;
	//Preparando processos
  	pid_t pid1;
	pid_t pid2;
	
	//chave de identificação f1
	key_t key=1234;
	void *shared_memory = (void *)0;
	int shmid;
	//Criação do segmento de memoria
	shmid = shmget(key,MEM_F1,0666|IPC_CREAT);
	//verificando situação
	if ( shmid == -1 )
	{
		printf("shmget falhou\n");
		exit(-1);
	}
	//Recebendo endereço de memoria
	shared_memory = shmat(shmid,(void*)0,0);
	//verificando situação
	if (shared_memory == (void *) -1 )
	{
		printf("shmat falhou\n");
		exit(-1);
	}

	f1_shared_area_ptr = (struct shared *) shared_memory;
	if ( sem_init((sem_t *)&f1_shared_area_ptr->mutex,1,1) != 0 )
    {
        printf("sem_init falhou\n");
        exit(-1);
    }

	f1_shared_area_ptr->num=0;
	for(i=0;i<10;i++) 
		f1_shared_area_ptr->int_value[i]=0;

	//Criando filho 1
	pid1=fork();
	if( pid1 == 0 )
	{
		singleProcess();
	}

	//Verificação da criação do PID
    else if(pid1 > 0 )
    {
		//Criando filho 2
    	pid2=fork();
    	if ( pid2 == 0 )
    	{
			singleProcess();
    	}
    	else if (pid2 > 0 )
    	{
    		singleProcess();
    	}		
    }
    return 0;
}

//funcao do process4 para acionar ao receber o sinal
void process4(int p)
{	

	printf("process4 recebeu Sinal\n");
	pthread_t threads[2];
	int i;
   	
  	nF1=10;
	//Criando as threads   
    pthread_create (&threads[0], NULL, thread1, NULL);
    pthread_create (&threads[1], NULL, thread2, NULL);
       		
	 for(i=0;i<2;i++)//ESPERANDO THREADS TERMINAREM
        pthread_join(threads[i], NULL);  
        printf("process4 acabou\n");
			

	sem_wait((sem_t*)&f1_shared_area_ptr->mutex);
	//sleep(0.1);
	f1_shared_area_ptr->num=0;//NESTE PROGRAMA 
	sem_post((sem_t*)&f1_shared_area_ptr->mutex);
}

void* thread1 ( void *ptr )
{ 
	
	int received,rsc,i,send;
	while(1)
	{
		send=0;
		sem_wait((sem_t*)&f1_shared_area_ptr->mutex);
   	 	if ( nF1 > 0 )
		{ 
			send=1;	
			received= f1_shared_area_ptr->int_value[0];
			
			for(i=0;i<nF1;i++)
			{
				rsc=f1_shared_area_ptr->int_value[i+1];
				f1_shared_area_ptr->int_value[i] = rsc; 
			}
			printf("A fila 1 recebeu no campo [%d] o valor [%d]\n",nF1,received);
			nF1=(nF1-1);
		}	
		sem_post((sem_t*)&f1_shared_area_ptr->mutex);
		
		if(send==1)
		write(pipe01[1],&received,sizeof(int));	
		if(nF1==0)
		{
			printf("Thread1 finalizado: \n");
			//close(pipe01[1]);
			pthread_exit(0);
		}
	}	
}

void* thread2 ( void *ptr )
{ 
	int received,rsc,i,send;
	while(1){
        send=0;
        sem_wait((sem_t*)&f1_shared_area_ptr->mutex);

        if ( nF1 > 0 ){ 	
        received= f1_shared_area_ptr->int_value[0];
        send=1;
        printf("Thread2 recebeu %d: %d\n",nF1,received);
        for(i=0;i<nF1;i++){
            rsc=f1_shared_area_ptr->int_value[i+1];
            f1_shared_area_ptr->int_value[i] = rsc; 
            }
        //f1_shared_area_ptr->int_value[nF1] =0;
        nF1=(nF1-1);
        
        }	
        sem_post((sem_t*)&f1_shared_area_ptr->mutex);

        if(send==1)
        write(pipe02[1],&received,sizeof(int));
        
        if(nF1==0) {
        printf("Thread2 finalizado: \n");
        //close(pipe02[1]);
        pthread_exit(0);
        }
	}
}