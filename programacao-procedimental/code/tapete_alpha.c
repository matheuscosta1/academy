#include <stdio.h>

int main()
{
    int n, i, j, contador =0;
    printf("Numero de caracteres: ");
    scanf("%d", &n);
    for(i = 0; i < n*2; i++)
    {
        for(j = 0; j < n*2; j++)
        {
          if(j < contador)printf("%c", 'A'+j);
          else if(j >= n*2 - contador)printf("%c", 'A'+n*2 - j -1);
          else  printf("%c", 'A'+contador);
        }
        if(i < n - 1){
          ++contador;
        }else if(i >= n){
          --contador;
        }
        printf("\n");
    }

    return 0;
}
