#if defined(__GNUC__)
#  define PRE_CDECL
#  define POST_CDECL __attribute__((cdecl))
#else
#  define PRE_CDECL __cdecl
#  define POST_CDECL
#endif

/** Fix the calling convention so that we can implement it in assembly. */
int PRE_CDECL asm_main(void) POST_CDECL;

int main(void) {
    return asm_main();
}
