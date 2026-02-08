[BITS 16]
org 0x7C00

jmp start

NuanceBoot:
    pusha
    mov ah, 0x0E

.NuanceLoop:
    lodsb
    test al, al
    jz .NuanceDone

    int 0x10
    jmp .NuanceLoop

.NuanceDone:
    popa 
    ret

MessageOne db 'Bootloader > Initialize... [OK]', 0
MessageTwo db 'Bootloader > Loaded Kernel... [LOAD]', 0
MessageThree db 'Bootloader > Loaded Console... [LOAD]', 0
MessageError db 'Bootloader > Error, Disk Corrupted! [ERROR]', 0

start:
    mov ax, 0x0003
    int 0x10

    mov si, MessageOne
    call NuanceBoot

    ; newline
    mov ah, 0x0E
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10

    ; sleep
    mov cx, 0x0007
    mov dx, 0xA120
    mov ah, 0x86
    int 0x15

    mov si, MessageTwo
    call NuanceBoot
    
    ; newline two
    mov ah, 0x0E
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10

    ; sleep two
    mov cx, 0x0007
    mov dx, 0xA120
    mov ah, 0x86
    int 0x15

    mov si, MessageThree
    call NuanceBoot

    ; sleep three
    mov cx, 0x0007
    mov dx, 0xA120
    mov ah, 0x86
    int 0x15


    ; newline three
    mov ah, 0x0E
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10

    ; newline four
    mov ah, 0x0E
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10

    mov ax, 0x0000
    mov es, ax
    mov bx, 0x8000

    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0x80

    int 0x13

    jc DiskCorrupt

    jmp 0x0000:0x8000

DiskCorrupt:
    mov si, MessageError
    call NuanceBoot
    jmp $

times 510-($-$$) db 0
dw 0xAA55










