#include <stdio.h>
#include <time.h>

int main() {
    if ((int)time(NULL)) {
        puts("1");
    } else {
        puts("0");
    }
    return 0;
}
