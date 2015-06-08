#include <stdio.h>

int main() {
    float f;
    /*
    GCC 4.8: Unlike ints, float literals are stored in memory.
    TODO why? double just uses immediates. To save space because
    not possible to have 4 byte immediates?
    */
    f = 0.0f;
    f = 1.0f;
    printf("%f\n", f);
    return 0;
}
