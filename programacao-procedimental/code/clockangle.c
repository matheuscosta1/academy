#include <stdio.h>
int angulo (int, int);

int main(int argc, char const *argv[]) {

int a = angulo (1,0);
printf("%d", a);
  return 0;
}

int angulo(int horas, int minutos){
  int graus, graus1, graus2, angulo;
  graus1= horas * 30;
  graus2= minutos * 6;

  if (minutos == 0)
    return graus1;

if (minutos > 10 && minutos < 20) graus= graus1 + 6;
else if (minutos > 20 && minutos < 30) graus= graus1 + 12;
    else if (minutos > 30 && minutos < 40) graus= graus1 + 18;
        else if (minutos > 40 && minutos < 50) graus= graus1 + 24;
              else if(minutos > 50) graus= graus1 + 30;

if (graus1 > graus2)
  angulo = graus - graus2;
else angulo = graus2 - graus;

return angulo;
}
