.data
    hello_world_str:
        .asciz "hello world\n"
.text
    .global asm_main
    asm_main:
        mov $hello_world_str, %eax
        call print_string
        movl $0, %eax
		ret
