#include <signal.h>
#include <unistd.h>
#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <sys/shm.h>

#define MEM_F2 2000

int max=1000;
int quant,size=0,qP5P6=0;
int *arr = NULL;
int *freq = NULL;

clock_t T0,T1;

void dados(int in);
void* T1T2eT3 ( void *ptr );

struct F2_area{	
	int num;
	char valor[10];
	int quantP5P6;
	sem_t mutex;
	clock_t t0;
};
struct F2_area *F2_ptr;
main()
{//SCRIPT  F2 PARA TER ACESSO A MEMORIA E CHAMA P4 SOMENTE QUANDO RECEBER SINAL
//TAMBEM É TAMBEM CRIA P5 P6 e P7 
	
	
	//F2
	int i=0;
	key_t key=4321;
	void *shared_memory = (void *)0;
	int shmid;

	shmid = shmget(key,MEM_F2,0666|IPC_CREAT);
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
		
	

	F2_ptr = (struct shared *) shared_memory;
	
	if ( sem_init((sem_t*)&F2_ptr->mutex,1,1) != 0 )
	{
		printf("sem_init falhou\n");
		exit(-1);
	}
	//F2
	sem_wait((sem_t*)&F2_ptr->mutex);
	F2_ptr->num=0;
	for(i=0;i<10;i++) F2_ptr->valor[i]=0;
	sem_post((sem_t*)&F2_ptr->mutex);
	arr = malloc(size * sizeof *arr);
	freq = malloc(size * sizeof *freq);
     printf("P7 esperando dados...\n");
     pthread_t threads[3];
    
    for(i=0;i<3;i++) pthread_create (&threads[i], NULL, T1T2eT3, NULL);
    
	for(i=0;i<3;i++) pthread_join(threads[i], NULL);
    
    int maior=0,maximo=0,im,minimo;
    printf("FINISH P7\n");
    for(i=0;i<size;i++)
	{
    	if(freq[i]>=maior)
		{
			maior=freq[i];
			im=i;
    	}
    	if(arr[i]>=maximo)
		{
  			maximo=arr[i];
    	}
	
    	if((i==0)||(minimo>=arr[i]))
		{
    		minimo=arr[i];
    	}
    }

    T1 = clock();
    double tempo_gasto;
    tempo_gasto = ( (double) (T1 - T0) ) / CLOCKS_PER_SEC;
    printf("\nA)Tempo de execuçao: %lf\n",tempo_gasto);
    printf("B)Quantidade de valores processados por P5 e P6: %d\n",qP5P6);
    printf("c) Moda:%d \n   Maximo: %d \n   Minimo: %d \n-----------\n",arr[im],maximo,minimo);
}
     
     
void* T1T2eT3 ( void *ptr )
{ 
	

	int resorce,i,n7,P7;
	while(1)
	{
	 	sem_wait((sem_t*)&F2_ptr->mutex);
  	  	n7 = F2_ptr->num;
   		if ( n7 > 0 )
		{
			P7= F2_ptr->valor[0];	
			for(i=0;i<n7;i++)
			{
				resorce=F2_ptr->valor[i+1];
				F2_ptr->valor[i] = resorce; 
			}
			quant++;
			printf("P7 consumiu %d : %d\n",quant,P7);
			if(quant > max)
			{
				return 0;
			}
			dados(P7);
			F2_ptr->num=(int)(n7-1);
		}

		if(quant==max)
		{
		
			if(qP5P6==0)
			{
				qP5P6=F2_ptr->quantP5P6;
				T0=F2_ptr->t0;
			}
			sem_post((sem_t*)&F2_ptr->mutex);
			pthread_exit(0);
		}

		else
		{	    	
			sem_post((sem_t*)&F2_ptr->mutex);
		}
	}
	
	
}	

void dados(int in)
{
	int i,new=1;
	for(i=0;i<size;i++)
	{
		if(arr[i]==in)
		{
			freq[i]=freq[i]+1;
			new=0;
		}
	}
	if(new==1)
	{
		size++;
		arr = realloc(arr, size * sizeof(int));
		freq = realloc(freq, size * sizeof(int));
		freq[size-1]=1;
		arr[size-1]=in;
	}
}	
  
