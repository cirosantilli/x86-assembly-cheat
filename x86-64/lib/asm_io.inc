; TODO: factor out with IA-32.
; Basically replace eax with rax.

extern \
    assert_fail, \
    print_long, \
    print_long_hex, \
    print_string

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
        ; To align stack so that calls can be made directly.
        sub rsp, 8
    %endmacro

    ; Exit program entered by `ENTRY`.
    %macro EXIT 0
        add rsp, 8
        mov rax, 0
        ret
    %endmacro

; Assert macros

    ; Assert rax eq %1
    %macro ASSERT_EQ 3
        cmp %3 %1, %2
        je %%ok
            ASSERT_FAIL
        %%ok:
    %endmacro

    %macro ASSERT_EQ 2
        ASSERT_EQ %1, %2, %3
    %endmacro

    %macro ASSERT_EQ 1
        ASSERT_EQ rax, %1
    %endmacro

    %macro ASSERT_EQ 0
        ASSERT_EQ rax, rbx
    %endmacro

    ; asserts rax neq %1
    %macro ASSERT_NEQ 2
        cmp %1, %2
        jne %%ok
            ASSERT_FAIL
        %%ok:
    %endmacro

    ; assert jX or jnX jumps
    %macro ASSERT_FLAG 1
        %1 %%ok
            ASSERT_FAIL
        %%ok:
    %endmacro

    %macro ASSERT_FAIL 0
        mov rdi, __LINE__
        call assert_fail
    %endmacro
