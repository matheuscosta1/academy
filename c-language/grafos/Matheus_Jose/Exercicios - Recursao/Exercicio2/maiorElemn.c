#include <stdio.h>

int maiorElemRecur(int c[], int size){
    int last = c[size];
    if(size==0) return 0;
    else if(c[size-1] > maiorElemRecur(c, size-1)) return (c[size-1]);
    else return maiorElemRecur(c,size-1);
}

int main ()
{
    int i[5] = {1,7,8,3};

    int j = maiorElemRecur(i, 5);
    printf("%d", j);
}
