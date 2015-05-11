#include <stdio.h>
#include <time.h>

int my_function(int i, int j) {
    return i + j;
}

int main() {
    printf("%d\n", my_function(1, (int)time(NULL)));
    return 0;
}
