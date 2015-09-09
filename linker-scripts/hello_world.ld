/* If start is not present, `.text` is used as the start. */
ENTRY(_start);

SECTIONS
{
    /*
    Linux segfaults us if the .text is too low.

    If this were not present, it would be 0, and that is too low and segfaults. See also:

    - http://stackoverflow.com/questions/2187484/why-is-the-elf-execution-entry-point-virtual-address-of-the-form-0x80xxxxx-and-n
    - http://stackoverflow.com/questions/2966426/why-do-virtual-memory-addresses-for-linux-binaries-start-at-0x8048000?lq=1
    */
    . = 0x400000;

    /* Text segment. */
    .text :
    {
        /* Crump every section from every file into it. */
        *(*)
    }
}
