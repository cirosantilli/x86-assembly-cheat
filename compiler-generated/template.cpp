/*
# template
*/

#include <cassert>

template <class C>
C f(C i) { return i; }

int main() {
    f<int>(1);
    f<double>(1.5);
}
