/*
Small very explicit example.

Expected output: `hello world\n`

We could make this much much smaller by using default names,
but this contains the minimum ammount of detail
that you should know about to get started.
*/

/*
If start is not present, a series of defaults are used:

- the value of a target specific symbol, if it is defined. For many targets this is start.
- the address of the first byte of the `.text' section, if present
- addres 0
 */
LKMC_PROLOGUE(_start);

/* Program headers, each of which specifies a segment. */
PHDRS
{
    /*
    If we don't set the flags here,
    the permissions are the minimum possible for the sections inside this segment..
     */
    mytext_segment PT_LOAD;
    mydata_segment PT_LOAD;
}

SECTIONS
{
    /*
    Set where the text segment will be loaded into memory by Linux.

    Linux segfaults us if the .text is too low.

    If this were not present, it would be 0, and that is too low and segfaults. See also:

    - http://stackoverflow.com/questions/2187484/why-is-the-elf-execution-entry-point-virtual-address-of-the-form-0x80xxxxx-and-n
    - http://stackoverflow.com/questions/2966426/why-do-virtual-memory-addresses-for-linux-binaries-start-at-0x8048000?lq=1
    */
    . = 0x400000;

    /* Create an output section. */
    .mytext_output_section :
    {
        /* Crump every `.mytext` section from every object file (`*`) into here. */
        *(.mytext)
    /* If we don't set a segment here, `.text` segment is the default. */
    } :mytext_segment

    . = 0x600000;
    .mydata_output_section :
    {
        *(.mydata)
    } :mydata_segment
}
