section .multiboot   ;Sección especial que el linker coloca al inicio del kernel. GRUB escanea los primeros bytes buscando la firma mágica aquí.
    magic dd 0x1BADB002           ;El número mágico que GRUB busca para confirmar que esto es un kernel válido. Siempre es ese número, nunca cambia.
    flags dd 0x0                  ;Opciones extra para GRUB. En cero porque no necesitamos nada especial por ahora.
    checsum dd -(0x1BADB002 + 0x0);Verificación matemática. GRUB suma los tres valores y el resultado debe ser cero. Si no da cero, GRUB rechaza el kernel.

section .text           ;
    global kernel_entry ;
    extern kernel_main  ;

kernel_entry:
    call kernel_main
    .hang:
        jmp .hang