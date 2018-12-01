[bits 16]
switch_to_pm:
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:init_pm

[bits 32]
init_pm:
    mov ax, DATA_SEG
    mob ds, ax
    mob ss, ax
    mob es, ax
    mob fs, ax
    mob gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    call BEGIN_PM
