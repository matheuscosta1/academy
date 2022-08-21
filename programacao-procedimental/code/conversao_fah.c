#include <stdio.h>


int main(){

    int celsius = 0;
    float fahrenheit, kelvin;

    while(1){

        
        fahrenheit = 9 * (celsius / 5.0) + 32;
        kelvin = celsius + 273.15;

        if(fahrenheit > 200) {}

        printf("%.2f %.2f", fahrenheit, kelvin);
        celsius++;

    }

    return 0;
}