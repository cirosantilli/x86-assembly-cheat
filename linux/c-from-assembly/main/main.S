extern puts, exit
.data
    hello_world db "hello world", 0
.text
    .global main
    main: 
        push hello_world
        call puts
        popl %eax

        pushl $0
        call exit
