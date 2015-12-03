# stdcall

A C calling convention, less used than cdecl.

Used on the Win32 API.

Advantages:

- generates slightly smaller code
- potentially faster.

Disadvantages:

- it is not possible to pass variable number of arguments.
