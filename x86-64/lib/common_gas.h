.extern \
    assert_fail, \
    print_long, \
    print_long_hex, \
    print_string, \
;

#define ENTRY \
    enter $0, $0 ;\
    .text ;\
        .global asm_main ;\
        asm_main: \
        sub $8, %rsp

#define EXIT \
    leave ;\
    mov $0, %eax ;\
    ret

#define ASSERT_FAIL \
    mov $__LINE__, %rdi ;\
    call assert_fail

#define ASSERT_EQ(x, y) \
    cmp x, y ;\
    je  1f ;\
        ASSERT_FAIL ;\
    1:
