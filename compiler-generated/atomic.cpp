/*
GCC 4.8 compiles to xadd through the __atomic_fetch_add built-in.
*/

#include <atomic>
#include <cassert>
#include <thread>

#if __cplusplus >= 201103L
const int NUM_THREADS = 1000;
const int NUM_ITERS = 1000;

std::atomic_int global(0);

void threadMain() {
    for (int i = 0; i < NUM_ITERS; ++i)
        global++;
}
#endif

int main() {
#if __cplusplus >= 201103L
    std::thread threads[NUM_THREADS];
    int i;
    for (i = 0; i < NUM_THREADS; ++i)
        threads[i] = std::thread(threadMain);
    for (i = 0; i < NUM_THREADS; ++i)
        threads[i].join();
    assert(global.load() == NUM_THREADS * NUM_ITERS);
#endif
}
