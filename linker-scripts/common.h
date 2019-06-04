#define GLOBAL(symbol) \
    .global symbol;\
    symbol:

/* Create a non-zero terminated string and a symbol for it's length. */
#define STRING(symbol, value) \
    symbol: \
        .ascii value;\
        symbol ## _len = . - symbol

/* Exit syscall. */
#define LKMC_EPILOGUE(status) \
    mov $1, %eax;\
    mov status, %ebx;\
    int $0x80

/*
Write syscall.

The length of `string_address` should be stored in a symbol named
`string_address ## _len`.

- string_address: a symbol that points to the start of the string (without $)
*/
#define WRITE(string_address) \
    mov $4, %eax;\
    mov $1, %ebx;\
    mov $string_address, %ecx;\
    mov $string_address ## _len, %edx;\
    int $0x80
