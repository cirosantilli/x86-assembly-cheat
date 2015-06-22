/*
GCC 4.8: if else
*/

#include <stdio.h>
#include <time.h>

int main() {
    int i, j;
    i = time(NULL) % 3;
    switch (i) {
        case 0:
            j = 0;
        break;
        case 1:
            j = 1;
        break;
        case 2:
            j = 2;
        break;
    };
    printf("%d\n", j);
    return 0;
}
