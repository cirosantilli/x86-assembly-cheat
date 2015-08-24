; # push

; # pop

    ; Decrement / increment `esp` by 4

    ; The stack grows down, so `push` decrements, and `pop` increments.

    ; The reason why the stack grows down is exactly because
    ; IA-32 implements those instructions and otherstack instructions like that.

    ; Always move by dwords no matter (4 bytes) the suffix.

%include "lib/asm_io.inc"

ENTRY

    mov eax, esp
    push dword 1
    sub eax, esp
    ASSERT_EQ 4
    mov eax, [esp]
    ASSERT_EQ 1

    mov eax, esp
    push byte 2
    sub eax, esp
    ASSERT_EQ 4
    mov eax, [esp]
    ASSERT_EQ 2

    pop eax
    ASSERT_EQ 2

    pop eax
    ASSERT_EQ 1

    ; Manual equivalent.

    sub esp, 8
    mov dword [esp], 2
    mov dword [esp + 4], 1

    mov eax, [esp]
    ASSERT_EQ 2
    mov eax, [esp + 4]
    ASSERT_EQ 1
    add esp, 8

    EXIT
