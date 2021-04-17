#include <stdio.h>

int main(){
    int a,b, soma=0;
    
    printf("Digite dois numeros inteiros postivos (a b):");
    scanf("%d%d", &a, &b);
    if(a&1)soma+=b;
    printf("%dx%d = ",a,b);
    while(1){
        a = a/2;
        b = b*2;
        if(a&1)soma+=b;
        if(a==1)break;
    }
    printf("%d\n",soma);
    return 0;
}