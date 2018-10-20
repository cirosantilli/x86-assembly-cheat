; # push

; # pop

    ; For-newb explanation and rationale:
    ; http://stackoverflow.com/questions/4584089/what-is-the-function-of-push-pop-registers-in-x86-assembly/33583134#33583134

    ; # How many bytes are pushed

        ; Hard to determine. Read the manual.

        ; It is usually always 4 for 32-bits, and smaller operands are zero extended.

        ; It also depends on:

        ; - 0x66 prefix
        ; - flags of the code segment descriptor (not accessible from userland)

        ; `push byte` is only an error checked version of `push`:
        ; http://stackoverflow.com/questions/718105/how-to-translate-nasm-push-byte-to-gas-syntax/33614224#33614224
        ; But `push word` does add the 0x66 prefix.

        ; Impossible to push a single byte:
        ; http://stackoverflow.com/questions/2586591/why-is-it-not-possible-to-push-a-byte-onto-a-stack-on-pentium-ia-32

%include "lib/common_nasm.inc"

ENTRY

    mov eax, esp
    push dword 1
    sub eax, esp
    ASSERT_EQ eax, 4
    mov eax, [esp]
    ASSERT_EQ eax, 1

    mov eax, esp
    push byte 2
    sub eax, esp
    ASSERT_EQ eax, 4
    mov eax, [esp]
    ASSERT_EQ eax, 2

    pop eax
    ASSERT_EQ eax, 2

    pop eax
    ASSERT_EQ eax, 1

    ; Manual equivalent.

    sub esp, 8
    mov dword [esp], 2
    mov dword [esp + 4], 1

    mov eax, [esp]
    ASSERT_EQ eax, 2
    mov eax, [esp + 4]
    ASSERT_EQ eax, 1
    add esp, 8

EXIT
