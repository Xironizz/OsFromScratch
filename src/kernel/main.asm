org 0x7C00
bits 16


%define ENDL 0x0D, 0x0A
start:
    jmp main


;
; Prints a string to the screen :)
; Params:
;   - di:si pointer to the string to print
;
puts: 
    ; Registers to modify
    push si
    push ax

.loop:
    lodsb               ; load next character in al
    or al, al           ; check if we've reached the end of the string
    jz .done            ; if so, we're done

    mov ah, 0x0E       ; teletype output function
    mov bh, 0          ; page number (0)
    int 0x10           ; call BIOS video interrupt to print the character in al

    jmp .loop           ; otherwise, keep going

.done:
    pop ax
    pop si
    ret


main:

    ; setup data segments
    mov ax, 0           ; data segment is at 0
    mov ds, ax
    mov es, ax

    ; setup stack segment
    mov ss, ax
    mov sp, 0x7C00     ; stack grows down from where we are loaded in memory

    ; print the message
    mov si, msg_helloworld
    call puts


    hlt 

.halt:
    jmp.halt





msg_helloworld: db 'hello world!', ENDL, 0


times 510-($-$$) db 0
dw 0AA55h