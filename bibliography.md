# Bibliography

## Manuals

-   [IA-32 manual](http://www.intel.com/content/www/us/en/processors/architectures-software-developer-manuals.html)

    Intel man pages, *the* official source.

    Also includes Intel 64.

    Interesting sections:

    - Vol 1 5: instruction overview. In particular, groups instructions logically.
    - Vol 2 3: full instruction listing and API.

-   [AMD64 manuals](http://developer.amd.com/resources/documentation-articles/developer-guides-manuals/)

    Under the manuals section.

    Original specification of x86-64, which Intel then implemented as well.

-   [Intel 64 manual](http://www.intel.com/content/www/us/en/processors/architectures-software-developer-manuals.html)

    Intel man pages, *the* official source.

    Also includes IA-32.

    Get yourself the 3 volume IA documentation and the optimization manual and sleep with them.

    Interesting chapters:

    -   Volume 1 chapter 5: list of instructions grouped by type, good to find new instructions to play with

    -   Volume 2 chapter 3: full alphabetic list of all instructions

    The version is given on the front page, e.g.:

        Order Number: 325383-053US
        January 2015

    `325383` is the document (different for volumes 1-3), and 053 the version (TODO US is the language? Are there translations?)

-   [System V Application Binary Interface v0.99.7][]

-   <https://github.com/intelxed/xed/tree/master/datafiles> open source machine readable definition of instructions (non-PDF), only published in 2016

## Tutorials

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

-   <http://www.agner.org/optimize/>

    Highly regarded optimization guidelines for x86 and C++.

-   <http://courses.cs.washington.edu/courses/cse471/12sp/lectures.html>

    Washington university course that covers branch prediction, cache and other CPU internals

With runnable source code:

-   https://github.com/0xAX/asm not extensive, but clean, and highly commented.

Without runnable source code:

-   http://www.egr.unlv.edu/~ed/assembly64.pdf by Ed Jorgensen.

    A professional Creative Commons book that covers a lot of the basics.

## Unofficial API references

-   [Wikipedia Instruction List](http://en.wikipedia.org/wiki/X86_instruction_listings)

    Instruction list.

## Libraries

-   <https://github.com/aquynh/capstone>

    Looks like the best free disassembly library out there.

    Binutils cannot be used as a library to disassemble? Sad.

## Cool projects

Useless but cool and educational:

-   <https://github.com/flouthoc/calc.asm>

[Itanium C++ ABI]: http://mentorembedded.github.io/cxx-abi/abi.html
[System V ABI AMD64]: http://www.x86-64.org/documentation_folder/abi-0.99.pdf
