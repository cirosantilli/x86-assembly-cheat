#include <stdio.h>
#include <stdlib.h>

extern char **environ;

int test(int argc, char **argv) {
    /* Trash. */
    printf("argc = %d\n", argc);
    /* Setup. */
    printf("environ[0] = %s\n", environ[0]);
    exit(0);
}
