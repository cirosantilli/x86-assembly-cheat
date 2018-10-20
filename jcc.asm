; # Jcc

; # Conditiona jump

    ; Family of conditional jumps.

    ; Conditional branches of the form `jX` and `jnX` exist for all flags X.

    ; `jX` jumps when the corresponding flag is set. `jnX` jumps when clear.

%include "lib/common_nasm.inc"

ENTRY
    ; # jz

    ; # jnz

    ; # je

    ; # jne

        ; je is the same as jz: http://stackoverflow.com/questions/14267081/difference-between-je-jne-and-jz-jnz

        ; jz is specially common with cmp, as `cmp` sets the `z` if the operands are equal.

        ; The C code:

            ;if (eax == ebx) assert_fail();

        ; Has equivalent:

            mov eax, 0
            mov ebx, 1
            cmp eax, ebx
            jnz jnz_test
            ASSERT_FAIL
            jnz_test:

    ; # jg

    ; # jl

        ; Large family of instructions that consider the ZF, CF, SF, OF and PF
        ; flags to do jumps.

        ; Those flags are set by `cmp`, so a `cmp; Jcc` is a common combo.

        ; Signed:

        ; - jg, jge, jl, jle
        ; - jng, jnge, jnl, jnle

        ; Unsigned verions:

        ; - ja, jae, jb, jbe
        ; - jna, jnae, jnb, jnbe

        ; mnemonics:

        ; - `g`: greater
        ; - `l`: less
        ; - `a`: above
        ; - `b`: below

        mov eax, 0
        cmp eax, 1
        ASSERT_FLAG jl
        ASSERT_FLAG jle

        mov eax, 1
        cmp eax, 0
        ASSERT_FLAG jg
        ASSERT_FLAG jge

        mov eax, 0
        cmp eax, 0
        ASSERT_FLAG jle
        ASSERT_FLAG jge

    ; # jc

        ; CF.

            stc
            ASSERT_FLAG jc
            clc
            ASSERT_FLAG jnc
EXIT
