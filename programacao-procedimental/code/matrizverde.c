#include <stdio.h>
#define MAX 200

double diag_sup(double[MAX][MAX], int );

int main(int argc, char const *argv[]) {
  int n, i,j;
  double matriz[MAX][MAX] = {};
  do{
  printf("Digite a ordem da matriz( numero natural impar menor que 200):");
  scanf("%d",&n);
  }while(n%2 == 0);

  for(i =0; i <n; i++)
    for(j=0; j< n; j++){
      printf("\nmatriz[%d][%d] : ", i+1, j+1);
      scanf("%lf",&matriz[i][j]);
    }
  printf("%0.3lf\n", diag_sup(matriz, n));
  return 0;
}

double diag_sup(double matriz[MAX][MAX], int n){
  int i,j, t=0;
  double media =0.0;
  for(i = 0; i < n; i++)
    for(j =0; j < n; j++){
        if(j>i && j < n-i-1){
          t++;
          media += matriz[i][j];
        }
    }
  return media/t;
}
