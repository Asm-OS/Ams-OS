Asm OS - Sistema Operacional em Assembly 16 bits

Asm OS é um sistema operacional em desenvolvimento, construído 100% em Assembly x86 16 bits usando NASM e QEMU.

Build 0.1.2016

Bootloader (inicio.bin
- Carrega em 0x7C00 (padrão BIOS)
- Exibe "Asm OS" na tela (sem limpar a tela)
- 512 bytes exatos (MBR padrão)
- Assinatura 0xAA55

Como Compilar e Rodar
- Compilação via NASM
- Geração de imagem de disco (512 MB)
- Integração com QEMU
- Build com Ctrl+Shift+B (tasks.json)

Pré-requisitos (DEBIAN 13)

sudo apt install nasm qemu-system-x86 qemu-system-gui qemu-utils -y

Status:Em desenvolvimento
