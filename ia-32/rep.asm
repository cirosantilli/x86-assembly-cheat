; # rep

    ; Repeat string instruction ecx times

    ; Variants: `rep(n|)[ze]`

    ; Repeats a given instruction until something happens.

    ; Can only be used on certain operations:

    ; - REP prefix can be added to the INS, OUTS, MOVS, LODS, and STOS
    ; - REPE, REPNE, REPZ, and REPNZ can be added to the CMPS and SCAS

    ; C insight: this is why memcpy and memcmp may be faster than for loops
    ; it is easier for compiler to use these faster string commands.

    ; But note that as of 2015, gcc compiles string structions to call the stdlib,
    ; which is highly optimized, and may use SIMD.

%include "lib/asm_io.inc"

section .data

    bs4 db 0, 1, 2, 3
    bs4_2 db 0, 0, 0, 0

ENTRY

    ; # memcpy

        ; Note that this is not the most efficient implementation possible:
        ; modern glibc uses SIMD.

        cld
        mov edi, bs4
        mov ecx, 2
        mov eax, 0
        rep stosb
        ASSERT_EQ [bs4], 0, byte
        ASSERT_EQ [bs4+1], 0, byte
        mov eax, edi
        sub eax, bs4
        ASSERT_EQ 2
        ASSERT_EQ ecx, 0

    ; # memcmp

        ; TODO

    ; # memchr

        cld

        mov esi, bs4
        mov byte [bs4], 0
        mov byte [bs4 + 1], 1

        mov edi, bs4_2
        mov byte [bs4_2], 0
        mov byte [bs4_2 + 1], 1

        mov ecx, 2
        repz cmpsb
        ASSERT_FLAG jz
        ASSERT_EQ ecx, 0

        mov ecx, 2
        mov byte [bs4_2 + 1], 2
        repz cmpsb
        ASSERT_FLAG jnz
        ASSERT_EQ ecx, 1

    EXIT
