#include "stdio.h"
#include "time.h"

int main() {
    int i;
    i = !time(NULL);
    if (i)
        puts("a");
    return 0;
}
