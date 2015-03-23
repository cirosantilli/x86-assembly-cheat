# Assembly Cheat

Assembly information and cheatsheets.

Most important files:

-   [IA-32](ia32.md): IA-32 information
    - [ia32/main.asm](ia32/main.asm): main IA-32 and NASM syntax cheatsheet
    - [x86 paging tutorial](http://stackoverflow.com/questions/18431261/how-does-x86-paging-work)
-   [Instruction sets](instruction-sets.md)
-   [Assemblers](assemblers.md)
-   [Pros and cons](pros-and-cons.md)
-   [C calling conventions](c-calling-conventions.md)
    - [cdecl](cdecl.md)

Other files:

-   [GAS](ia32/gas/)
-   [CPU bugs](cpu-bugs.md)

## Scope

Topics not covered here:

-   OS specific such as Linux system calls.

	Search for those under their own plaftorm (e.g.: a Linux repo)

-   Compiler specific topics which cannot be done in a portable way, such as inline assembly (assembly in the middle of C code).

	Look for this info under extensions for each compiler.

This repository contains mostly x86 information now, but I'd love to try out other architectures.

## Sources

-   <http://www.tldp.org/HOWTO/Assembly-HOWTO/index.html>

-   <http://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture>

-   Programming from the ground up.

    <http://download.savannah.gnu.org/releases/pgubook/>

    Linux GAS, for complete programming beginners.

-   PC assembly language.

    <http://www.drpaulcarter.com/pcasm/>

    NASM.

-   <https://github.com/dennis714/RE-for-beginners>

    Reverse engineering for beginners.

    Lots of info on what C code maps to in assembly, and how to look for what matters to reverse engineer stuff.
