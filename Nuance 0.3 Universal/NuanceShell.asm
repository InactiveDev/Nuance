[BITS 16]
org 0x8400

; By LocalNet
; NuanceShell V0.1

jmp start

NuanceShell:
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

NuanceOne db 'Shell > Shell sector: 0x8400 [OK]', 0
NuanceTwo db 'Shell > Kernel Unloaded! [SUCCESS]', 0
NuanceThree db 'NuanceShell V0.1, By LocalNet', 0
ShellError db 'Error 0xBB, Unknown Shell Error! [ERROR]', 0

HelpOne db 'Shell > This Shell 0.1 to LocalNet Team [INFO]', 0
HelpTwo db 'Shell > Type your text, Soon Shell 0.2.. [INFO]', 0

MessageOne db 'Shell > Booting NuanceShell...', 0
MessageTwo db 'Shell > Welcome to NuanceShell!', 0
NuanceWelcome db '> ', 0 

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

ShellConsole:
    mov si, NuanceThree
    call NuanceShell
    call NuanceNew
    call NuanceNew
    
    mov si, NuanceWelcome
    call NuanceShell

.NuanceLoop:
    xor ah, ah
    int 0x16

    cmp al, 0x0D
    je .NuanceEnter
    cmp al, 0x08
    je .NuanceBack

    mov ah, 0x0E
    int 0x10
    jmp .NuanceLoop

.NuanceEnter:
    call NuanceNew
    mov si, NuanceWelcome
    call NuanceShell
    jmp .NuanceLoop

.NuanceBack:
    mov ah, 0x0E
    mov al, 0x08
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 0x08
    int 0x10
    jmp .NuanceLoop

start:
    mov si, MessageOne
    call NuanceShell
    call NuanceSleep
    call NuanceNew

    mov si, MessageTwo
    call NuanceShell
    call NuanceNew
    call NuanceSleep
    call NuanceNew
    
    call ShellConsole