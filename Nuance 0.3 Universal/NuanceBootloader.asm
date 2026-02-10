[BITS 16]
org 0x7C00

jmp start

Nuance:
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

NuanceOne db 'Bootloader > Bootloader sector: 0x7C00 [OK]', 0
NuanceTwo db 'Bootloader > Load Kernel, Kernel Sector: 0x8000 [LOAD]', 0
NuanceThree db 'Bootloader > Load Shell, Shell Sector: 0x8400 [LOAD]', 0
NuanceFour db 'Bootloader > Load Drivers, Drivers Sector: 0x8800 [LOAD]', 0
NuanceFive db 'Bootloader > initialize... [LOAD]', 0
MessageError db 'Bootloader > Error 0x02, Disk Corrupted! [ERROR]', 0

NuanceNew:
    mov ah, 0x0E
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10
    ret

NuanceSleep:
    mov cx, 0x0001
    mov dx, 0x86A0
    mov ah, 0x86
    int 0x15
    ret

NuanceBoot:
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
    jc NuanceDisk

    jmp 0x0000:0x8000

NuanceDisk:
    mov si, MessageError

    call Nuance
    call NuanceNew

    jmp $

start:
    mov ax, 0x0003
    int 0x10

    mov si, NuanceOne
    call Nuance
    call NuanceSleep
    call NuanceNew

    mov si, NuanceTwo
    call Nuance
    call NuanceSleep
    call NuanceNew
    mov si, NuanceThree
    call Nuance
    call NuanceSleep
    call NuanceNew
    mov si, NuanceFour
    call Nuance
    call NuanceSleep
    call NuanceNew
    mov si, NuanceFive
    call Nuance
    call NuanceSleep
    call NuanceNew
    call NuanceNew

    call NuanceBoot
    jmp $

times 510-($-$$) db 0
dw 0xAA55