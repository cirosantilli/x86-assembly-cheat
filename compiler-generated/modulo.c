/*
GCC 4.8 uses a complicated set of instructions to avoid div which is a very slow instruction.

http://stackoverflow.com/questions/4361979/how-does-the-gcc-implementation-of-module-work-and-why-does-it-not-use-the
*/

#include <stdio.h>
#include <time.h>

int main() {
    int i = (int)(time(NULL) % 3);
    printf("%d\n", i);
    return 0;
}
