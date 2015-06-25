/*
Spread switch numbers even more.

GCC 4.8 -O0: Seems to do binary search from some point onwards.
*/

#include <stdio.h>
#include <time.h>

int main() {
    int i, j;
    i = time(NULL) % 1000000;
    j = -1;
    switch (i) {
        case 0:
            j = 0;
        break;
        case 1:
            j = 1;
        break;
        case 0x10:
            j = 2;
        break;
        case 0x100:
            j = 3;
        break;
        case 0x1000:
            j = 4;
        break;
        case 0xFFFFFFF:
            j = 5;
        break;
    };
    printf("%d\n", j);
    return 0;
}
