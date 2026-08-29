; kernel.asm - Kernel Asm OS - Build 0.2.2026
; Carrega driver de vídeo e o executa
; Mostra "kernel" e "video.dr" na tela

org 0x8000
bits 16

inicio_kernel:
    ; Define segmento de dados
    mov ax, cs
    mov ds, ax
    mov es, ax
    
    ; Escreve "kernel" na tela
    mov si, mensagem_kernel
    
escrita_kernel:
    lodsb
    test al, al
    jz carregar_driver_video
    
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    
    jmp escrita_kernel

carregar_driver_video:
    ; Carrega driver de vídeo da memória (em 0xA000)
    ; O bootloader/kernel já colocou video.dr em 0xA000
    
    ; Chama função inicializar_video do driver
    call 0x0000:0xA000
    
    ; Driver retorna aqui após set de resolução
    
escrever_video_dr:
    ; Escreve "video.dr" na tela (terceira linha)
    mov si, mensagem_video_dr
    
escrita_video:
    lodsb
    test al, al
    jz fim_kernel
    
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    
    jmp escrita_video

fim_kernel:
    jmp fim_kernel

mensagem_kernel:
    db 13, 10
    db "kernel", 0

mensagem_video_dr:
    db 13, 10
    db "video.dr", 0