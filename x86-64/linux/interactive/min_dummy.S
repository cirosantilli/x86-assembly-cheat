# Contains a dummy instruction to differentiate from `min_empty`.
.text
    .global _start
    _start: 
        movq $0,%rax
