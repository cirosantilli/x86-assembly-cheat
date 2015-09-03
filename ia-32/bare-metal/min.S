/* Minimal example that does nothing, just halts. */
.code16
cli
hlt
.org 510
.word 0xaa55
