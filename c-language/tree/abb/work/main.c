#include <stdio.h>
#include <stdlib.h>
#include "ABB.h"

int main()
{
    Registro g;
    Arv a=Cria_arvore();
    Arv b=Cria_arvore();
    g=Cria_Registro(19,"Felipe","Computacao");
    insere_ord(&a,g);

     g=Cria_Registro(55,"Otavio","saude");
    insere_ord(&a,g);

    g=Cria_Registro(35,"Marcos","Nutri");
    insere_ord(&a,g);

    g=Cria_Registro(17,"olivia","Med");
    insere_ord(&a,g);

    g=Cria_Registro(22,"Joao","quatro");
    insere_ord(&a,g);

    g=Cria_Registro(10,"vitor","fundamental");
    insere_ord(&a,g);

    exibe_arvore(a);
    printf("\n");
    exibe_ord(a);
/*
    printf("Nfolhas:%d\n",folhas(a));
    printf("Completa :%d\n",completa(a));
    printf("intermediarios:%d\n",intermediarios(a));
    printf("Maior:");imprime(Maior(a));
    printf("de_maior:%d\n",de_maior(a));
    printf("um filho:%d\n",um_filho(a));
*/
  g=Cria_Registro(23,"Fabio","Computacao");
    insere_ord(&b,g);

     g=Cria_Registro(43,"Olavio","saude");
    insere_ord(&b,g);

    g=Cria_Registro(33,"Joao","Nutri");
    insere_ord(&b,g);

    g=Cria_Registro(16,"holanda","Med");
    insere_ord(&b,g);

    g=Cria_Registro(12,"caio","quatro");
    insere_ord(&b,g);

    g=Cria_Registro(13,"vitor","fundamental");
    insere_ord(&b,g);

   Arv c=juntar(a,b);

  exibe_arvore(c);

exibe_ord(c);
    libera_arvore(&b);
    libera_arvore(&a);
}
