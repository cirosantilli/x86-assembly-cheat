/*
# Precalculate loop

    Will the compiler precalculate a loop without side effects, and with deterministic inputs?

    GCC 4.8 -O3: yes. Without this optimization, it takes forever.

    TODO what is the name for this? Is it related to loop unroling?
*/

#include <stdio.h>

int main() {
    unsigned long i;
    for (i = 0; i < 0xFFFFFFFFFFFFFFFFu; i++)
        ;
    printf("%lx\n", i);
    return 0;
}
