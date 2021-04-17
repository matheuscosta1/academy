#include <stdio.h>

int main() {
  double soma =1, parcela =1 , pi;
  int i = 3, is_soma = 0;
  printf("Calculando pi...\n");
  while(parcela > 0.00001){
    parcela = 1.0f/i;
    if(is_soma){
      soma += parcela;
      is_soma = 0;
    }else{
      soma -=parcela;
      is_soma = 1;
    }
    i+=2;
  }
  pi = 4*soma;
  printf("O valor aproximado de PI eh: %lf\n", pi);
  return 0;
}
