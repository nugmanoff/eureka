; using 32-bit pm
[bits 32]

; constants definition in pm
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f ; color charecteristics for each char

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx] ; [ebx] is the address of our char
    mov ah, WHITE_ON_BLACK

    cmp al, 0
    je print_string_pm_done

    mov [edx], ax
    add ebx, 1 ; move to next char
    add edx, 2 ; move to next video memory pos
               ; 2 - because one for char itself & one for its config

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret