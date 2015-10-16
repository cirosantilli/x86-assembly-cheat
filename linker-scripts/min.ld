/*
Minimal linker script possible.

Expected outcome: program exit status is 0.

Several defaults are used:

- entry on `.text` segment
- put every section that does not match any rule into the `.text` segment
*/
SECTIONS
{
    /* If we don't use this, it gets set to 0 and segfaults. */
    . = 0x400000;
}
