/*
Return values normally go on `rax`.

But what happens when returning a large struct that does not fit into registers?
*/

#include <stdio.h>
#include <time.h>

struct S {
    int i0;
    int i1;
    int i2;
    int i3;
    int i4;
    int i5;
    int i6;
    int i7;
    int i8;
    int i9;
    int i10;
    int i11;
    int i12;
    int i13;
    int i14;
    int i15;
};

struct S f() {
    struct S s = {
        time(NULL), time(NULL), time(NULL), time(NULL),
        time(NULL), time(NULL), time(NULL), time(NULL),
        time(NULL), time(NULL), time(NULL), time(NULL),
        time(NULL), time(NULL), time(NULL), time(NULL)
    };
    return s;
}

int main() {
    /*
    GCC 4.8 allocates stack space and passes a pointer to it as a hidden parameter.

    f() then initializes that parameter's location.
    */
    struct S s = f();
    int n =
        s.i0 +
        s.i1 +
        s.i2 +
        s.i3 +
        s.i4 +
        s.i5 +
        s.i6 +
        s.i7 +
        s.i8 +
        s.i9 +
        s.i10 +
        s.i11 +
        s.i12 +
        s.i13 +
        s.i14 +
        s.i15;
    printf("%d\n", n);
    return 0;
}
