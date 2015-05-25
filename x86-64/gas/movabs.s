.extern print_long

.text

    .global asm_main
    asm_main:

        movabs $0x1000000000000000, %rax
        call print_long

        movabs $0x1000000000000000, %rbx
        mov %rbx, %rax
        call print_long

        mov $0, %rax
		ret
