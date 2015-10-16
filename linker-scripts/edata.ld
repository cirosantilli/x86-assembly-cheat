/*
To answer:
http://stackoverflow.com/questions/1765969/where-are-the-symbols-etext-edata-and-end-defined
*/
SECTIONS
{
    . = 0x400000;
    .text :
    {
        *(.text)
        sdata = .;
        *(.data)
    }
}
