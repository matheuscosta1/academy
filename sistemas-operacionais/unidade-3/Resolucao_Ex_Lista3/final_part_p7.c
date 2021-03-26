/**
 * Este codigo cria os processos p5, p6 e p7. O processo 4 somente 
 * é acessado quando recebe um signal. Os recusos são compartilhados
 *  pela fila f2.
 **/

#include "ex03.h"

int main()
{		
	//Preparacao para f2

	int i=0;
	//chave de identificação
	key_t key= 1243;
	void *shared_memory = (void *)0;
	int shmid;

	//Criando um novo segmento de memória compartilhada com size equivalente a MEM_F2
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
		
	f2_shared_area_ptr = (struct shared *) shared_memory;
	
	if ( sem_init((sem_t*)&f2_shared_area_ptr->mutex,1,1) != 0 )
	{
		printf("sem_init falhou\n");
		exit(-1);
	}

	sem_wait((sem_t*)&f2_shared_area_ptr->mutex);
	f2_shared_area_ptr->num=0;
	for(i=0;i<10;i++) f2_shared_area_ptr->int_value[i]=0;
	sem_post((sem_t*)&f2_shared_area_ptr->mutex);
	moda = malloc(size * sizeof *moda);
	freq = malloc(size * sizeof *freq);
    printf("Processo P7 em aguardo: \n");
    pthread_t threads[3];
    
    for(i=0;i<3;i++) pthread_create (&threads[i], NULL, three_threads_p7, NULL);
    
	for(i=0;i<3;i++) pthread_join(threads[i], NULL);
    
    int maior=0,max_int_value=0,im,min_int_value;
    printf("\n O Processo p7 ja recebeu todos os 1000 valores : \n");
    for(i=0;i<size;i++)
	{
    	if(freq[i]>=maior)
		{
			maior=freq[i];
			im=i;
    	}
    	if(moda[i]>=max_int_value)
		{
  			max_int_value=moda[i];
    	}
	
    	if((i==0)||(min_int_value>=moda[i]))
		{
    		min_int_value=moda[i];
    	}
    }

    final_time = clock();
	/*
	printf("Tempo inicial: %ld\n",initial_time);
	printf("Tempo final: %ld\n",final_time);
	printf("clock: %ld\n",CLOCKS_PER_SEC);
	*/
    total_time = ( (double) (final_time - initial_time)) / CLOCKS_PER_SEC;
    printf("\na)O tempo de execuçao total do programa foi de ------ : %.3f segundos",total_time);
    printf("\nb)A quantidade de valores processados por process5,P6 foi-- : %d",counter_p5_p6);
    printf("\nc)O Valor que mais se repetiu é o ------------------- : %d \n \\
	O maior valor computado foi ----------------- : %d \n \\
	O menor valor computado foi ----------------- : %d \n\n",
	moda[im],max_int_value,min_int_value);
	return 0;
}

void dates_interpreter(int in)
{
	int i,new=1;
	for(i=0;i<size;i++)
	{
		if(moda[i]==in)
		{
			freq[i]=freq[i]+1;
			new=0;
		}
	}
	if(new==1)
	{
		size++;
		moda = realloc(moda, size * sizeof(int));
		freq = realloc(freq, size * sizeof(int));
		freq[size-1]=1;
		moda[size-1]=in;
	}
}	
  

     
void* three_threads_p7( void *ptr )
{ 
	int resorce,i,n7,P7;
	while(1)
	{
	 	sem_wait((sem_t*)&f2_shared_area_ptr->mutex);
  	  	n7 = f2_shared_area_ptr->num;
   		if ( n7 > 0 )
		{
			P7= f2_shared_area_ptr->int_value[0];	
			for(i=0;i<n7;i++)
			{
				resorce=f2_shared_area_ptr->int_value[i+1];
				f2_shared_area_ptr->int_value[i] = resorce; 
			}
			count++;
			printf("O processo p7 recebeu no campo [%d] o valor  [%d] \n",count,P7);
			if(count > max_values)
			{
				return 0;
			}
			dates_interpreter(P7);
			f2_shared_area_ptr->num=(int)(n7-1);
		}

		if(count==max_values)
		{
		
			if(counter_p5_p6==0)
			{
				counter_p5_p6=f2_shared_area_ptr->counter_p5_p6;
				initial_time=f2_shared_area_ptr->t0;
			}
			sem_post((sem_t*)&f2_shared_area_ptr->mutex);
			pthread_exit(0);
		}

		else
		{	    	
			sem_post((sem_t*)&f2_shared_area_ptr->mutex);
		}
	}
}	