#include "stdio.h"
#include "time.h"

int main() {
    int i;
    i = !time(NULL);
    if (__builtin_expect(i, 0))
        printf("%d\n", i);
    puts("a");
    return 0;
}
