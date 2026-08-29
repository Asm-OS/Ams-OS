; video.asm - Driver de Vídeo Asm OS
; Compilado como: video.dr
; Será carregado pelo kernel em memória
; Define resolução 320x200 pixels em modo gráfico

org 0xA000
bits 16

inicializar_video:
    ; Salva registradores
    push ax
    push bx
    push cx
    push dx
    
    ; Define modo gráfico 320x200 (modo 13h - VGA)
    mov ax, 0x0013      ; Modo 13h (320x200, 256 cores)
    int 0x10            ; Chamada BIOS
    
    ; Retorna registradores
    pop dx
    pop cx
    pop bx
    pop ax
    
    ; Retorna para kernel
    ret

; Função para limpar buffer de vídeo (quando necessário no futuro)
limpar_tela_video:
    push ax
    push cx
    push di
    
    mov ax, 0xA000     ; Segmento de vídeo
    mov es, ax
    xor di, di         ; DI = 0
    xor ax, ax         ; AX = 0 (cor preta)
    mov cx, 32000      ; 320x200 / 2 = 32000 palavras
    rep stosw          ; Preenche com zeros
    
    pop di
    pop cx
    pop ax
    ret

fim_video: