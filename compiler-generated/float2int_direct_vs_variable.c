/*
http://stackoverflow.com/questions/17220787/c-casting-from-double-to-int

Don't reproduce him.
*/

#include <stdio.h>
#include <stdarg.h>

int main() {
    int a;
    int d;
    double b = 0.41;

    /* Cast from variable. */
    double c = b * 100.0;
    a = (int)(c);

    /* Cast expression directly. */
    d = (int)(b * 100.0);

    printf("c = %f \n", c);
    printf("a = %d \n", a);
    printf("d = %d \n", d);

    return 0;
}
