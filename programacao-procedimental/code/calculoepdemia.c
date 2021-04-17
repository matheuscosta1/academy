#include <stdio.h>
int main(int argc, char const *argv[]) {
  struct Data{
    int dia, mes, ano;
  } inicio, hoje;
  int i, pessoas = 0, dias = 0, anos, meses, m_aux, a_aux;
  printf("Data de inicio da epdemia (dia mes ano): ");
  scanf("%d%d%d",&inicio.dia, &inicio.mes, &inicio.ano);
  printf("Data atual (dia mes ano): ");
  scanf("%d%d%d",&hoje.dia, &hoje.mes, &hoje.ano);
  if(inicio.ano == hoje.ano){
      if(inicio.mes == hoje.mes) dias = hoje.dia - inicio.dia;
      else{
        meses = hoje.mes - inicio.mes;
        for(; meses > 0; meses--){
          m_aux = inicio.mes + meses;
            if(m_aux == 4 || m_aux == 6 || m_aux == 9 || m_aux == 11) dias+=30;
            else if(m_aux == 2){
              if(hoje.ano % 4 == 0 && (hoje.ano % 400 == 0 || hoje.ano % 100 != 0))dias+=29;
              else dias +=28;
            }
            else dias +=31;
        }
        dias += hoje.dia - inicio.dia;
        printf("Quantidade de dias: %d\n", dias);
      }
  }else{
      anos = hoje.ano - inicio.ano;
      for(; anos > 0; anos --){
        a_aux = inicio.ano + anos;
          if(a_aux % 4 == 0 && (a_aux % 400 == 0 || a_aux % 100 != 0))dias+=366;
          else dias +=365;
      }
      meses = hoje.mes - inicio.mes;
      if(meses < 0)for(; meses < 0; meses++){
        m_aux = hoje.mes -(meses);
        if(m_aux == 4 || m_aux == 6 || m_aux == 9 || m_aux == 11) dias-=30;
        else if(m_aux == 2){
          if(hoje.ano % 4 == 0 && (hoje.ano % 400 == 0 || hoje.ano % 100 != 0))dias-=29;
          else dias -=28;
        }
        else dias -=31;
      }else if(meses > 0){
        for(; meses > 0; meses--){
          m_aux = inicio.mes + meses;
            if(m_aux == 4 || m_aux == 6 || m_aux == 9 || m_aux == 11) dias+=30;
            else if(m_aux == 2){
              if(hoje.ano % 4 == 0 && (hoje.ano % 400 == 0 || hoje.ano % 100 != 0))dias+=29;
              else dias +=28;
            }
            else dias +=31;
        }
      }
      dias += hoje.dia - inicio.dia;
      printf("Quantidade de dias: %d\n", dias);
  }
  for( i = 1 ; i <= dias; i++){
    if(64*i -  ((i*i*i)/3) < pessoas) break;
    pessoas = 64*i - (i*i*i)/3;
  }
  printf("Quantidade de pesssoas enfermas durante o periodo: %d\n", pessoas);
  return 0;
}
