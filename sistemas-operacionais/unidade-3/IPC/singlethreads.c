#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/shm.h>
#include <semaphore.h>
#include <signal.h>

#define MEM_F1 2000

struct shared *F1_ptr;

void singleProcess();
int n;

struct shared{
	sem_t mutex;	
	int num;
	char valor[10];
	int PID;
};

int main()
{
  	int i;
  	pid_t pid1;
	pid_t pid2;
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
	
	if ( sem_init((sem_t *)&F1_ptr->mutex,1,1) != 0 )
    {
            printf("sem_init falhou\n");
            exit(-1);
    }

	F1_ptr->num=0;
	for(i=0;i<10;i++) F1_ptr->valor[i]=0;

	//CRIANDO FILHO 1
	pid1=fork();
	if( pid1 == 0 )
	{
		singleProcess();
	}

	//CRIANDO FILHO 2
    else if(pid1 > 0 )
    {
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

void singleProcess(){
	for(;;)
	{
		sem_wait((sem_t*)&F1_ptr->mutex);	
		n = F1_ptr->num;
		//srand((unsigned)time(NULL) );
		if ( n <  (int) 10 )
		{

			F1_ptr->valor[n]=abs(1-(rand() % 999));
			F1_ptr->num = (int)(n+1);
			printf("P1P2P3 Produziu %d : %d\n",F1_ptr->num,F1_ptr->valor[n]);
			if(n==9)
			{
				kill(F1_ptr->PID, SIGUSR1);
				printf("Esperando pedido...\n");	
			}
		}
		sem_post((sem_t*)&F1_ptr->mutex);	
	}	
}

	
	
