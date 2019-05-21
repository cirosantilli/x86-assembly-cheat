/* https://stackoverflow.com/questions/7346929/what-is-the-advantage-of-gccs-builtin-expect-in-if-else-statements/31540623#31540623 */

#include <stdlib.h>
#include <stdio.h>
#include <time.h>

int main() {
    enum N { N = 8 };
    unsigned int i, x[N], y;
    srand(time(NULL));
    y = rand();
    for (i = 0; i < N; i++) {
        x[i] = rand() & 4;
    }
    for (i = 0; i < 100000000; i++) {
        if (!x[0]) y++;
        if (x[1]) y++;
        if (x[2]) y++;
        if (!x[3]) y++;
        if (!x[4]) y++;
        if (x[5]) y++;
        if (!x[6]) y++;
        if (x[7]) y++;
        y =  2*y*y + 3*y + 5;
    }
    printf("%u\n", y);
    return 0;
}
