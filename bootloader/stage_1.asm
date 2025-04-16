; stage one steps
; > enable a20
; > load kernel into memory
; > setup gdt
; > load gdt with lgdt
; > enable protected mode (cr0)
; > far jump into 32-bit mode
; > set segment registers
; > setup stack
; > jump to kernel

; assembler hints
[bits 16]
org 0x7e00

stage_one:
    ; enable the a20 line
    ; > this allows for access to greater amounts of memory, this
    ; > method isnt fully universal but is enough for us to not care
    in al, 0x92                     ; load the value from the io port
    or al, 0x2                      ; ensure the a20 bit is enabled
    out 0x92, al                    ; store value back into io port

; file path relative to project root due to make running nasm there
%include "bootloader/utils.asm"

; padding to a nice round number
; > 4kb, most will be empty space for future proofing
times 4096 - ($ - $$) db 0