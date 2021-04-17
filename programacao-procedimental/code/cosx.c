#include<stdio.h>
#include<math.h>
int main()
{
    int i;
    float x;
    double a,b,pi,r;
	printf("digite o angulo que deseja saber o cosseno: ");
	scanf("%f",&x);
    if (x>360)
    {
        a=(x/360);
        x=(x-(a*360));
    }

    if ((x>=90)&&(x<=270))x=(180-x);
    if ((x>270)&&(x<=360))x=(x-360);
    if (x<-360)
    {
        a=(x/360);
        x=(x-(a*360));
    }
    if ((x<-90)&&(x>=-270))x=(-180-x);
    else if ((x<-270)&&(x>=-360))x=(x-(-360));
    pi=3.141592653589;
    r=(x*pi)/180;
	a=1;
	b=1;
	for(i=2;i<21;i+=2)
    {
        b*=((-pow(r,2))/(i*(i-1)));
        a+=b;
    }
    printf("o cosseno de %.2f eh igual a %lf",x,a);
    return 0;
}
