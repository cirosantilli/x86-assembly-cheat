/*
Make a writable data segment.
*/
SECTIONS
{
    . = 0x400000;
    .text :
    {
        *(.text)
    }
    .data :
    {
        *(.data)
    }
}
