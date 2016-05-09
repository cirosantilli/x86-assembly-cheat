# Calling convention

In x86-64, the number of calling conventions was greatly reduced.

## System V AMD64 ABI

[System V AMD64 ABI][] dominating in Linux and other UNIX systems, and Mac OS X.

A simplified version of the most important points to keep in mind about the [System V AMD ABI](http://www.x86-64.org/documentation/abi.pdf), which both Mac and Linux use, are:

-   before call

    -   the stack pointer *must* be aligned by a multiple of 16 bytes after `call` pushes the return value to the stack.

        This often fails by default without explicitly changing `%rsp` because `call` will store the 8 byte return address on the stack, so you usually need to do:

            sub 8, rsp
            call f

        If this fails, segfault is common outcome.

        The most common action then is to just store `rsp` on the stack to even things out. That also allows for recursion.

        <http://stackoverflow.com/questions/8691792/how-to-write-assembly-language-hello-world-program-for-64-bit-mac-os-x-using-pri>

    -   parameter order is: %rdi, %rsi, %rdx, %rcx, %r8, %r9, then push the rest on the stack in reverse order

        Floating point arguments are passed through the %xmm0 to %xmm7 registers present in Intel's SSE2, which must be part of every x86-64 implementation.

        Linux system calls [use R10 is used instead of RCX](http://stackoverflow.com/questions/2535989/what-are-the-calling-conventions-for-unix-linux-system-calls-on-x86-64), Mac's [are unchanged](https://developer.apple.com/library/mac/documentation/DeveloperTools/Conceptual/LowLevelABI/140-x86-64_Function_Calling_Conventions/x86_64.html)

        Parameters only need to be pushed to the stack to allow for recursion or calling other functions, and this is done on the callee. So compilers can optimize and only use the registers if possible.

    -   variable argument functions like printf, `rax` must contain the number of vector (SSE / AVX) varargs: <http://stackoverflow.com/questions/6212665/why-is-eax-zeroed-before-a-call-to-printf>

        This includes for example `float` and `double` arguments, but not `int`.

        TODO why is this needed?

-   after return

    -   unchanged registers: RBX, RBP and R12-R15. Others may have changed.

    -   return value (may need multiple quadwords for structs):

        - integers go in: %rax and %rdx

        - %xmm0 and %xmm1 are used for floats up to 8-byte wide (`double`)

        - %st0 holds x87 80-bit floats (`long double)

        - %rdi holds the address of return values that went to memory

Other surprising ABI points:

- You can use up to 128 bytes below `RSP` without fear that it will be corrupted by signal or interrupt handlers: <http://stackoverflow.com/questions/13201644/why-does-the-x86-64-gcc-function-prologue-allocate-less-stack-than-the-local-var>. This is useful for leaf functions, which don't need to store arguments for further calls.

Good article: <http://nickdesaulniers.github.io/blog/2014/04/18/lets-write-some-x86-64/>

## Microsoft x64

Obviously they could not be compatible with the rest.

Microsoft x64 calling convention and its 2013 extension `__vectorcall` for Windows,
