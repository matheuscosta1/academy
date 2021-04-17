#include <stdio.h>
#include <stdlib.h>
#define MAX 200

void rotate90(int m[MAX][MAX], int s);

void rotate90(int mat[MAX][MAX], int s){
  int  *maux, *aux;
  maux = (int*) malloc(s*s*4);
  aux = maux;
  int i,j;
  for (i = 0; i < s; i++)
        for (j = 0; j < s; j++)  *(aux++) = mat[s-j-1][i];
  aux = maux;
  for (i = 0; i < s; i++)
       for (j = 0; j < s; j++) mat[i][j] = *(aux++);
  free(maux);
  }

int main(int argc, char const *argv[]) {
  int m[MAX][MAX] = {}, s, i, j;
  printf("Digite o tamanho da matriz: ");
  scanf("%d",&s);
  for(int i =0; i < s; i++)
    for(j =0; j < s; j++){
      printf("[%d][%d]: ", i+1, j+1);
      scanf("%d", &m[i][j]);
    }
  rotate90(m, s);
  for(int i =0; i < s; i++){
    for(j =0; j < s; j++) printf("%d ", m[i][j]);
    printf("\n");
  }
  return 0;
}
