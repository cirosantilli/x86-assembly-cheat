#include <stdio.h>
#include <time.h>

int main() {
    int i;
    float f;
    f = (float)(time(NULL) % 3) + 0.5;
    /*
    - sse: cvttss2si
    */
    i = (int)f;
    printf("%d\n", i);
    return 0;
}
