; # enter

    ; `enter A, B` is basically equivalent to:

        ;push ebp
        ;mov ebp, esp
        ;sub esp, A

    ; Which implies an allocation of:

    ; - one dword to remember `ebp`
    ; - `A` dwords for local function variables,

    ; Enter is almost never used by GCC as it is slower than `push`:
    ; http://stackoverflow.com/questions/5959890/enter-vs-push-ebp-mov-ebp-esp-sub-esp-imm-and-leave-vs-mov-esp-ebp

    ; `leave` is used however

    ; B is very rarely not 0 in compiler output.
    ; http://stackoverflow.com/questions/26323215/do-any-languages-compilers-utilize-the-x86-enter-instruction-with-a-nonzero-ne

%include "lib/common_nasm.inc"

ENTRY
    ; TODO
EXIT
