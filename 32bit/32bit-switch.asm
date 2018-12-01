[bits 16]
switch_to_pm:
    cli ; disables interrupts
    lgdt [gdt_descriptor] ; loads GDT descriptor
    mov eax, cr0 ; actual switch over, by setting the first bit
    or eax, 0x1  ; of special CPU register `cr0`
    mov cr0, eax
    jmp CODE_SEG:init_pm ; we perform `far` jump in order to
                         ; `flush` all of the operations being performed

[bits 32]
init_pm:
    mov ax, DATA_SEG ; update segment registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000 ; update stack 
    mov esp, ebp

    call BEGIN_PM
