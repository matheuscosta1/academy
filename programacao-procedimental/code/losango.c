#include <stdio.h>

int main(){
    int h, i, j, antes, espacos=1;
    do {
     printf("Insira altura do losango( numero natural impar ): ");
     scanf("%d", &h);
     }while(h%2 == 0);
     
    antes = h;
    for(i = 0; i < h; i++){
        for(j = 0; j < antes; j++)printf(" ");
        for(j = 0; j< espacos; j++){
            if(j == 0 || j == espacos -1 )printf("*");
            else printf(" ");
        }
        printf("\n");
        if(i < h/2){
            espacos +=2;
            --antes;
        }else{
            ++antes;
            espacos -=2;
        }
    }
    return 0;
}
