Asm OS - Sistema Operacional em Assembly 16 bits

Asm OS é um sistema operacional em desenvolvimento, construído 100% em Assembly x86 16 bits usando NASM e QEMU.

Build 0.1.2016

- inicio.bin (boot)
- Carrega em 0x7C00 (padrão BIOS)
- Exibe "Asm OS" na tela (sem limpar a tela)
- 512 bytes exatos (MBR padrão)
- Assinatura 0xAA55

Build 0.2.2026

- Bootloader lê setores 1-5 do disco usando BIOS int 0x13
- Dados são carregados diretamente na memória
- Kernel carregado em memória no endereço 0x8000
- Kernel ocupa 5 setores (setores 1-5 do disco)
- Após carregar kernel, bootloader executa `jmp 0x0000:0x8000`
- Passa controle total para o kernel
- Mostra "Asm OS" (bootloader)
- Mostra "kernel" em linha nova (kernel em execução)
- Tela não é limpa em nenhum momento

Como Compilar e Rodar
- Compilação via NASM
- Geração de imagem de disco (512 MB)
- Integração com QEMU
- Build com Ctrl+Shift+B (tasks.json)

Pré-requisitos (DEBIAN 13)

sudo apt install nasm qemu-system-x86 qemu-system-gui qemu-utils -y

Status: Em desenvolvimento
