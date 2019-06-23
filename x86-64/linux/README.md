# Linux

1.  [C from assembly](c-from-assembly/)

## System calls

Linux 64-bit accepts both the old IA-32 `int 0x80` system calls and also the new `syscall` instruction, which should be used instead as it is faster. Support for the old calls likely exists so that you can run IA-32 elf files directly.

`syscall` system calls have different numbers than the old IA-32, so watch out.

Syscall parameters are passed as follows:

- `rax`: system call number
- `rdi`: parameter 1
- `rsi`: parameter 2
- `rdx`
- `r10`
- `r8`
- `r9`

The return value is stored in `rax`.
