org 0x7C00
bits 16


%define ENDL 0x0D, 0x0A


;
; FAT12 header
;
jmp short start
nop

bdb_oem:                       db 'MSWIN4.1' ; 8 bytes
bdb_bytes_per_sector:          dw 512        
bdb_sectors_per_cluster:       db 1          
bdb_reserved_sectors:          dw 1          
bdb_fat_count:                 db 2          
bdb_dir_entries_count:         dw 0E0h 
bdb_total_sectors:             dw 2880       ; 2880 * 512 = 1.44MB
bdb_media_descriptor_type:     db 0F0h       ; F0 = 3.5" floppy disk
bdb_sectors_per_fat:           dw 9          ; 9 sectors/FAT
bdb_sectors_per_track:         dw 18
bdb_heads:                     dw 2
bdb_hidden_sectors:            dd 0
bdb_large_sector_count:        dd 0

; extended boot record
ebr_drive_number:              db 0          ; 0 = floppy, 0x80 hdd
                               db 0          ; reserved
ebr_signature:                 db 29h        ; extended boot signature
ebr_volume_id:                 dd 12h, 34h, 56h, 78h ; volume id also i gave up making my comments aligned ;3
ebr_volume_label:              db 'XIRONIZZ OS' ; 11 bytes
ebr_system_id:                 db 'FAT12   ' ; 8 bytes

;
; Code here :3
;

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