/*
Spread out case numbers to see is table is still used.
*/

#include <stdio.h>
#include <time.h>

int main() {
    int i, j;
    i = time(NULL) % 6;
    switch (i) {
        case 1:
            j = 0;
        break;
        case 2:
            j = 1;
        break;
        case 4:
            j = 2;
        break;
        case 8:
            j = 3;
        break;
        case 16:
            j = 4;
        break;
        case 32:
            j = 5;
        break;
    };
    printf("%d\n", j);
    return 0;
}
