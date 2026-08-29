; inicio.asm - Bootloader Asm OS
; Tamanho: 512 bytes (MBR)
; Não limpa a tela, apenas escreve "Asm OS"

org 0x7C00
bits 16

inicio:
    ; Define segmento de dados
    mov ax, cs
    mov ds, ax
    mov es, ax
    
    ; Escreve "Asm OS" na tela (sem limpar)
    mov si, mensagem    ; SI aponta para a mensagem
    
escrita:
    lodsb               ; Carrega byte de DS:SI em AL, incrementa SI
    test al, al         ; Verifica se é null terminator
    jz loop_final       ; Se for, pula para loop final
    
    ; Escreve caractere usando BIOS
    mov ah, 0x0E        ; Função: escrever caractere em modo teletype
    mov bh, 0x00        ; Página 0
    mov bl, 0x07        ; Atributo (branco em preto)
    int 0x10            ; Chamada BIOS
    
    jmp escrita         ; Próximo caractere
    
loop_final:
    jmp loop_final      ; Loop infinito (aguardando próximas instruções)

mensagem:
    db "Asm OS", 0      ; Mensagem com null terminator

; Preenchimento até 510 bytes (deixa 2 bytes pra assinatura)
times 510 - ($ - $$) db 0

; Assinatura do bootloader (obrigatória)
dw 0xAA55