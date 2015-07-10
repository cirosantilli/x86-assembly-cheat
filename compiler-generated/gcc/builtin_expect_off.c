#include "stdio.h"
#include "time.h"

int main() {
    int i;
    i = !time(NULL);
    if (i)
        printf("%d\n", i);
    puts("a");
    return 0;
}
