; # cdecl

%include "lib/common_nasm.inc"

ENTRY

    ; Recursive factorial.

        push dword 5
        call factorial_rec_cdecl
        ; We must clean up the argument stack ourselves.
        ; This allows for varargs like `printf`.
        add esp, 4
        ASSERT_EQ eax, 120

        push dword 1
        call factorial_rec_cdecl
        add esp, 4
        ASSERT_EQ eax, 1

    ; Non-recursive factorial.

        push dword 5
        call factorial_norec_cdecl
        add esp, 4
        ASSERT_EQ eax, 120

        push dword 1
        call factorial_norec_cdecl
        add esp, 4
        ASSERT_EQ eax, 1

EXIT

; Recursive factorial. cdecl calling convention.
factorial_rec_cdecl:
    enter 0, 0
    ; -  `[ebp - 4]` the first local variable
    ; -  `[ebp]` is the address to return to pushed by `call`
    ; -  `[ebp + 4]` is the old `esp` pushed by `enter` before more local variables are pushed
    ; -  `[ebp + 8]` first argument passed. For this to be true for any number of arguments,
    ;    they must be pushed right-to-left.
    ; -  `[ebp + 12]` second argument passed
    cmp dword [ebp + 8], 1
    je factorial_rec_cdecl_base
        mov ebx, [ebp + 8]
        dec ebx
        push ebx
        call factorial_rec_cdecl
        add esp, 4
        mul dword [ebp + 8]
    jmp factorial_rec_cdecl_return
    factorial_rec_cdecl_base:
        mov eax, 1
    factorial_rec_cdecl_return:
    leave
    ret

; Non_recursive factorial. cdecl calling convention.
factorial_norec_cdecl:
    ; No need for `enter` since we are non-recursive.
    ; This does not affect in any way the ccecl calling convertion:
    ; enter and leave are invisible from the outside.
    mov ecx, [esp + 4]
    mov eax, 1
    factorial_norec_cdecl_loop:
        mul ecx
    loop factorial_norec_cdecl_loop
    ret
