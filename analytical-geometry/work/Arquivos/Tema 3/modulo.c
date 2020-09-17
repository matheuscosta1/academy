#include <stdio.h>
#include <math.h>
#include <stdio_ext.h>

double modulo(float *);
void barra2(char *);
void barra(int);


int main(int argc, char const *argv[]) {
  float u[3];
  char a;
  do{
  barra2("Calculo do Modulo de Um Vetor");
  printf("\nDigite o vetor(x,y,z): ");
  scanf("%f%*c%f%*c%f", &u[0], &u[1], &u[2]);
  barra(20);
  double mod =modulo(u);
  printf("||v|| = %.3lf",mod);
  barra(20);

  printf("\nPressione 0 para sair ou qualquer tecla pra continuar...\n");
  fflush(stdin);
  __fpurge(stdin);
  scanf("%c",&a);
}while(a != '0');

  return 0;
}
double modulo(float *u){
  double mod= u[0] * u[0] + u[1] * u[1]+ u[2] * u[2];
  return sqrt(mod);
}

void barra2(char *c){
  int i =0;;
  while(*(c+i++) != '\0') printf("*");
  printf("\n%s\n", c);
  i=0;
  while(*(c+i++) != '\0') printf("*");
  printf("\n");
}
void barra(int c){
  int i =0;
  printf("\n");
  while((i++) < c) printf("*");
  printf("\n");
}
