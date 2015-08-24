#include "stdio.h"
#include "time.h"

int main() {
    int i;
    i = !time(NULL);
    if (__builtin_expect(i, 0))
        puts("a");
    return 0;
}
