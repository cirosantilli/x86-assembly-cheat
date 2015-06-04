#include <math.h>
#include <stdio.h>
#include <time.h>

int main() {
    float f;
    f = time(NULL) % 3;
    /* Calls glibc, which uses `sqrtsd` */
    f = sqrt(f);
    printf("%f\n", f);
    return 0;
}
