[BITS 16]
org 0x8000

jmp start

NuanceKernel:
    pusha 
    mov ah, 0x0E

.NuanceLoop:
    lodsb
    test al, al
    jz .NuanceDone

    int 0x10
    jmp .NuanceLoop

.NuanceDone
    popa 
    ret

MessageOne db 'Kernel > Welcome! NuanceKernel Loaded! [SUCCESS]', 0
MessageTwo db 'Kernel > Kernel Version: 0.1, By LocalNet [INFO]', 0
MessageThree db 'Kernel > Initialize Console... [OK]', 0
MessageError db 'Kernel > Error "BBh", Console Stopped [ERROR]', 0

start:
    mov si, MessageOne 
    call NuanceKernel

    ; sleep one
    mov cx, 0x0007
    mov dx, 0xA120
    mov ah, 0x86
    int 0x15

    ; newline one
    mov ah, 0x0E
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10

    mov si, MessageTwo
    call NuanceKernel

    ; sleep one
    mov cx, 0x0007
    mov dx, 0xA120
    mov ah, 0x86
    int 0x15

    ; newline two
    mov ah, 0x0E
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10

    mov si, MessageThree
    call NuanceKernel

    ; sleep one
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

    mov si, MessageError
    call NuanceKernel

    jmp $










