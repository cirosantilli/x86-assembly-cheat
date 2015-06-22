/*
Let's look at the C++ vtable.
*/

#include <cassert>
#include <ctime>

int main() {
    class Base {
        public:
            virtual int f() { return 0; }
    };

    class Derived1 : public Base {
        public:
            virtual int f() { return 1; }
    };

    class Derived2 : public Base {
        public:
            virtual int f() { return 2; }
    };

    Base *bp;
    int i;

    Base b;
    bp = &b;
    i = bp->f();
    assert(i == 0);

    Derived1 d1;
    bp = &d1;
    i = bp->f();
    assert(i == 1);

    Derived2 d2;
    bp = &d2;
    i = bp->f();
    assert(i == 2);
}
