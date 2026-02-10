[BITS 16]
org 0x8000

jmp start

NuanceKernel:
    pusha
    mov ah, 0x0E
    xor bh, bh

.NuanceLoop:
    lodsb     
    test al, al      
    jz .NuanceDone   
    int 0x10         
    jmp .NuanceLoop 

.NuanceDone:
    popa
    ret

NuanceOne db 'Kernel > Bootloader Unloaded [OK]', 0
NuanceTwo db 'Kernel > Success Load Kernel, Kernel Sector: 0x8000 [SUCCESS]', 0
NuanceThree db 'Kernel > Jumping to Shell, Shell Sector: 0x8400 [JUMP]', 0
NuanceFour db 'Kernel > Initialize Drivers, Drivers Sector: 0x8800 [INIT]', 0
NuanceFive db 'Kernel > initialize... [LOAD]', 0
Message0x02 db 'Kernel > Error 0xBB, Shell Corrupted! [ERROR]', 0

NuanceSleep:
    mov cx, 0x0001
    mov dx, 0x86A0
    mov ah, 0x86
    int 0x15
    ret

NuanceNew:
    mov ah, 0x0E
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10
    ret

NuanceShell:
    pusha
    mov ax, 0x0000
    mov es, ax
    mov bx, 0x8400

    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov cl, 3
    mov dh, 0
    mov dl, 0x80
    int 0x13
    jc .Nuance0x02

    popa
    mov ax, 0x0000
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x8000
    jmp 0x0000:0x8400

.Nuance0x02:
    mov si, Message0x02
    call NuanceKernel
    jmp $

start:
    mov si, NuanceOne
    call NuanceKernel
    call NuanceSleep
    call NuanceNew

    mov si, NuanceTwo
    call NuanceKernel
    call NuanceSleep
    call NuanceNew

    mov si, NuanceThree
    call NuanceKernel
    call NuanceSleep
    call NuanceNew

    mov si, NuanceFour
    call NuanceKernel
    call NuanceSleep
    call NuanceNew

    mov si, NuanceFive
    call NuanceKernel
    call NuanceNew
    call NuanceSleep
    call NuanceNew

    call NuanceShell
    
    jmp $

times 510-($-$$) db 0
dw 0xAA55