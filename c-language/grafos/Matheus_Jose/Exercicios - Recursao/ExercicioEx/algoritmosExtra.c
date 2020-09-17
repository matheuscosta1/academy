#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int somaQ(int a, int b){
        if (a == b)
            return (a*a);
        else return (((a*a)+somaQ(a+1,b)));
}

void recursiveFunc1(int num){
    if (num < 5){
        recursiveFunc1(num+1);
        printf("%d\t", num);
    }
}

void recursiveFunc2(int num){
    if (num < 5){
        printf("%d\t", num);
        recursiveFunc2(num+1);
    }
}

int main(){

    recursiveFunc1(1);
}
