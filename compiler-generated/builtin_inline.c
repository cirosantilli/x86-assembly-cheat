/*
Will `abs(-1)` be inlined, or precalculated?
The compiler coud know that it is deterministic and has no side effects.

GCC 4.8: yes, even at -O0.
*/

#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("%d\n", abs(-1));
    printf("%d\n", abs(-1));
    return 0;
}
