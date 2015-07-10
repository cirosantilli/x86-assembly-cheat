/*
# Module upper bound
*/

#include <time.h>
#include <math.h>
#include <stdlib.h>

int main() {
    int i = time(NULL);
    srand(i);
    double d = i;
    unsigned int u = i;
    unsigned int u01 = i % 2U;

    /* -O3 */
    if (u01 == 2U) exit(0x1);
    if (u01 > 1U) exit(0x2);
    if (u01 + 1 > 2U) exit(0x3);
    if (i > 0)
        if (i < 0)
            exit(0x4);
    if (d > 0.0)
        if (d < 0.0)
            exit(0x5);

    /* No. */
    if (rand() < 0)
        exit(0x6);
    if (sin(i) > 1.1) exit(0x80);
    if (sqrt(i) < 0.0) exit(0x81);

    return 0;
}
