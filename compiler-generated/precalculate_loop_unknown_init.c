/*
# Precalculate loop

    Yup.
*/

#include <stdio.h>
#include <time.h>

int main() {
    unsigned long i, j;
    j = time(NULL);
    for (i = 0; i < 0xFFFFFFFFFFFFFFFFu; i++, j++)
        ;
    printf("%lx\n", j);
    return 0;
}
