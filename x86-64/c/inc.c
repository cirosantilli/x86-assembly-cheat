/* Icrement a variable. */

#include <assert.h>
#include <inttypes.h>

int main(void) {
    uint64_t io = 0xFFFFFFFF;
    __asm__ (
        "inc %[io];"
        : [io] "+r" (io)
        :
        :
    );
    assert(io == 0x100000000);
}
