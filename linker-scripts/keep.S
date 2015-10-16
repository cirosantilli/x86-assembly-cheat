.section .text
.global _start
_start:
    /* Dummy access so that after will be referenced and kept. */
    mov after, %eax
    /*mov keep, %eax*/
    /* Exit system call. */
    mov $1, %eax
    /* Take the exit status 4 bytes after before. */
    mov $4, %ebx
    mov before(%ebx), %ebx
    int $0x80
.section .before
    before: .long 0
.section .keep, "a"
    keep: .long 1
.section .after
    after: .long 2
