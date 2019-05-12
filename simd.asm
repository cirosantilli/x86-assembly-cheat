; # SIMD

    ; Do a single operations at once on multiple memory locations,
    ; e.g. add four integers in one go.

    ; https://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-linux-docs/CellProgrammingTutorial/BasicsOfSIMDProgramming.html

    ; SIMD came in multiple stages: first MMX, then XMM, then SSE[1-4], then AVX.

    ; SIMD uses:

    ; - https://software.intel.com/en-us/intel-ipp

%include "lib/common_nasm.inc"

section .bss

    resd0 resd 1
    resd1 resd 1
    reso0 reso 1
    reso1 reso 1

ENTRY

    ; # SIMD Registers

        ; # XMM

            ; # movss

                ; Move Scalar Single precision 32 bits to or from memory.

                    mov dword [resd0], __float32__(0.1)
                    movss xmm0, [resd0]
                    movss xmm1, xmm0
                    movss [resd1], xmm1
                    ASSERT_EQ [resd0], __float32__(0.1), dword

            ; # movups

                ; Move Unaligned Parallel Single-precision float

                ; From SSE extensions.

                ; 16 bytes.

                    MOV4 reso0, 0x0000_0000, 0x1000_0000, 0x2000_0000, 0x3000_0000

                    movups xmm0, [reso0]
                    ; Can also move between two xmm.
                    ; But in this case we can use movaps.
                    movaps xmm1, xmm0
                    movups [reso1], xmm1

                    ASSERT_EQ4 reso1, 0x0000_0000, 0x1000_0000, 0x2000_0000, 0x3000_0000

                ; ERROR: invalid combination of opcode and operands.

                    ;movups xmm0, 0
                    ;mov xmm0, [reso0]

                ; Can only move data between RAM and XMM, no literals.

                ; movups must be used, mov does not work

            ; # movaps

                ; Aligned.

                ; May be faster.

                ; If you attempt to use it on unaligned memory,
                ; raises a general-protection exception (#GP).
                ; Let's do that now. One of the following must be misaligned:

                    ;movaps xmm0, [reso0]
                    ;movaps xmm0, [reso0 + 1]

                ; Linux gives a segmentation fault.

                ; # aligned

                ; # unaligned

                    ; TODO why is aligned faster?

                    ; TODO how to align?

                    ; http://stackoverflow.com/questions/381244/purpose-of-memory-alignment


            ; # MOVHPS - Move 64bits to upper bits of an SIMD register (high).

            ; # MOVLPS - Move 64bits to lowe bits of an SIMD register (low).

            ; # MOVHLPS - Move upper 64bits of source  register to the lower 64bits of destination register.

            ; # MOVLHPS - Move lower 64bits of source register  to the upper 64bits of destination register.

            ; # MOVMSKPS - Move sign bits of each of the 4 packed scalars to an x86 integer register.

    ; # packed

    ; # scalar

        ; http://stackoverflow.com/questions/16218665/simd-and-difference-between-packed-and-scalar-double-precision

        ; Many SIMD instructions have two versions: parallel and scalar.

        ; - scalar only acts on the first bytes, doing a single value operation.

            ; It likely exists to allow FPU replacement.

        ; - packed: the more interesting method, which operates on multiple data at once (4 floats or 2 doubles)

    ; # SSE2

        ; # cvttss2si

            ; Convert with Truncation Scalar Single-Precision FP Value to Dword Integer.

            ; Typecast float to int.

                mov dword [resd0], __float32__(1.5)
                movss xmm0, [resd0]
                cvttss2si eax, xmm0
                call print_int
                ASSERT_EQ eax, 1

    ; # SSSE3

    ; # SSE4

EXIT
