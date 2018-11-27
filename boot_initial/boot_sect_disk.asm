disk_load:
    pusha
    ; reading from disk involves usage of various registers
    ; so we will kinda persist them for later use
    push dx

    ; below is general routine for reading from disk
    mov ah, 0x02 ; ah - basically says int 0x13 to `read`
    mov al, dh   ; al - no. of sectors to read
    mov cl, 0x02 ; cl - sector number (0x01 being boot sector
                 ; and 0x02 being first available)
    ; dl is drive number (floppy/hdd) it is set by caller/BIOS
    mov ch, 0x00 ; cylinder number
    mov dh, 0x00 ; head number

    int 0x13
    jc disk_error ; if error occurred it is stored in the carry bit
                  ; jc checks if carry bit is set
    pop dx ; pops expected number of sectors to be read
    cmp al, dh ; compares it with actual number of sectors that have been read
    jne sectors_error
    popa
    ret

disk_error:
    mov bx, disk_error
    call print
    call print_nl
    mov dh, ah ; ah - error code, dl - disk drive that erred
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0 