/*
Will `abs(-1)` be optimized away?
The compiler must know that it has no internal side effects.

GCC 4.8: yes, even at -O0.
*/

#include <stdio.h>
#include <stdlib.h>

int main() {
    abs(-1);
    return 0;
}
