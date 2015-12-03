# Stack instructions

x86 gives instructions which allow for manipulating memory as a stack.

This is useful allocate memory statically, in particular to allow function call recursion.

The idea that when you enter a function you store the top of the stack in `ebp` and do no change `ebp` inside the function, only when leaving it.

This way, the first variable will always be at ebp - 4,u even if you allocate more data on stack for local variables, moving `esp`

If this were not done, allocating data would move `esp`, and the position of arguments would depend on how much data was allocated, much more complicated to implement.

Then, when you leave the function, you restore `esp` and `ebp`, deallocating the local memory.
