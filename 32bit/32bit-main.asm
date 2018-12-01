[org 0x7c00] ; usual bootloader offset
    mov bp, 0x9000 ; stack setup
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print ; will be printed right after BIOS messages

    call switch_to_pm
    jmp $ ; never gets called

%include "../boot_initial/boot_sect_print.asm"
%include "32bit-gdt.asm"
%include "32bit-print.asm"
%include "32bit-switch.asm"

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm ; will be printed at the top left corner with red :P
    jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

; magic numbers
times 510-($-$$) db 0
dw 0xaa55