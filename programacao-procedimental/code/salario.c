#include<stdio.h>

int main()
{
    char n[25];
    int x, i;
    float salario=90000.00;
    printf("Digite seu nome: ");
    scanf("%[^\n]s", n);
    printf("Digite a quantidade de anos que vc trabalha: ");
    scanf("%d",&x);
    for(i=0;i<=x;i++)
    {
        if(i%4==0)salario=salario+((salario*0.08)*0.04);
        else salario=salario+(salario*0.08);
      if(salario>=150000){
        salario=150000.00;
        break;
      }
    }
    printf("%s trabalhou por %d anos. Salario atual: R$ %.2f/ano",n,x,salario);
    return 0;
}
