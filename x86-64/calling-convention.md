# Calling convention

In x86-64, the number of calling conventions was greatly reduced.

## System V AMD64 ABI

[System V AMD64 ABI][] dominating in Linux and other UNIX systems, and Mac OS X.

A simplified version of the most important points to keep in mind about the [System V AMD ABI](http://www.x86-64.org/documentation/abi.pdf), which both Mac and Linux use, are:

-   before call

    -   the stack pointer *must* be aligned by a multiple of 16 bytes.

        This often fails by default without explicitly changing `%rsp` because `call` will store the 8 byte return address on the stack, so you usually need to do:

            sub 8, rsp
            call f

        If this fails, segfault is common outcome.

        The most common action then is to just store `rsp` on the stack to even things out.

    -   parameter order is: %rdi, %rsi, %rdx, %rcx, %r8, %r9, then push the rest on the stack in reverse order

        Floating point arguments are passed through the %xmm0 to %xmm7 registers present in Intel's SSE2, which must be part of every x86-64 implementation.

        Linux system calls [use R10 is used instead of RCX](http://stackoverflow.com/questions/2535989/what-are-the-calling-conventions-for-unix-linux-system-calls-on-x86-64), Mac's [are unchanged](https://developer.apple.com/library/mac/documentation/DeveloperTools/Conceptual/LowLevelABI/140-x86-64_Function_Calling_Conventions/x86_64.html)

    -   variable argument functions like printf, `rax` must contain the number of varargs: <http://stackoverflow.com/questions/6212665/why-is-eax-zeroed-before-a-call-to-printf>

-   after return

    -   unchanged registers: RBX, RBP and R12-R15. Others may have changed.

    -   return value (may need multiple quadwords for structs):

        - integers go in: %rax and %rdx

        - %xmm0 and %xmm1 are used for floats up to 8-byte wide (`double`)

        - %st0 holds x87 80-bit floats (`long double)

        - %rdi holds the address of return values that went to memory

Good article: <http://nickdesaulniers.github.io/blog/2014/04/18/lets-write-some-x86-64/>

## Microsoft x64

Obviously they could not be compatible with the rest.

Microsoft x64 calling convention and its 2013 extension `__vectorcall` for Windows,
