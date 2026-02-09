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

MessageOne db 'Bootloader > Initialize... [OK]', 0
MessageTwo db 'Bootloader > Loaded Kernel... [LOAD]', 0
MessageThree db 'Bootloader > Loaded Console... [LOAD]', 0
MessageFour db 'Bootloader > Unloaded Bootloader... [UNLOAD]', 0
MessageError db 'Bootloader > Error 0x02, Disk Corrupted! [ERROR]', 0

start:
    mov ax, 0x0003
    int 0x10

    mov si, MessageOne
    call NuanceBoot
    call NuanceNew
    call NuanceSleep

    mov si, MessageTwo
    call NuanceBoot
    call NuanceNew
    call NuanceSleep

    mov si, MessageThree
    call NuanceBoot
    call NuanceNew
    call NuanceSleep

    mov si, MessageFour
    call NuanceBoot
    call NuanceNew
    call NuanceSleep

    mov ax, 0x0000
    mov es, ax
    mov bx, 0x8000      

    mov ah, 0x02        
    mov al, 2          
    mov ch, 0           
    mov cl, 2           
    mov dh, 0           
    mov dl, 0x80        

    int 0x13
    jc DiskError       

    jmp 0x0000:0x8000

DiskError:
    mov si, MessageError
    call NuanceBoot
    jmp $               

times 510-($-$$) db 0
dw 0xAA55