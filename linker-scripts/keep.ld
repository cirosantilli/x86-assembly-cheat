/*
http://stackoverflow.com/questions/9827157/what-does-keep-mean-in-a-linker-script
*/
LKMC_PROLOGUE(_start)
SECTIONS
{
    . = 0x400000;
    .text :
    {
        *(.text)
        *(.before)
        /*KEEP(*(.keep));*/
        *(.keep)
        *(.after)
    }
}
