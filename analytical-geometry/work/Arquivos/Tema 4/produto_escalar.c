#include <stdio.h>
#include <stdio_ext.h>

void barra2(char *);
void barra(int);
double prod_escalar(float *, float*);

int main(int argc, char const *argv[]) {
  float u[3], v[3];
  char a;
  do{
  barra2("Calculo do Produto Escalar");
  printf("\nDigite o primero vetor(x,y,z): ");
  scanf("%f%*c%f%*c%f", &u[0], &u[1], &u[2]);

  printf("\nDigite o segundo vetor(x,y,z): ");
  scanf("%f%*c%f%*c%f", &v[0], &v[1], &v[2]);

  double prod = prod_escalar(u,v);
  barra(15);
  printf("<u,v> = %.3lf", prod);
  barra(15);
  printf("\nPressione 0 para sair ou qualquer tecla pra continuar...\n");
  fflush(stdin);
  __fpurge(stdin);
  scanf("%c",&a);

}while(a != '0');

  return 0;
}

double prod_escalar(float *u, float *v){
  double soma =0;
  soma += u[0] * v[0];
  soma += u[1] * v[1];
  soma += u[2] * v[2];

  return soma;
}
void barra(int c){
  int i =0;
  printf("\n");
  while((i++) < c) printf("*");
  printf("\n");
}

void barra2(char *c){
  int i =0;;
  while(*(c+i++) != '\0') printf("*");
  printf("\n%s\n", c);
  i=0;
  while(*(c+i++) != '\0') printf("*");
  printf("\n");
}
