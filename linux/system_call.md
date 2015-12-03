# System call

<http://stackoverflow.com/questions/12806584/what-is-better-int-0x80-or-syscall>

The following methods are possible, in order of decreasing preference:

- VDSO. Used by GCC by default.
- `sysenter`
- `int 0x80`
