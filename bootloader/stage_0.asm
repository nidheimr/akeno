; stage zero steps
; > store boot drive number
; > set segment registers
; > load second stage
; > jump to second stage

; assembler hints
[bits 16]
org 0x7c00

; TODO: error checking for sector loading

stage_zero:
    ; store boot drive number
    ; > this comes in handy later on so store it somewhere memorable
    ; > such as 0x7dfd which is directly before the boot signature
    ; > therefore it can also be accessed from stage two
    mov [0x7dfd], dl

    ; set segment registers
    ; > set all stack segments to 0 so that segmented addressing
    ; > works as expected
    xor ax, ax                      
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov sp, 0x7c00

    ; load second stage
    ; > the second stage is concatenated to the bootloader binary
    ; > therefore it is directly after stage zero
    mov ah, 0x2                     ; bios function for reading sectors
    mov al, 8                       ; read 8 sectors totalling to 4kb
    mov ch, 0                       ; on cylinder 0
    mov cl, 2                       ; starting from sector 2
    mov dh, 0                       ; on head 0
    mov dl, [0x7dfd]                ; on this drive
    mov bx, 0x7e00                  ; to this address
    int 0x13                        ; actually run the function

    ; if loading the second stage failed, error then halt
    mov si, read_failure_message
    jc error_then_halt

    ; jump to second stage
    jmp 0x0:0x7e00

read_failure_message:
    db "failed to load second boot stage from disk", 0

; file path relative to project root due to make running nasm there
%include "bootloader/utils.asm"

; padding and boot signature
times 510 - ($ - $$) db 0
dw 0x55aa