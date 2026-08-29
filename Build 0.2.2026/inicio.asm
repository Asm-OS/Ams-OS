; inicio.asm - Bootloader Asm OS
; Tamanho: 512 bytes (MBR)
; Carrega o kernel do disco e passa controle

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
    jz carregar_kernel  ; Se for, pula para carregar kernel
    
    ; Escreve caractere usando BIOS
    mov ah, 0x0E        ; Função: escrever caractere em modo teletype
    mov bh, 0x00        ; Página 0
    mov bl, 0x07        ; Atributo (branco em preto)
    int 0x10            ; Chamada BIOS
    
    jmp escrita         ; Próximo caractere
    
carregar_kernel:
    ; Configura registradores para ler do disco
    mov ax, 0x0000      ; Segmento onde kernel será carregado (0x8000)
    mov es, ax
    mov bx, 0x8000      ; Offset = 0x8000
    
    ; Função int 0x13 - Ler do disco
    mov ah, 0x02        ; Função: ler setores
    mov al, 5           ; Número de setores a ler (1 a 5 = 5 setores)
    mov ch, 0           ; Cilindro 0
    mov cl, 2           ; Setor 2 (começa no setor 1, mas numeração começa em 1)
    mov dh, 0           ; Head 0
    mov dl, 0x00        ; Drive A: (floppy)
    int 0x13            ; Chamada BIOS
    
    ; Verifica se houve erro
    jc carregar_kernel  ; Se erro, tenta novamente
    
    ; Passa controle para o kernel
    jmp 0x0000:0x8000   ; Salta para 0x8000 onde kernel está

mensagem:
    db "Asm OS", 0      ; Mensagem com null terminator

; Preenchimento até 510 bytes (deixa 2 bytes pra assinatura)
times 510 - ($ - $$) db 0

; Assinatura do bootloader (obrigatória)
dw 0xAA55