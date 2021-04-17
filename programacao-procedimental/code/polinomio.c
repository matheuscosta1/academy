#include <stdio.h>
#include <stdlib.h>
#include <stdio_ext.h>
#define MAX 200

void lerPoli(int *, int *);
void escreverPoli(int *, int);
void calcPx(int *, int );
void somaPoli();
void subtrairPoli();
int showMenu();

int main(int argc, char const *argv[]) {
  int polinomio[MAX] = {}, grau, op;
  do{
    op = showMenu();
    switch (op) {
      case 1: lerPoli(polinomio, &grau); break;
      case 2: escreverPoli(polinomio, grau); break;
      case 3: calcPx(polinomio, grau); break;
      case 4: somaPoli();break;
      case 5: subtrairPoli();break;
      case 6: exit(1);
    }
    if(op != 6){
      printf("\nPressione qualquer tecla pra continuar...");
      __fpurge(stdin);
      getchar();
      showMenu();
    }
  }while (op != 6);
  return 0;
}

int showMenu(){
  int op;
    system("clear");
    printf("\n\nMenu\n");
    printf("[%d]. %s\n", 1, "Introduzir polinomio");
    printf("[%d]. %s\n", 2, "Exibir polinomio");
    printf("[%d]. %s\n", 3, "Calcular P(x) em algum ponto");
    printf("[%d]. %s\n", 4, "Somar dois polinomios");
    printf("[%d]. %s\n", 5, "subtrair dois polinomios");
    printf("[%d]. %s\n", 6, "Sair");
    printf("Digite a opcao desejada: ");
    __fpurge(stdin);
    scanf("%d", &op);
  return op;
}

void lerPoli(int *p, int *grau){
  int i;
  int *polinomio = p;
  printf("[1].Introduzir polinomio\nDigite o grau do polinomio(max %d): ", MAX);
  scanf("%d", grau);
  for(i=0; i <= *grau; i++){
    printf("x^%d: ",i);
    scanf("%d", polinomio++);
  }
}

void escreverPoli(int *p, int grau){
  int i;
  printf("[2].Exibir Polinomio: ");
  for ( i = grau; i >= 0; i--) {
    if(*(p+i) == 0) continue;
    if(i == 0)printf("%d", *(p+i));
      else printf("%dx^%d+",*(p+i), i);
  }
}
void calcPx(int *polinomio, int grau){
  int x, i, resultado=0;
  printf("[3]. Calculo de P(x)\nIntroduza o valor de x: ");
  scanf("%d",&x);
  for(i=0; i<=grau; i++)
      if(i==0)resultado +=*polinomio;
        else resultado += x*(*(polinomio+i));
  printf("P(x)=%d", resultado);
}

void somaPoli(){
  int poli1[MAX] = {}, poli2[MAX] = {}, grau1, grau2,i;
  printf("Polinomio 1: \n");
  lerPoli(poli1, &grau1);
  printf("Polinomio 2: \n");
  lerPoli(poli2, &grau2);
  if(grau1 > grau2){
    for(i =0; i<=grau2; i++){
      poli1[i] += poli2[i];
    }
    escreverPoli(poli1, grau1);
  }else{
    for(i =0; i<=grau1; i++){
      poli2[i] += poli1[i];
    }
    escreverPoli(poli2, grau2);
  }
}

void subtrairPoli(){
  int poli1[MAX] = {}, poli2[MAX] = {}, grau1, grau2,i;
  printf("Polinomio 1: \n");
  lerPoli(poli1, &grau1);
  printf("Polinomio 2: \n");
  lerPoli(poli2, &grau2);
  if(grau1 > grau2){
    for(i =0; i<=grau2; i++){
      poli1[i] -= poli2[i];
    }
    escreverPoli(poli1, grau1);
  }else{
    for(i =0; i<=grau1; i++){
      poli2[i] -= poli1[i];
    }
    escreverPoli(poli2, grau2);
  }
}
