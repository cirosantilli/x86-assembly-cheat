/*
How to alter segment flags (permissions).

Expected outcome: segfault, because the segment is not executable.
*/
LKMC_PROLOGUE(_start)
PHDRS
{
    /*
    The FLAGS number is the same as the 777 filesystem
    permission bits: RWX.

    Try changing this to 2 to get a segfaut.

    TODO why does it not segfault with just 4 (R)?
    */
    .mytext PT_LOAD FLAGS(5);
}
SECTIONS
{
    . = 0x400000;
    .mytext : {
        *(*)
    } :.mytext
}
