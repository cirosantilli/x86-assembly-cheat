# # rep

    # Repeat string instruction ecx times

    # As the repetitions happen:

    # - ecx decreases
    # - edi and esi increase

    # Variants: `rep(n|)[ze]`

    # Repeats a given instruction until something happens.

    # Can only be used on certain operations:

    # - REP prefix can be added to the INS, OUTS, MOVS, LODS, and STOS
    # - REPE, REPNE, REPZ, and REPNZ can be added to the CMPS and SCAS

    # C insight: this is why memcpy and memcmp may be faster than for loops
    # it is easier for compiler to use these faster string commands.

    # But note that as of 2015, gcc compiles string structions to call the stdlib,
    # which is highly optimized, and may use SIMD.

    # Note that this is not the most efficient implementation possible
    # of the C string instructions: like memset and memcmp: modern glibc uses SIMD.

#include <lkmc.h>

.bss

    src resb 4
    dest resb 4

LKMC_PROLOGUE

    cld

    # # memset

        # Set memory to `al`.

        mov byte [dest + 0], 0
        mov byte [dest + 1], 0

        movl $dest, %edi
        movl $2,%ecx
        movb $1,%al
        rep
        stosb
        LKMC_ASSERT_EQ_32 [dest + 0], 1, byte
        LKMC_ASSERT_EQ_32 [dest + 1], 1, byte

        # edi and ecx move as well.
        movl %edi,%eax
        subl $dest, %eax
        LKMC_ASSERT_EQ_32(%eax, $2)
        LKMC_ASSERT_EQ_32(%ecx, $0)

    # # memchr

        # TODO

    # # memcpy

        mov byte [src + 0], 1
        mov byte [src + 1], 2
        mov byte [src + 2], 3
        mov byte [dest + 0], 0
        mov byte [dest + 1], 0
        mov byte [dest + 1], 0

        movl $src, %esi
        movl $dest, %edi
        movl $3,%ecx
        rep
        movsb

        LKMC_ASSERT_EQ_32 [dest + 0], 1, byte
        LKMC_ASSERT_EQ_32 [dest + 1], 2, byte
        LKMC_ASSERT_EQ_32 [dest + 2], 3, byte

    # # memcmp

        mov byte [src + 0], 0
        mov byte [src + 1], 1
        mov byte [src + 2], 2
        mov byte [dest + 0], 0
        mov byte [dest + 1], 1
        mov byte [dest + 1], 3

        # Compare 2 bytes. They are equal.
        movl $src, %esi
        movl $dest, %edi
        movl $2,%ecx
        repz cmpsb
        LKMC_ASSERT_EQ_32(%ecx, $0)

        # Compare 3 bytes. Last byte differs.
        movl $src, %esi
        movl $dest, %edi
        movl $3,%ecx
        repz cmpsb
        LKMC_ASSERT_EQ_32(%ecx, $1)

LKMC_EPILOGUE
