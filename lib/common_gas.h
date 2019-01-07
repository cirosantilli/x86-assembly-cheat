/* GAS macros.
 *
 * Use cpp because GAS macros are too limted.
 */

#define ENTRY \
    .text ;\
        .global asm_main ;\
        asm_main: \
        enter $0, $0

#define EXIT \
    leave ;\
    mov $0, %eax ;\
    ret

#define PRINT_INT(x) \
    mov x, %eax ;\
    call print_int

#define PRINT_STRING(x) \
    mov x, %eax ;\
    call print_string

/* Usage:
 *
 *     PRINT_STRING_LITERAL("My string literal!")
 *
 * A trailing newline and zero terminator are automatically added.
 */
#define PRINT_STRING_LITERAL(x) \
    .section .rodata ;\
    1: ;\
         .asciz x ;\
    .text ;\
    PRINT_STRING($1b)

/* Must be defined with `#define` because of __LINE__:
 * http://stackoverflow.com/questions/30958595/is-there-a-line-macro-for-gas-assembly-that-expands-to-the-current-source-li
 */
#define ASSERT_FAIL \
    mov $__LINE__, %eax ;\
    call assert_fail

#define ASSERT_FLAG(flag) \
        flag 1f ;\
        ASSERT_FAIL ;\
    1:

/* TODO define in terms of ASSERT_EQ_SIZE, need empty macro argument. */
#define ASSERT_EQ(x, y) \
    cmp x, y ;\
    je  1f ;\
        ASSERT_FAIL ;\
    1:

#define ASSERT_EQ_SIZE(x, y, size) \
    cmp ## size x, y ;\
    je  1f ;\
        ASSERT_FAIL ;\
    1:
