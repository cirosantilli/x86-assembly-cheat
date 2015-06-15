/* TODO unable to see any difference with or without register. */

#include <time.h>

int f() {
    int i = 0;
    /*
    TODO: GCC 4.8 -O3 seems to ignore the possibility that this might change i,
    and always returns 0.

    So we don't observe any difference when using `register`.
    */
    (*((int*)time(NULL)))++;
    return i;
}

int g() {
    register int i = 0;
    (*((int*)time(NULL)))++;
    return i;
}

int main() {
    return 0;
}
