[BITS 16]
org 0x8000

jmp start

NuanceConsole:
    pusha
    mov ah, 0x0E
    mov al, '>'
    int 0x10
    mov al, ' '
    int 0x10

.ConsoleLoop:
    xor ah, ah
    int 0x16

    cmp al, 0x0D
    je .ConsoleBack
    cmp al, 0x08
    je .NuanceBackSpace
    mov ah, 0x0E
    int 0x10
    jmp .ConsoleLoop

.NuanceBackSpace:
    mov ah, 0x0E
    mov al, 0x08
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 0x08
    int 0x10
    jmp .ConsoleLoop

.ConsoleBack:
    call NuanceNew
    mov ah, 0x0E
    mov al, '>'
    int 0x10
    mov al, ' '
    int 0x10
    jmp .ConsoleLoop

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

NuanceKernel:
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

MessageOne db 'Kernel > Welcome! NuanceKernel Loaded! [SUCCESS]', 0
MessageTwo db 'Kernel > Bootloader Successfully Unloaded [OK]', 0
MessageThree db 'Kernel > Kernel Version: 0.1, By LocalNet [INFO]', 0
MessageFour db 'Kernel > Initialize Kernel... [OK]', 0
MessageFive db 'Kernel > Initialize Driver... [OK]', 0

MessageHelp db 'Kernel > Reference: [INFO]', 0
MSGHelpOne db 'Kernel > Stop code 0xBB - Unknown Error [INFO]', 0
MSGHelpTwo db 'Kernel > Stop code 0x02 - Disk-Sector Failure [INFO]', 0
NuanceMessage db 'Kernel > LocalNet work to 0.3, Sorry [ERROR]', 0


start:
    mov si, MessageOne 
    call NuanceKernel
    call NuanceNew
    call NuanceSleep

    mov si, MessageTwo
    call NuanceKernel
    call NuanceNew
    call NuanceSleep

    mov si, MessageThree
    call NuanceKernel
    call NuanceNew
    call NuanceSleep

    mov si, MessageFour
    call NuanceKernel
    call NuanceNew
    call NuanceSleep

    mov si, MessageFive
    call NuanceKernel
    call NuanceNew
    call NuanceNew
    call NuanceSleep

    mov si, MessageHelp
    call NuanceKernel
    call NuanceNew
    call NuanceSleep

    mov si, MSGHelpOne
    call NuanceKernel
    call NuanceNew
    call NuanceSleep

    mov si, MSGHelpTwo
    call NuanceKernel
    call NuanceNew
    call NuanceSleep

    mov si, NuanceMessage
    call NuanceKernel

    call NuanceNew
    call NuanceNew    
    call NuanceConsole

    jmp $