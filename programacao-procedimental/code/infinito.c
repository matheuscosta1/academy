#include <stdio.h>
// Trabalhado com o maximo de conhecimento disponivel, no entanto, o padrao proposto nao foi totalmente respeitado
int main(){
    int h, i, j, antes, espacos = 0;
    printf("Defina a altura da moldura: ");
    scanf("%d", &h);
    antes = h;
    for(i = 0; i<h; i++){
        for(j = 0; j < 3*h; j++)if(j==antes || j == antes+h || j == antes+espacos ||  j == antes+h+espacos) printf(" ");
                                  else printf("%c", 0xC5);
        printf("\n");
        if(i < h/2){
            --antes;
            espacos +=2;
        }else{
            ++antes;
            espacos -=2;
        }
    }
    return 0;
}
