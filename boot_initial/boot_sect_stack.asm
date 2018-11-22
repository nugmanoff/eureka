;
; Boot sector that demonstrates the stack.
;

mov ah, 0x0e

mov bp, 0x8000 ; sets the base of the stack to 0x8000, a little above than where BIOS loads
mov sp, bp ; sets stack top to stack base

push 'A'
push 'B'
push 'C'

pop bx ; pop the value from the top of the stack to 'bx'
mov al, bh ; we use lower portion of 'bx' which is 'bl' (contains 8-bit char)
int 0x10

pop bx
mov al, bl
int 0x10

mov al, [0x7ffe] ; directly accesses the element, which is 2 from top
int 0x10

pop bx
mov al, bl
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55
