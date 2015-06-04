#include <stdio.h>
#include <time.h>

int main() {
    float f;
    f = (float)(time(NULL) % 3);
    /*
    GCC 4.8:

    - fpmath=sse: addss (default)
    - fpmath=fpu: faddp
    */
    f += 0.5f;
    printf("%f\n", f);
    return 0;
}
