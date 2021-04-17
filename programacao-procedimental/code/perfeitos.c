#include <stdio.h>

int main(){
    int i, j, soma, soma_p = 0, soma_a = 0, soma_r =0;
    for(i = 1; i<=200; i++){
        soma = 0;
        for(j = 1; j<i; j++){
           if(i%j == 0) soma+=j;

        }
    if(soma == i) {
      printf("%d eh um numero perfeito\n", i);
      ++soma_p;

    }else if(soma > i) {
      printf("%d eh um numero abundante\n", i);
      ++soma_a;

    }else if(soma < i) {
      printf("%d eh um numero reduzido\n", i);
      ++soma_r;
      }
  }
  printf("\nQuantidade de perfeitos:%d\tQuantidade de abundantes:%d\nQuantidade de reduzidos:%d\n",soma_p, soma_a, soma_r);
    return 0;
}
