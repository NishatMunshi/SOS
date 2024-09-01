org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

section .text
main:
    ; setup data segments
    mov ax, 0           ; can't set ds/es directly
    mov ds, ax
    mov es, ax

    ; print hello world message
    mov si, msg_hello   ; move the pointer to si
    call puts           ; call puts to print the string

.halt:                  ; infinite loop to halt the cpu
    jmp .halt

;
; Prints a string to the screen
; Params:
;   - ds:si points to C string
;
puts:
.loop:
    lodsb               ; loads next character in al
    or al, al           ; verify if next character is null?
    jz .done            ; if it is then we're done

    mov ah, 0x0E        ; call bios interrupt
    mov bh, 0           ; set page number to 0
    int 0x10            ; software interrupt

    jmp .loop

.done:  
    ret

msg_hello: db 'Hello World!', ENDL, 0

times 510-($-$$) db 0   ; pad with zeros upto 510 bytes
dw 0AA55h               ; put the required bios signature