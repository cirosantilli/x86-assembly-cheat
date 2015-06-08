#include <stdio.h>

int main() {
    long double f;
    /* Uses rax and rdx for the long double. */
    f = 0.0L;
    f = 1.0L;
    printf("%Lf\n", f);
    return 0;
}
