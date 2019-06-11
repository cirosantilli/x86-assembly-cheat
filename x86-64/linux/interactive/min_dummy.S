# Contains a dummy instruction to differentiate from `min_empty`.
.text
    .global _start
    _start: 
        mov $0, %rax
