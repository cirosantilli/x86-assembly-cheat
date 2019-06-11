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
    mov $4, %eax
    mov $1, %ebx
    mov $%1, %ecx
    bswapl %ecx
    mov %ecx, resd0
    mov $resd0, %ecx
    mov $4, %edx
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

        mov $1, %eax
        mov $0, %ebx
        int $0x80
