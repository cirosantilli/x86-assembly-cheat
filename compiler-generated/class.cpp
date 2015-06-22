/*
Basic class concepts:

- constructor
- field
- method
*/

#include <ctime>
#include <iostream>

class C {
    public:
        int i;

        C(int i) : i(i) {}

        /*
        this is passed as an extra argument.

        Like for struct, `this` points directly to the class data.
        */
        int f(int j) {
            int r = std::time(NULL);
            r += i;
            r += j;
            return r;
        }
};

int main() {
    /*
    Passes a hidden argument to this which the constructor initializes.

    Just like returning struct from a function in C.
    */
    C c(1);
    int i = c.f(2);
    std::cout << i << std::endl;
}
