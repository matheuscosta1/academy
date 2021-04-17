#include <stdio.h>
#define PI 3.141592

 int main() {
  double potencia = 1,fatorial =1, seno;
  float x;
  int i, is_soma = 0;
  printf("Calculo do seno\nDigite os graus:");
  scanf("%f", &x);
  x = (PI*x)/180;
  seno = x;
  for(i =1; i<=19; i++){
    potencia = potencia*x;
    fatorial = fatorial*i;
    if(i&1 && i != 1){
      if(is_soma){
        seno +=potencia/fatorial;
        is_soma = 0;
      }else{
        seno -=potencia/fatorial;
        is_soma =1;
      }
    }
  }
  printf("sen = %lf\n", seno);
  return 0;
}
