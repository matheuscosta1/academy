#include <stdio.h>
#include <math.h>
#include <stdio_ext.h>

#define PI 3.14159265

double angulo(float *, float *);
double modulo( float *);
double prod_escalar( float *, float *);

void barra(int);
void barra2(char *);

int main(int argc, char const *argv[]) {
  float u[3], v[3];
  char a;
  do{
  barra2("Calculo do Angulo Entre Vetores");
  printf("\nDigite o primero vetor(x,y,z): ");
  scanf("%f%*c%f%*c%f", &u[0], &u[1], &u[2]);

  printf("\nDigite o segundo vetor(x,y,z): ");
  scanf("%f%*c%f%*c%f", &v[0], &v[1], &v[2]);

  barra(50);
  double ang =angulo(u,v);
  printf("O angulo entre os dois vetores eh de aproximadamente %.3lf",ang*(180/PI));
  barra(50);
  
  printf("\nPressione 0 para sair ou qualquer tecla pra continuar...\n");
  fflush(stdin);
  __fpurge(stdin);
  scanf("%c",&a);
}while(a != '0');

  return 0;
}

double angulo(float *u, float *v){
  double prod = prod_escalar(u, v);
  double mods = modulo(v) * modulo(u);
  return acos(prod/mods);
}
double prod_escalar(float *u, float *v){
  double soma =0;
  soma += u[0] * v[0];
  soma += u[1] * v[1];
  soma += u[2] * v[2];

  return soma;
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
