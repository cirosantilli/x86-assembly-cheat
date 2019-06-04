; # bswap

    ; Little endian <=> big endian.

#include <lkmc.h>

LKMC_PROLOGUE

    mov eax, 0x12345678
    bswap eax
    LKMC_ASSERT_EQ(%eax, $0x78563412)

LKMC_EPILOGUE
