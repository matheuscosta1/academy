#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
/* Inclua aqui todos os demais headers necessaarios */

int main()
{
  pid_t p;
  int id=0;

/* 
  Crie todos os recursos compartilhados aqui: 
  Ex.: Shared Memories (Filas), Pipes e Semaforos.
  ...
  ...
*/


/* Criar os 7 Processos
   Para isso, o corpo do for(;;) abaixo executa 
   7 vezes a system call fork(). 
   Para que somente o processo Pai crie filhos, 
   cada filho sai (break) do for(;;) assim que retorna da fork.
   O valor da variavel "id" em cada processo indica o seu papel 
   no programa (processos P1 ate P7). 
*/

  for(id=1; id<=7; id++){
      p = fork();
      if ( p < 0 ){ printf("Erro no fork()\n"); exit(-1);}
      if ( p == 0 )
	   break;	  
  }
  
/* Abaixo programe o codigo de cada processo ´separadamente
   diferenciando-os pelo valor da variavel id.
*/

  if ( id <= 3 ){
    printf("Executa o codigo de P1, P2 e P3\n");
/*  Aqui vai o codigo dos processos P1, P2 e P3. 
    Eles fazem exatamente a mesma coisa.
    Se preferir separa-los (if-else-if) 
    nao tem problema.
*/
  } 
  else 
  if ( id == 4 ){
    printf("Executa o codigo de P4\n");
  }
  else 
  if ( id == 5 ){
    printf("Executa o codigo de P5\n");
  }
  else 
  if ( id == 6 ){
    printf("Executa o codigo de P6\n");
  }
  else 
  if ( id == 7 ){
    printf("Executa o codigo de P7\n");
  }
  else 
  if ( id == 8 ){
    printf("Executa o codigo do Processo Pai\n");
/*  Ele pode aguardar os demais processos ou simplesmente finalizar neste ponto. 
    Lembre-se, o termino do Pai antes dos processos filhos nao causa o termino dos
    processos filhos. 
*/    
  }
 exit(0); /* Executado por todos os processos ao finalizarem */
}
