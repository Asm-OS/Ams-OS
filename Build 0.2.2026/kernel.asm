; kernel.asm - Kernel mínimo Asm OS
; Será carregado em 0x8000 pelo bootloader
; Mostra "kernel" na tela sem limpar

org 0x8000
bits 16

inicio_kernel:
    ; Define segmento de dados
    mov ax, cs
    mov ds, ax
    mov es, ax
    
    ; Escreve "kernel" na tela
    mov si, mensagem_kernel    ; SI aponta para a mensagem
    
escrita_kernel:
    lodsb                      ; Carrega byte de DS:SI em AL
    test al, al                ; Verifica se é null terminator
    jz fim_kernel              ; Se for, pula para fim
    
    ; Escreve caractere usando BIOS
    mov ah, 0x0E               ; Função: escrever caractere
    mov bh, 0x00               ; Página 0
    mov bl, 0x07               ; Atributo (branco em preto)
    int 0x10                   ; Chamada BIOS
    
    jmp escrita_kernel         ; Próximo caractere
    
fim_kernel:
    jmp fim_kernel             ; Loop infinito

mensagem_kernel:
    db 13, 10                  ; Enter para ir pra próxima linha
    db "kernel", 0             ; Mensagem com null terminator