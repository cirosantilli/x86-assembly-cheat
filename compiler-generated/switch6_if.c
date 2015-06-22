/*
Identical to switch 6 but with if else,
so see if the compiler can also optimize it with the jump table.

GCC 4.8 -O0: does not use the jump table.
*/

#include <stdio.h>
#include <time.h>

int main() {
    int i, j;
    i = time(NULL) % 6;
    if (i == 0) {
        j = 0;
    } else if (i == 1) {
        j = 1;
    } else if (i == 2) {
        j = 2;
    } else if (i == 3) {
        j = 3;
    } else if (i == 4) {
        j = 4;
    } else if (i == 5) {
        j = 5;
    };
    printf("%d\n", j);
    return 0;
}
