"""
## disas

Python implementation of the `disas` command.
"""

def disas():
    frame = gdb.selected_frame()
    block = frame.block()
    # TODO: make this work for files without debugging info.
    # block() is only available with debug information.
    # Find the current function if in an inner block.
    while block:
        if block.function:
            break
        block = block.superblock
    start = block.start
    end = block.end
    arch = frame.architecture()
    pc = gdb.selected_frame().pc()
    instructions = arch.disassemble(start, end - 1)
    for instruction in instructions:
        print('{:x} {}'.format(instruction['addr'], instruction['asm']))

gdb.execute('file hello_world2.out', to_string=True)
gdb.execute('break asm_main', to_string=True)
gdb.execute('run', to_string=True)
disas()
