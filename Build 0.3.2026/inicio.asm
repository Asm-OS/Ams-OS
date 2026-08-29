; inicio.asm - Bootloader Asm OS - Build 0.2.2026
; Carrega kernel (setores 1-5) e drivers (setores 6-10)

org 0x7C00
bits 16

inicio:
    ; Define segmento de dados
    mov ax, cs
    mov ds, ax
    mov es, ax
    
    ; Escreve "Asm OS" na tela (sem limpar)
    mov si, mensagem
    
escrita:
    lodsb
    test al, al
    jz carregar_kernel
    
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    
    jmp escrita

carregar_kernel:
    ; Carrega kernel (setores 1-5) em 0x8000
    mov ax, 0x0000
    mov es, ax
    mov bx, 0x8000
    
    mov ah, 0x02
    mov al, 5           ; 5 setores (kernel)
    mov ch, 0
    mov cl, 2           ; Começa no setor 2 (setor 1)
    mov dh, 0
    mov dl, 0x00
    int 0x13
    
    jc carregar_kernel

carregar_drivers:
    ; Carrega drivers (setores 6-10) em 0xA000
    mov ax, 0x0000
    mov es, ax
    mov bx, 0xA000
    
    mov ah, 0x02
    mov al, 5           ; 5 setores (drivers)
    mov ch, 0
    mov cl, 7           ; Começa no setor 7 (setor 6)
    mov dh, 0
    mov dl, 0x00
    int 0x13
    
    jc carregar_drivers
    
    ; Passa controle para o kernel
    jmp 0x0000:0x8000

mensagem:
    db "Asm OS", 0

; Preenchimento até 510 bytes
times 510 - ($ - $$) db 0

; Assinatura do bootloader
dw 0xAA55