; Structure macros

    %macro TEXT 0
        section .text
    %endmacro

    %macro DATA 0
        section .data
    %endmacro

    %macro RODATA 0
        section .rodata
    %endmacro

    %macro GLOBAL 1
        global %1
        %1:
    %endmacro

    ; Enter program that uses the C driver.
    ; The entry function is `asm_main`.
    %macro ENTRY 0
        TEXT
        GLOBAL asm_main
            enter 0, 0
    %endmacro

    ; Exit program entered by `ENTRY`.
    %macro EXIT 0
        leave
        mov eax, 0
        ret
    %endmacro

; Print macros.

    %macro PRINT_INT 1
        mov eax, %1
        call print_int
    %endmacro

    %macro PRINT_STRING 1
        mov eax, %1
        call print_string
    %endmacro

    %macro PRINT_STRING_LITERAL 1
        RODATA
        %%str db %1, 0
        TEXT
        PRINT_STRING %%str
    %endmacro

    %macro dump_regs 1
        push dword %1
        call sub_dump_regs
    %endmacro

    ; Usage: dump_mem label, start-address,
    %macro dump_mem 3
        push dword %1
        push dword %2
        push dword %3
        call sub_dump_mem
    %endmacro

    %macro dump_math 1
        push dword %1
        call sub_dump_math
    %endmacro

    %macro  dump_stack 3
        push dword %3
        push dword %2
        push dword %1
        call sub_dump_stack
    %endmacro

; Assert macros

    ; Assert eax eq %1
    %macro ASSERT_EQ 3
        pushf
        cmp %3 %1, %2
        je %%ok
            ASSERT_FAIL
        %%ok:
        popf
    %endmacro

    %macro ASSERT_EQ 2
        ASSERT_EQ %1, %2, %3
    %endmacro

    %macro ASSERT_EQ 1
        ASSERT_EQ eax, %1
    %endmacro

    %macro ASSERT_EQ 0
        ASSERT_EQ eax, ebx
    %endmacro

    ; asserts eax neq %1
    %macro ASSERT_NEQ 2
        pushfd
        pusha
        cmp %1, %2
        jne %%ok
            ASSERT_FAIL
        %%ok:
        popa
        popfd
    %endmacro

    ; assert jX or jnX jumps
    %macro ASSERT_FLAG 1
        %1 %%ok
            ASSERT_FAIL
        %%ok:
    %endmacro

    %macro ASSERT_FAIL 0
        mov eax, __LINE__
        call assert_fail
    %endmacro

    %macro ASSERT_EQ4 5
        ASSERT_EQ [%1], %2, dword
        ASSERT_EQ [%1 + 4], %3, dword
        ASSERT_EQ [%1 + 8], %4, dword
        ASSERT_EQ [%1 + 12], %5, dword
    %endmacro

; SIMD macros

    ; Move 4 given dwords into the given memory location.
    ; The memory location should normally be 8 dwords long.
    %macro MOV4 5
        mov dword [%1], %2
        mov dword [%1 + 4], %3
        mov dword [%1 + 8], %4
        mov dword [%1 + 12], %5
    %endmacro
