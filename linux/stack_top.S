# See what `esp` is worth at initialization.
#
# Pass the output of this through hd to see it.
#
# Expected outcome: two ints, 4 bytes apart, close to 4Gb.
#
# A little less than 4Gb and random because of ASLR.
#
# The kernel sets esp to it when the program is started:
# this is how it communicates it to the application.
#
# This is specified by the AMD64 ABI.

%macro print_address 1
    movl $4, %eax
    movl $1, %ebx
    movl $%1, %ecx
    bswapl %ecx
    movl %ecx, resd0
    movl $resd0, %ecx
    movl $4, %edx
    int $0x80
%endmacro

.bss

    resd0 resd 1

.text

    .global _start
    _start: 

        print_address esp
        pushl $1
        print_address esp

        print_address _start

        movl $1, %eax
        movl $0, %ebx
        int $0x80
