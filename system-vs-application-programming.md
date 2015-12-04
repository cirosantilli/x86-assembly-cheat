# System programming vs application programming

Most architectures provide two general sets of instructions:

-   system programming: instructions that only operating system writers will need.

    Application programs are generally forbidden from even using such instructions by security measures.

    This allows for example for process separation: preventing one process from seeing the other's memory, reducing the impact of bugs and malicious attacks.

-   application programming. Instructions that any program can use.

    Those will be usually packaged inside executable wrappers of some sort, e.g. ELF, which add required metadata to the instructions, e.g. where to find shared libraries.

This distinction is made so that application programs will run inside some sort of "protected mode", where the damage it can do to other applications and the OS is reduced.

It is common for manuals to separate those into separate chapters. E.g., Intel puts all system programming specifics on Volume 3.

This tutorial only covers application, programming. for system programming see: <https://github.com/cirosantilli/x86-bare-metal-examples>

System programming concepts not covered here include:

-   instructions:
    - `cli` and `sti`
    - `hlt`
    - `inb`
    - `outb`
-   special registers:
    - `ds`
    - `cs`
    - `ss`
-   paging
-   segmentation
-   rings

Those concepts cannot be tried out while an OS is running without disrupting the OS, so testing them requires substantially different techniques.
