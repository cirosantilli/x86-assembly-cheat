/*
# memcmp

    GCC 4.8 calls glibc always.

    glibc has lengthy SIMD implementations, so it is not viable to inline it.

    http://stackoverflow.com/questions/21106801/why-is-memcmp-so-much-faster-than-a-for-loop-check
*/

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int main() {
    size_t i;
    int out;
    enum N { N = 2 };
    char s[N];
    char s2[N];
    srand(time(NULL));
    for (i = 0; i < N; ++i) {
        s[i] = rand() % SCHAR_MAX;
        s2[i] = rand() % SCHAR_MAX;
    }
    out = memcmp(s, s2, N);
    printf("%d\n", out == 0);
    return 0;
}
