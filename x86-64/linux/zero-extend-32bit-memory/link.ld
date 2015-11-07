SECTIONS
{
    . = 0x0000000000400000;
    .text :
    {
        *(.text)
    }
    .data :
    {
        *(.data)
    }
    . = 0xFFFFFFFF80000000;
    .data2 :
    {
        *(.data2)
    }
}
