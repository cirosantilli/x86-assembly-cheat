SECTIONS
{
    . = 0x1000;
    bootsec :
    {
        *(.text)
        *(.data)
        *(.rodata)
        *(.bss)
    }
}
