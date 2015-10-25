.extern print_long

.text

    .global asm_main
    asm_main:

        movabs $0x1000000000000000, %rdi
        call print_long

        movabs $0x1000000000000000, %rdi
        call print_long

        mov $0, %rax
        ret
