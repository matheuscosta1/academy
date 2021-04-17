  #include <stdio.h>
  #include <stdlib.h>

  int main( int argc, char **argv )
  {

    unsigned int numero, unidade, dezena, centena, milhar;

    char nomes_unidades[11][7] = {
      "Zero", "Um", "Dois", "Três", "Quatro",
      "Cinco", "Seis", "Sete", "Oito", "Nove"
    };

    char nomes_dezenas[10][11] = {
      "", "", "Vinte", "Trinta", "Quarenta",
      "Cinquenta", "Sessenta", "Setenta", "Oitenta", "Noventa"
    };

    char nomes_centenas[10][15] = {
      "", "Cento", "Duzentos", "Trezentos", "Quatrocentos",
      "Quinhentos", "Seiscentos", "Setecentos", "Oitocentos", "Novecentos"
    };

    char nomes_especiais[11][11] = {
      "Dez", "Onze", "Doze", "Treze", "Catorze",
      "Quinze", "Dezesseis", "Dezessete", "Dezoito", "Dezenove"
    };

    numero = (unsigned int) atoi( argv[1] );
      if( numero > 9999){
        printf("O número deve ser um inteiro e estar no intervalo [0,9999]\n\n");
        exit(1);
      }

    unidade = numero % 10;
    dezena  = ( numero / 10 ) % 10;
    centena = (numero / 100) % 10;
    milhar = numero / 1000;
    printf("Resultado: ");

    if( milhar > 0 && ( centena > 0 || dezena > 0 || unidade > 0)){
        printf("%s mil e ", nomes_unidades[milhar]);
    } else if(milhar > 0) printf("%s", nomes_unidades[milhar]);

    if( centena > 1 && ( dezena > 0 || unidade > 0 ) ){
      printf("%s e ", nomes_centenas[centena]);
    } else {
      if( centena == 1 ) printf("Cem");
      else printf("%s\n", nomes_centenas[centena]);
      exit(1);
    }

    if( dezena > 1 ){
      if( unidade > 0){
        printf("%s e %s", nomes_dezenas[dezena], nomes_unidades[unidade]);
      } else printf("%s", nomes_dezenas[dezena]);

    } else {

      if( dezena == 1 ) printf("%s", nomes_especiais[unidade]);
      else printf("%s", nomes_unidades[unidade]);

    }
    printf("\n");
    return 0;
  }
