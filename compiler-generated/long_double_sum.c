#include <stdio.h>
#include <time.h>

int main() {
    long double f;
    f = (long double)(time(NULL) % 3);
    /*
    GCC 4.8: faddp by default. Constrast wth double which uses SSE.

    Reason: FPU has the 80-bit operations which GCC uses for `long double`.
    There is no 128-bit instrution in SSE.
    */
    f += 0.5L;
    printf("%Lf\n", f);
    return 0;
}
