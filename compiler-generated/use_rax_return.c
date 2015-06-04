#include <stdio.h>

int global = 0;

int my_function() {
    /*
    Is the compiler smart enough to move global into `rax` to increment it,
    to reuse that for the return value?

    Yes for GCC 4.8 -O3
    */
    global++;
    return global;
}

int main() {
    printf("%d\n", my_function());
    printf("%d\n", my_function());
    return 0;
}
