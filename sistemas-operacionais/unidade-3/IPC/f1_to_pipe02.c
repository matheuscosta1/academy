#include <signal.h>
#include <unistd.h>
#include <stdio.h>
#include <pthread.h>//include trhread
#include <semaphore.h>
#include <stdlib.h>//
#include <sys/shm.h>//
#include <time.h>//
//MEMORIAS RESERVADAS PARA F1 E F2
#define MEM_F1 4096
#define MEM_F2 4096

void P4(int p);
void* T1 ( void *ptr );
void* T2 ( void *ptr );
int nF1;
int Canal1[2];//CANAL QUE ENVIA OS NUMEROS DE T1 A P5 ATRAVEZ DE PIPE
int Canal2[2];//CANAL QUE ENVIA OS NUMEROS DE T2 A P6 ATRAVEZ DE PIPE
struct shared{	
	sem_t mutex;
	int num;
	char valor[10];
	int PID;
};
struct F2_area{	
	int num;
	char valor[10];
	int quantP5P6;
	sem_t mutex;
	clock_t t0;
};
struct shared *F1_ptr;
struct F2_area *F2_ptr;
main()
{//SCRIPT F1 e F2 PARA TER ACESSO A MEMORIA E CHAMA P4 SOMENTE QUANDO RECEBER SINAL
//TAMBEM É TAMBEM CRIA P5 P6 e P7 e os canais de comunicaçoes pipes
	
	pid_t pid1;
	pid_t pid2;
	//F1
	key_t key=1234;
	void *shared_memory = (void *)0;
	int shmid;

	shmid = shmget(key,MEM_F1,0666|IPC_CREAT);
	if ( shmid == -1 )
	{
		printf("shmget falhou\n");
		exit(-1);
	}
	
	
	shared_memory = shmat(shmid,(void*)0,0);
	
	if (shared_memory == (void *) -1 )
	{
		printf("shmat falhou\n");
		exit(-1);
	}
		
	

	F1_ptr = (struct shared *) shared_memory;
	
	if ( sem_init((sem_t*)&F1_ptr->mutex,1,1) != 0 )
	{
		printf("sem_init falhou\n");
		exit(-1);
	}
	printf("F1: esperando P1P2 e P3...");
	sem_wait((sem_t*)&F1_ptr->mutex);
	F1_ptr->num = 10; 
	F1_ptr->PID=getpid();
	printf(" pid: %d\n",F1_ptr->PID);
	sem_post((sem_t*)&F1_ptr->mutex);
	/// END F1
	//F2
	
	key_t keyF2=4321;
	void *shared_memoryF2 = (void *)0;
	int i;

	shmid = shmget(keyF2,MEM_F2,0666|IPC_CREAT);
	if ( shmid == -1 )
	{
		printf("shmget falhou\n");
		exit(-1);
	}
	
	shared_memoryF2 = shmat(shmid,(void*)0,0);
	
	if (shared_memoryF2 == (void *) -1 )
	{
		printf("shmat falhou\n");
		exit(-1);
	}

	F2_ptr = (struct F2_area *) shared_memoryF2;
	
	if ( sem_init((sem_t*)&F2_ptr->mutex,1,1) != 0 )
	{
		printf("sem_init falhou\n");
		exit(-1);
	}
         
        sem_wait((sem_t*)&F2_ptr->mutex);
	F2_ptr->num=0;
	F2_ptr->t0=clock();;
	F2_ptr->quantP5P6=0;
	for(i=0;i<10;i++)
		F2_ptr->valor[i]=0;
	sem_post((sem_t*)&F2_ptr->mutex);
	//END F2
	if ( pipe(Canal1) == -1 ){ printf("Erro pipe()"); return -1; }//CRIANDO CANAL DE COMUNICAÇAO
	if ( pipe(Canal2) == -1 ){ printf("Erro pipe()"); return -1; }//CRIANDO CANAL DE COMUNICAÇAO
	
	signal(SIGUSR1, P4);
	
	pid1=fork();//CRIANDO FILHO 1
   if ( pid1 == 0 )
   {//SCRIPT FILHO 1 (P5)
  	int P5, n5,enviouP5;
  	while(1){
  	read(Canal1[0],&P5,sizeof(int));
  	
  	//salvando na memoria
  	enviouP5=0;
 	while(enviouP5==0){
  	sem_wait((sem_t*)&F2_ptr->mutex);
   	n5 = F2_ptr->num;
   	if(n5<10){
	F2_ptr->valor[n5]=P5;
	F2_ptr->num = (int)(n5+1);
	printf("P5 %d: %d \n",F2_ptr->num,F2_ptr->valor[n5]);
	n5=F2_ptr->quantP5P6;
  	F2_ptr->quantP5P6=n5+1;
	enviouP5=1;
	}
	sem_post((sem_t*)&F2_ptr->mutex);
	}
	
  	
	
  	}
  	
    ////////////////////////	
   }
   else
   if (pid1 > 0 )
   {
     pid2=fork();//CRIANDO FILHO 2
     if ( pid2 == 0 )
     {//SCRIPT FILHO 2 (P6)
    	int P6,n,enviouP6;
  	while(1){
  	read(Canal2[0],&P6,sizeof(int));	
  	enviouP6=0;
 	while(enviouP6==0){
  	sem_wait((sem_t*)&F2_ptr->mutex);
   	n = F2_ptr->num;
   	if(n<10){
	F2_ptr->valor[n]=P6;
	F2_ptr->num = (int)(n+1);
	printf("P6 %d: %d \n",F2_ptr->num,F2_ptr->valor[n]);
	n=F2_ptr->quantP5P6;
  	F2_ptr->quantP5P6=n+1;
	enviouP6 = 1;
	}
	sem_post((sem_t*)&F2_ptr->mutex);
	}
	
	
  	
  	}
	////////////////////////
     }
     else
     if (pid2 > 0 )
     {//SCRIPT PAI (P7)
     //printf("ENTREI P7\n");
     // int P7,nu,j;
     while(1){}
  
     
     }		
    }
	
	
} 
void P4(int p)
{	//SCRIPT P4 ACIONADO AO RECEBER SINAL
	
	printf("P4 recebeu Sinal\n");
	pthread_t threads[2];
	int i;
   	
  	nF1=10;
		//CRIANDO AS THREADS   
           pthread_create (&threads[0], NULL, T1, NULL);
           pthread_create (&threads[1], NULL, T2, NULL);
       		
	 for(i=0;i<2;i++)//ESPERANDO THREADS TERMINAREM
          pthread_join(threads[i], NULL);
          
          printf("P4 acabou\n");
			

	sem_wait((sem_t*)&F1_ptr->mutex);
	sleep(0.1);
	F1_ptr->num=0;//NESTE PROGRAMA 
	sem_post((sem_t*)&F1_ptr->mutex);
	
   
		
	

	
}
void* T1 ( void *ptr )
{ 
	
	int recebido,resorce,i,envia;
	while(1){
	envia=0;
	sem_wait((sem_t*)&F1_ptr->mutex);
   	 	if ( nF1 > 0 ){ 
   	 	envia=1;	
		recebido= F1_ptr->valor[0];
		
		for(i=0;i<nF1;i++){
			resorce=F1_ptr->valor[i+1];
			F1_ptr->valor[i] = resorce; 
			}
		//F1_ptr->valor[nF1] =0;
		printf("T1 pegou %d: %d\n",nF1,recebido);
		nF1=(nF1-1);
		
		
		}	
	sem_post((sem_t*)&F1_ptr->mutex);
	
	if(envia==1)
	write(Canal1[1],&recebido,sizeof(int));	
	if(nF1==0) {
	printf("Terminei T1\n");
	//close(Canal1[1]);
	pthread_exit(0);
	}
	
	}
	
	
}

void* T2 ( void *ptr )
{ 
	

	int recebido,resorce,i,envia;
	while(1){
	envia=0;
	sem_wait((sem_t*)&F1_ptr->mutex);
   	 	if ( nF1 > 0 ){ 	
		recebido= F1_ptr->valor[0];
		envia=1;
		printf("T2 pegou %d: %d\n",nF1,recebido);
		for(i=0;i<nF1;i++){
			resorce=F1_ptr->valor[i+1];
			F1_ptr->valor[i] = resorce; 
			}
		//F1_ptr->valor[nF1] =0;
		nF1=(nF1-1);
		
		}	
	sem_post((sem_t*)&F1_ptr->mutex);
	if(envia==1)
	write(Canal2[1],&recebido,sizeof(int));
	
	if(nF1==0) {
	printf("Terminei T1\n");
	//close(Canal2[1]);
	pthread_exit(0);
	}
	
	}
	
	
}
