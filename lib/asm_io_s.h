/*
GAS macros.

Use cpp because GAS macros are too limted.
*/

#define ENTRY \
    enter $0, $0 ;\
    .text ;\
        .global asm_main ;\
        asm_main:

#define EXIT \
    leave ;\
    mov $0, %eax ;\
    ret

#define PRINT_INT_HEX(x) \
    mov x, %eax ;\
    call print_int_hex

#define PRINT_INT(x) \
    mov x, %eax ;\
    call print_int

#define PRINT_STRING(x) \
    mov x, %eax ;\
    call print_string

/*
Usage:

    PRINT_STRING_LITERAL("My string literal!")

A trailing newline and zero terminator are automatically added.
*/
#define PRINT_STRING_LITERAL(x) \
    .section .rodata ;\
    1: ;\
         .asciz x ;\
    .text ;\
    PRINT_STRING($1b)

/*
Must be defined with `#define` because of __LINE__:
http://stackoverflow.com/questions/30958595/is-there-a-line-macro-for-gas-assembly-that-expands-to-the-current-source-li
*/
#define ASSERT_FAIL \
    mov $__LINE__, %eax ;\
    call assert_fail

#define ASSERT_FLAG(flag) \
    flag 1f ;\
    ASSERT_FAIL ;\
    1:

#define ASSERT_EQ(x) \
    ASSERT_EQ2(x, %eax)

/*
TODO factor out with ASSERT_EQ3.
Did not do it becase it would require an empty macro which is C99.
*/
#define ASSERT_EQ2(x, y) \
    cmp x, y ;\
    je  1f ;\
        ASSERT_FAIL ;\
    1:

#define ASSERT_EQ3(x, y, size) \
    cmp ## size x, y ;\
    je  1f ;\
        ASSERT_FAIL ;\
    1:
