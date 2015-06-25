/*
# virtual

    Let's look at the C++ vtable.

    - http://stackoverflow.com/questions/5712808/understanding-the-vtable-entries
    - http://stackoverflow.com/questions/1963926/when-is-a-vtable-created-in-c

    Every virtual class has:

    - a vtbale: an array of addresses of the methods of the class stored in `.rodata`
    - an extra hidden field which points to the vtable of this class
    - extra initialization code on the constructor that sets this hidden field

    Whenever a virtual method call is done, it:

    - dereferenes the hidden field to find the vtable
    - adds an known offset depending on which method is being called.
        Each method must have a fixed position in the vtbale for all classes.
    - dereferences that address and calls it with `callq *%rax`

# typeinfo

    There is a single typeinfo object for each virtual class, and it is stored
    8 bytes before the first function.

# TODO

    And there is yet another field on each vtables:

    http://stackoverflow.com/questions/5712808

    TODO: observe it.
*/

#include <cassert>
#include <typeinfo>
#include <iostream>

int main() {
    class Base {
        public:
            int i;
            Base(int i) : i(i) {}
            virtual int f() { return this->i; }
            virtual int g() { return this->i + 10; }
    };

    class Derived1 : public Base {
        public:
            Derived1(int i) : Base(i) {}
            virtual int f() { return this->i + 1; }
            virtual int g() { return this->i + 11; }
    };

    class Derived2 : public Base {
        public:
            Derived2(int i) : Base(i) {}
            virtual int f() { return this->i + 2; }
            virtual int g() { return this->i + 12; }
    };

    Base *bp;
    int i;

    // For each object of a virtual class, store the call table address
    // on the stack for it. This address falls in `.rodata`.
    Base b(0);
    bp = &b;
    i = bp->f();
    assert(i == 0);
    i = bp->g();
    assert(i == 10);
    std::cout << typeid(*bp).name() << std::endl;

    Derived1 d1(0);
    bp = &d1;
    i = bp->f();
    assert(i == 1);
    i = bp->g();
    assert(i == 11);
    std::cout << typeid(*bp).name() << std::endl;

    Derived2 d2(0);
    bp = &d2;
    i = bp->f();
    assert(i == 2);
    i = bp->g();
    assert(i == 12);
    std::cout << typeid(*bp).name() << std::endl;
}
