; # FPU unit

    ; Used to be a separate optional processor called the Floating Point Unit,
    ; later integrated into the CPU.

    ; TODO split one instruction per file.

%include "lib/asm_io.inc"

section .bss

    resd0 resd 1
    resd1 resd 1

section .data

    ; # float literals

        ; Direct float literals can only be used with `dd` family instructions.

        ; Immediates in the text section must use `__floatXX__()`.

        ; TODO move this to a NASM specific section.

    f0 dd 0.0
    f1  dd 1.0
    fm1 dd -1.0
    f1d1 dd 1.5
    f1d01 dd 1.25
    f10 dd 2.0
    f100 dd 4.0

ENTRY

    ; # st0

    ; # stX

        ; Stack in which floating operations are carried out.

        ; `st[0-7]` is a stack

        ; `st0` is always the top of the stack.

        ; You can only communicate with `stX` from memory,
        ; not diretly from registers.

        ; For example, the following are errors:

            ;fld eax
            ;fld __float32__(1.5)

    ; # P suffix

        ; Many operation mnemonics have an optional `P` version that also pops the stack.

    ; # floating point literals in .text

    ; # __float32__

        ; To create a constant you need to use the `__float32__` macro.
        ; TODO why? http://stackoverflow.com/questions/29925432/nasm-why-must-float32-1-5-be-used-for-floating-point-literals-instead-of-j

            mov eax, __float32__(1.5)

    ; # double precision

        ; TODO how to use double precision?

    ; Load on floating point stack

        ; # fldz

            ; Float LoaD Zero

            ; st0 = 0

                fldz
                mov dword [resd0], __float32__(0.0)
                fld dword [resd0]
                fcomip st1
                ASSERT_FLAG je
                finit

        ; # fld1

            ; Float Load 1

            ; st0 = 1

                fld1
                mov dword [resd0], __float32__(1.0)
                fld dword [resd0]
                fcomip st1
                ASSERT_FLAG je
                finit

        ; # fldl2e

            ; log_2(e)

        ; # fldl2t

            ; log_2(10)

        ; # fldlg2

            ; log_10(2)

        ; # fldln2

            ; ln(2)

        ; # fldpi

            ; Pi

        ; # fild

            ; Integer Load.

                fldz
                mov dword [resd0], 0
                fld dword [resd0]
                fcomip st1
                ASSERT_FLAG je
                finit

    ; FPU Stack order operations

        ; # fxch

            ; Swap ST0 and another register.

                fldz
                fld1

                fxch st1
                fld dword [f0]
                fcomip st1
                ASSERT_FLAG je

                fxch st1
                fld dword [f1]
                fcomip
                ASSERT_FLAG je

                finit

        ; # ffree and Pop.

            ; Remove from stack.

                fldz
                fld1
                ffree st0
                fld dword [f0]
                fcomip st1
                ASSERT_FLAG je
                finit

                fldz
                fld1
                ffree st1
                fld dword [f1]
                fcomip st1
                ASSERT_FLAG je

    ; # fst

    ; # fstp

        ; Floating STore

        ; Floating STore and Pop.

        ; Move st0 to RAM.

            fldz
            fld dword [f0]
            fstp dword [resd0]
            mov eax, [f0]
            ASSERT_EQ [resd0]

    ; # fcomip

        ; pentium+

        ; Compare STX with ST0 and Pop ST0.

        ; Set integer compare flags.

            fld1
            fldz
            fcomip st1
            ASSERT_FLAG jb
            ; BAD: must use a b with fcomip
            ; TODO why?
            ;ASSERT_FLAG jl
            finit

            fldz
            fld1
            fcomip st1
            ASSERT_FLAG ja
            finit

        ; ERROR: can only compare two registers

            ;fcomip [f1]

    ; # Operations

        ; # fchs

            ; Change Sign.

            ; st0 *= -1

                fld dword [f1]
                fchs
                fld dword[fm1]
                fcomip st1
                ASSERT_FLAG je
                fchs
                fld dword [f1]
                ASSERT_FLAG je
                finit

        ; # fabs

            ; st0 = |st0|

                fld dword [fm1]
                fabs
                fld dword[f1]
                fcomip st1
                ASSERT_FLAG je
                fld dword[f1]
                fcomip st1
                ASSERT_FLAG je
                finit

        ; # fsqrt

                fld dword [f100]

                fsqrt
                fld dword [f10]
                fcomip st1
                ASSERT_FLAG je

                fsqrt
                mov dword [resd0], __float32__(1.41)
                fld dword [resd0]
                fcomip st1
                ASSERT_FLAG jbe

                mov dword [resd0], __float32__(1.42)
                fld dword [resd0]
                fcomip st1
                ASSERT_FLAG jae

        ; # fscale

                fld dword [f1]
                fld dword [f1]

                fscale
                fld dword [f10]
                fcomip st1
                ASSERT_FLAG je

                fscale
                fld dword [f100]
                fcomip st1
                ASSERT_FLAG je

        ;FSIN
        ;FCOS
        ;FSINCOS    ;calc both sin and cos
        ;FPATAN
        ;FPTAN

        ;FPREM      ;remainder
        ;FPREM1     ;remainder

        ;FRNDINT    ;rounds to integer depending on rounding mode
    EXIT
