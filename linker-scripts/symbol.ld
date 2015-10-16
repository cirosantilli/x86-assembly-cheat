/*
Define symbols and give them values on the linker script.

Expected output: `hello world\n`

Used on many default linker scripts to say where sections start and end:
http://stackoverflow.com/questions/1765969/where-are-the-symbols-etext-edata-and-end-defined
*/
SECTIONS
{
    . = 0x400000;
    .text :
    {
        *(*)

        /*
        This defines the POSITION of s RELATIVE TO THE CURRENT SECTION,
        *not* it's value.

        This works because the value of the `.` (location counter)
        is also relative to the current segment:
        https://sourceware.org/binutils/docs/ld/Location-Counter.html
        */
        s = .;

        /*
        Immediately after comes the value.

        Obtained from: printf 'hello world' | rev | hd
         */
        QUAD(0x6f77206f6c6c6568)
        LONG(0x0a646c72)

        /*
        The name `len` cannot be used, because it is a keyword!
        https://sourceware.org/binutils/docs/ld/MEMORY.html
        TODO possible to escape it?
         */
        s_len = .;
        LONG(. - s)
    }
}
