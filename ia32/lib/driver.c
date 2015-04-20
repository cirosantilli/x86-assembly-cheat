#if defined(__GNUC__)
#  define PRE_CDECL
#  ifdef __i386__
#    define POST_CDECL __attribute__((cdecl))
#  else
#    define POST_CDECL
#  endif
#else
#  define PRE_CDECL __cdecl
#  define POST_CDECL
#endif

/** Fix the calling convention so that we can implement it in assembly. */
int PRE_CDECL asm_main(void) POST_CDECL;

int main() {
  return asm_main();
}
