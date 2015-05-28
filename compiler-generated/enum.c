#include <stdio.h>

/*
enums in C need not be represented in object files, and are omited from them.

To use an enum across files, you must put it in a header file and include.
*/
enum my_enum {
    my_enum_a = 0,
    my_enum_b = 1
};

int main() {
    printf("%d\n", my_enum_a);
    return 0;
}
