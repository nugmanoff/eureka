;
; Boot sector that demonstrates the stack.
;

mov ah, 0x0e

mov bp, 0x8000 ; sets the base of the stack to 0x8000, a little above than where BIOS loads
mov sp, bp ; sets stack top to stack base

push 'A'
push 'B'
push 'C'

mov al, [0x7ffe] ; stack grows downwards from bp, so we fetch char at 0x8000 - 0x2 (which is first element)
int 0x10
mov al, [0x7ffc] ; here we print second element, which is 0x8000 - 0x4 (two 16-bit offset)
int 0x10 
mov al, [0x7ffa]
int 0x10

pop bx ; pop the value from the top of the stack to 'bx'
mov al, bl ; we use lower portion of 'bx' which is 'bl' (contains 8-bit char)
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55
