/*
# CSE function

# Common subexpression elimination function

    http://stackoverflow.com/questions/1982131/is-loop-hoisting-still-a-valid-manual-optimization-for-c-code

    Will `f(a)` be calculated only once?

    The compiler must prove that the function has no side effects.

    In GCC, the attribute `const` tells that to the compiler, but it alone does not guarantee the hoisting:
    you might also have to play with the hoisting parameters if the function is complex.

    GCC 4.8: yes, at `-O3`, no at `-O0`.
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int f(int x) {
    return x * x;
}

int main() {
    int a;
    a = time(NULL);
    printf("%d\n", f(a) + 1);
    printf("%d\n", f(a) * 2);
    return 0;
}
