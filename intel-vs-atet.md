# Intel vs AT&T syntax

There is no standard for x86 assembly syntax notation.

Two notations dominate: Intel and AT&T.

Neither is a proper standard, but rather "implementation defined".

## Intel

Used in Intel manuals, and likely Intel-made tools.

More popular on Windows.

Used by NASM and MASM.

This tutorial uses Intel syntax by default because that is what most tutorials I've used to learn also use. But I ended up regretting that, because I'm a Linux groupie.

### AT&T

More popular for Linux, since UNIX was created at Bell Labs.

Implemented by GAS, the GNU assembler.

Used by GCC by default, the Linux kernel, glibc...

Advantages:

-   registers are clearly marked with `%`. More verbose, but more precise: allows to differentiate label `ax` from register `ax`.

Downsides:

-   addressing is less self-documenting. Compare:

        [eax + 2*ebx + 4]

    with:

        4(eax,ebx,2)

-   Labels are not consistently marked with `$`: it depends on the instruction. E.g.:

        mov $label, %eax

    but:

        jmp label

    instead of the uniform:

        jmp $label

