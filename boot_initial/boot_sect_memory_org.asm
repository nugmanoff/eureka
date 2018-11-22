[org 0x7c00]
mov ah, 0x0e

; attempt 1
; this one will fail because we are addressing the pointer,
; and not the contents of the address

mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; attempt 2
; this one is correct due to 'global' offset 'org' used
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; attempt 3
; we are adding 0x7c00 twice here, because we already have 'org' offset
; this one is not going to work
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; attempt 4
; this one works even with offset 'org' being set
; because it directly addresses memory by counting bytes
; so, this one is always going to work, but it's pretty clumsy
mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10

jmp $

the_secret:
	db "X"

times 510-($-$$) db 0
dw 0xaa55
