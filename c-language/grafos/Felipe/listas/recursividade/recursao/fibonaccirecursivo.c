#include "fibonaccirecursivo.h"

int fibonacci_r(int n)
{

    if(n<2)
        return n;
    else
        return fibonacci_r(n-1)+fibonacci_r(n-2);
}
