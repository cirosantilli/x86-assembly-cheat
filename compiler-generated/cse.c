/*
# CSE

# Common subexpression elimination

    https://en.wikipedia.org/wiki/Common_subexpression_elimination

    Will `a * b` be calculated only once?

    GCC 4.8: yes, at `-O3`, no at `-O0`.
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
    int a, b;
    a = time(NULL);
    b = time(NULL);
    printf("%d\n", a * b + 1);
    printf("%d\n", a * b * 2);
    return 0;
}
