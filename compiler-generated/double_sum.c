#include <stdio.h>
#include <time.h>

int main() {
    double f;
    f = (double)(time(NULL) % 3);
    /*
    GCC 4.8:

    - fpmath=sse: addsd (default)
    */
    f += 0.5;
    printf("%f\n", f);
    return 0;
}
