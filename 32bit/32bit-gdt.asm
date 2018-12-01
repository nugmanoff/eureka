; GDT is basically like an abstraction over stuff
; that manages segment registers & offsets

gdt_start:
    ; it is prefixed with a null 8-byte
    ; each of the `dd - define double word` commands write single 4-byte
    ; so we execute it two times
    dd 0x0
    dd 0x0

; there are two separate GDTs
; one for code & one for data
; they have appropriate bases, lengths & flags
gdt_code:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10011010b ; these are tailed with `b` to show
    db 11001111b ; that they are binary literals
    db 0x0

gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

; GDT itself is defined using
; descriptor - called GDT descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start