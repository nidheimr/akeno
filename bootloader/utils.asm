[bits 16]

; basic function for printing an error then halting
; > si: holds the address of the null terminated string
error_then_halt:
    call print_string
    cli                             ; disable interrupts
    hlt                             ; halts the system
    jmp $                           ; unnecessary, but defensive

; basic function for printing text
; > si: holds the address of the null terminated string
print_string:
    push ax                         ; store ax as it is modified
    push si                         ; store si as it is incremented
print_loop:
    mov al, [si]                    ; al stores the character to print
    mov ah, 0x0e                    ; ah stores the bios function print
    int 0x10                        ; actually call the bios function
    inc si                          ; move onto the next letter in string
    cmp byte [si], 0                ; check if it is null
    jmp print_loop                  ; if not, keep printing by looping
print_done:
    pop si                          ; restore si
    pop ax                          ; restore ax
    ret                             ; return from func