/*
# Cast int to long.

GCC 4.8 -O0: CDQE: http://stackoverflow.com/questions/6555094/what-does-cltq-do-in-assembly/31114310#31114310
GCC 4.8 -O3: MOVSX, which extends and moves in one go: http://stackoverflow.com/questions/7861095/what-does-movsbl-instruction-do
*/

#include <stdio.h>
#include <time.h>

int main() {
    int i;
    long l;
    i = time(NULL);
    l = i;
    printf("%ld", l);
    return 0;
}
