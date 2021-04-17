  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>


  int val_max_substring (char frase_inicial[])
  {
    int tamanho_frase_inicial = strlen(frase_inicial);
    char aux_frase [tamanho_frase_inicial + 1];
    int i, j;

    memset(aux_frase,'\0',tamanho_frase_inicial); // limpar o conteudo, colocando vazio nela

    for (i=0; frase_inicial[i] != '\0'; i = i + 1)
    {
      for (j=0; j < tamanho_frase_inicial;  j = j + 1)
      {

          if (frase_inicial[i] == aux_frase[j])
          {
            break;
          } else
          {
            if (aux_frase [j] == '\0')
            {
              aux_frase [j] = frase_inicial[i];
              break;
            }
          }
      }
    }

    int tamanho = strlen (aux_frase);
    return tamanho;
  }

  int main(){
    char frase_inicial [100];

    printf("Digite um nome:\n");
    scanf("%s", &frase_inicial);

    int tamanho = val_max_substring(frase_inicial);
    printf("%d \n", tamanho);

    return 0;
  }
