# TODO get working
# http://stackoverflow.com/questions/19415184/load-from-a-64-bit-address-into-other-register-than-rax/19416331
# http://reverseengineering.stackexchange.com/questions/2627/what-is-the-meaning-of-movabs-in-gas-x86-att-syntax

.text

    .global asm_main
    asm_main:

        #movabs 0x8000000000000000, %rax

        # Error: operand size mismatch
        # Only possible for `rax`.
        #movabs 0x8000000000000000, %rbx

        mov $0, %rax
        ret
