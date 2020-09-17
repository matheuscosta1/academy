#include "fibonacciiterativo.h"


int fibonacci_i(int n)
{
    int k,i=1,f=0;
    for(k=0;k<n;k++)
    {
        f=f+i;
        i=f-i;
    }

    return f;
}
