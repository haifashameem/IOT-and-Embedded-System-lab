.model small
.stack 100h

.data
m1 db "enter string"
newline db 0ah, 0dh,'$'
str db 50
    db ?
    db 50 dup('$')
n db ?

.code
main PROC
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    lea dx, m1
    int 21h
    mov ah, 0ah
    lea dx, str
    int 21h
    mov ah, 09h
    lea dx, newline
    int 21h

    lea si, str+2
    mov cl, 1
rev_str:
    mov al, [si]
    cmp al, 0dh
    je lastword
    mov al, [si]
    cmp al, ' '
    je rev_time
    inc si
    inc cl
    jmp rev_str
rev_time:
    mov di, si
    inc di
rev_loop:
    mov dl, [si]
    mov ah, 02h
    int 21h
    dec si
    loop rev_loop
update:
    mov si, di
    mov cl, 1
    jmp rev_str
lastword:
    mov dl, ' '
    mov ah, 02h
    int 21h
last_loop:
    dec si
    mov dl, [si]
    mov ah, 02h
    int 21h
    loop last_loop
done:
    mov ah, 4ch
    int 21h
main ENDP
END main

    

    





