print:
    pusha

; `start` is the same as:
; while (string[i] != 0) { print string[i]; i++ }

; null byte serves as termination byte (end) of string

start:
    mov al, [bx] ; `bx` is the address for the argument (string)
    cmp al, 0
    je done

    ; usual printing routine
    mov ah, 0x0e
    int 0x10

    add bx, 1
    jmp start

done:
    popa
    ret

print_nl:
    pusha

    mov ah, 0x0e
    mov al, 0x0a ; newline char
    int 0x10
    mov al, 0x0d ; carriage
    int 0x10

    popa
    ret

