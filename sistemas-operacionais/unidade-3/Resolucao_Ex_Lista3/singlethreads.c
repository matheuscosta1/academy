/**
 * Este codigo cria os processos p1, p2 e p3. Apos sua criação
 * é passado os valores inteiros para a fila f1 por meio da 
 * memoria compartilhada
 **/
#include "ex03.h"

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