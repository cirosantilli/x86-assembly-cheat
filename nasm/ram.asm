; Examples of how to access RAM in NASM.

%include "lib/common_nasm.inc"

section .bss

    resd0 resd 1
    resd1 resd 1

ENTRY

    ; Square brackets `[]` are needed to access the *data*,
    ; otherwise the address of the label is understood:

    ; Data:

        mov dword [resd0], 1
        ASSERT_EQ [resd0], 1, dword

    ; Address:

        mov dword eax, resd1
        sub eax, resd0
        ASSERT_EQ eax, 4

    ; # Memory size

        ; TODO examples.

        ; When operations involve registers it is not necessary to specify
        ; the number of bytes to move around since that can be deduced from the
        ; register form: `eax` = 4 bytes, `ax` == 2 bytes, etc.

        ; But when moving or comparing literals to RAM
        ; it is mandatory to specify the number of bytes to move.

            ; Error: size not specified.
            ;mov [resd0], 1

        ; NASM knows it is 4 bytes because we are using eax:

            mov eax, 1
            mov [resd0], eax

        ; List of all size keywords:
        ; http://stackoverflow.com/questions/12063840/what-are-the-sizes-of-tword-oword-and-yword-operands

        ; # byte

            ; 1

        ; # word

            ; 2

        ; # dword

            ; 4

            ; Double word.

        ; # qword

            ; 8

            ; Quadruple word.

            ; Only possible in 64-bit.

        ; # tword

            ; 10

            ; Ten.

            ; Used for x87 floating point formats. TODO example

        ; # oword

            ; 16

            ; TODO example

        ; # yword

            ; 32

        ; # zword

            ; 64

EXIT
