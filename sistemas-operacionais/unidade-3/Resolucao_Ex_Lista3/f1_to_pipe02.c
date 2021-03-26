/**
 * Este codigo conecta f1 com process4 para compartilhar os recursos de p1, p2 e p3
 * e os processos p5 e p6 por meio dos canais pipe01 e pipe02 
 **/

#include "ex03.h"

int main()
{	
	//Preparando processos
	pid_t pid1;
	pid_t pid2;

	//chave de identificação para f1 para conectar singletheads.c e f1_to_pipe02.c
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

	//Recebendo endereço de memoria alocado
	shared_memory = shmat(shmid,(void*)0,0);
	
	//verificando situação
	if (shared_memory == (void *) -1 )
	{
		printf("shmat falhou\n");
		exit(-1);
	}
		
	f1_shared_area_ptr = (struct shared *) shared_memory;
	
	if ( sem_init((sem_t*)&f1_shared_area_ptr->mutex,1,1) != 0 )
	{
		printf("falha\n");
		exit(-1);
	}

	printf("A fila f1 está em espera: ");
	
	//Preparando troca de recursos
	sem_wait((sem_t*)&f1_shared_area_ptr->mutex);
	f1_shared_area_ptr->num = 10; 
	f1_shared_area_ptr->PID=getpid();
	printf(" pid: %d\n",f1_shared_area_ptr->PID);
	sem_post((sem_t*)&f1_shared_area_ptr->mutex);
	
	//chave de identificação para f2 para conectar f1_to_pipe02.c e final_part.c
	key_t keyF2=1243;
	void *shared_memory_f2 = (void *)0;
	int i;

	//Criação do segmento de memoria
	shmid = shmget(keyF2,MEM_F2,0666|IPC_CREAT);
	//verificando situação do shmid
	if ( shmid == -1 )
	{
		printf("shmget falhou\n");
		exit(-1);
	}
	
	//Recebendo endereço de memoria
	shared_memory_f2 = shmat(shmid,(void*)0,0);
	
	//verificando situação shmat
	if (shared_memory_f2 == (void *) -1 )
	{
		printf("falha\n");
		exit(-1);
	}

	f2_shared_area_ptr = (struct shared_f2 *) shared_memory_f2;
	
	if ( sem_init((sem_t*)&f2_shared_area_ptr->mutex,1,1) != 0 )
	{
		printf("sem_init falhou\n");
		exit(-1);
	}
         
    sem_wait((sem_t*)&f2_shared_area_ptr->mutex);
	f2_shared_area_ptr->num=0;
	f2_shared_area_ptr->t0=clock();;
	f2_shared_area_ptr->counter_p5_p6=0;

	for(i=0;i<10;i++)
		f2_shared_area_ptr->int_value[i]=0;
	
	sem_post((sem_t*)&f2_shared_area_ptr->mutex);
	
	//Criando canal de comunicacao pipe01
	if ( pipe(pipe01) == -1 ){ printf("Erro pipe()"); return -1; }
	//Criando canal de comunicacao pipe02
	if ( pipe(pipe02) == -1 ){ printf("Erro pipe()"); return -1; }

	signal(SIGUSR1, process4);
	
	//Criando processo filho
	pid1=fork();
	//Caso seja o processo filho "process5"
    if ( pid1 == 0 )
    {
		int process5, n5,sended_p5;
		while(1)
		{
			//Lendo f1
			read(pipe01[0],&process5,sizeof(int));
			sended_p5=0;
			while(sended_p5==0)
			{
				//Compartilhamento de recursos
				sem_wait((sem_t*)&f2_shared_area_ptr -> mutex);
				n5 = f2_shared_area_ptr->num;
				if(n5<10)
				{
					f2_shared_area_ptr -> int_value[n5] = process5;
					f2_shared_area_ptr ->num = (int)(n5+1);
					printf("process5 %d: %d \n",f2_shared_area_ptr->num,f2_shared_area_ptr->int_value[n5]);
					n5=f2_shared_area_ptr->counter_p5_p6;
					f2_shared_area_ptr->counter_p5_p6=n5+1;
					sended_p5=1;
				}
				
			sem_post((sem_t*)&f2_shared_area_ptr->mutex);
			}
		}
	}
	else
	if (pid1 > 0 )
	{	
		//Criando Processo Filho
    	pid2=fork();
    	if ( pid2 == 0 )
     	{//SCRIPT FILHO 2 (P6)
			int P6,n,enviouP6;
			while(1)
			{
				read(pipe02[0],&P6,sizeof(int));	
				enviouP6=0;
				while(enviouP6==0)
				{
					sem_wait((sem_t*)&f2_shared_area_ptr->mutex);
					n = f2_shared_area_ptr->num;
					if(n<10)
					{
						f2_shared_area_ptr->int_value[n]=P6;
						f2_shared_area_ptr->num = (int)(n+1);
						printf("P6 %d: %d \n",f2_shared_area_ptr->num,f2_shared_area_ptr->int_value[n]);
						n=f2_shared_area_ptr->counter_p5_p6;
						f2_shared_area_ptr->counter_p5_p6=n+1;
						enviouP6 = 1;
					}
					sem_post((sem_t*)&f2_shared_area_ptr->mutex);
				}
			}
		}
		else if (pid2 > 0 )
		{
			for(;;);
    	}		
    }
	
	
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
