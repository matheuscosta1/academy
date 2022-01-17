#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define epsilon 1

typedef float real;		// usar float para precisão simples e double para precisão dupla

real fun (real x)
{
    return (real) (x*x*x)-100; // usar a0 = 2 e b0 = 3
    //return (real) (x*x*x - x - 1.0); // usar a0 = 1 e b0 = 2
}

int main ()
{

    real a, b, x, fx, fa, fb;
    unsigned int k;
    
    a = 4.0; // a0
    b = 5.0; // b0
    fa = fun(a);
    fb = fun(b);
    k = 0;
    
    // Método da bisseção 
    printf("\nMétodo da bisseção para a0 = %f e b0 = %f\n\n", a, b);
    do {
        k++;
        x = (a+b)/2.0;
        fx = fun(x);
    
        printf("x%d = %.7f. f  = %.7f\n", k, x, fx);
    
        if (fa*fx < 0) {
            b = x;
            fb = fx;
        } else {
            a = x;
            fa = fx;
        }
    
    } while (fabs(fx) >= epsilon);			// critério de parada
   
   //return 0;

   
   
    a = 2.0;
    b = 3.0;
    fa = fun(a);
    fb = fun(b);
    k = 0;
  
   
    // Método da falsa posição
    printf("\nMétodo da falsa posição para a0 = %f e b0 = %f\n\n", a, b);
    do {
        k++;
        x = (a*fun(b) - b*fun(a))/(fun(b)-fun(a));
        fx = fun(x);
        
        printf("x%d = %.7f. f  = %.7f\n", k, x, fx);
        
        
        
        if (fa*fx < 0) {
            b = x;
            fb = fx;
        } else {
            a = x;
            fa = fx;
        }
    
    } while (fabs(fx) > epsilon);			// critério de parada
    
    
    return 0;
   
    // Método da secante
    k = 1;
    a = 1;
    b = 2;
    real xk, xk1, fxk, fxk1; // x[k], x[k-1]
    
    xk1 = 1.5;
    xk = 1.7;
    
    fxk1 = fun(xk1);
    fxk = fun(xk);
    
    printf("\nMétodo da secante para x0 = %f e x1 = %f\n\n", xk1, xk);
    do {
        k++;
        x = (xk1*fxk - xk*fxk1)/(fxk - fxk1);
        fx = fun(x);
        
        printf("x%d = %.7f. f  = %.7f\n", k, x, fx);
        
        xk1 = xk;
        xk = x;
        
        fxk1 = fxk;
        fxk = fx;

    } while (fabs(fx) > epsilon);			// critério de parada
   
  //return 0;
}



