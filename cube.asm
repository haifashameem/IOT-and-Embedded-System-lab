.model small
.stack 100h

.data
array db 20 dup('$')
buff dw 20 dup('$')
m1 db "enter number of elements$"
m2 db 0ah,0dh,"enter element$"
n db ?
buffer dw 5 dup(?)
newline db 0ah, 0dh,'$'

.code
main PROC
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    lea dx, m1
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov n, al
    mov cl, n
    xor si, si
insert:
    mov ah, 09h
    mov dx, offset m2
    int 21h
    mov ah, 01h
    int 21h
    sub al, '0'
    mov array[si], al
    inc si
    dec cl
    jnz insert
    
    xor si, si
    mov cl, n
    xor di, di
cube_loop:
    xor ax, ax
    mov al, array[si]
    mul al
    mov bl, array[si]
    mov bh, 0
    mul bx
    mov buff[di], ax
    inc si
    inc di
    inc di
    loop cube_loop
xor si,si
mov cl, n
print_loop:
    mov ah, 09h
    lea dx, newline
    int 21h

    mov ax, buff[si]
    call display
    
    inc si
    inc si
    loop print_loop
done:
    mov ah, 4ch
    int 21h
main ENDP
display PROC
    push ax
    push bx
    push cx
    push dx
    push si

    mov bx, 10
    mov cx, 0
    mov dx, 0
    lea si, buffer+4
save:
    div bx
    add dl, '0'
    mov [si], dl
    dec si
    inc cx
    mov dx, 0
    test ax, ax
    jnz save

    inc si
print:
    mov dl, [si]
    mov ah, 02h
    int 21h
    inc si
    dec cx
    jnz print

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
display ENDP
END main



    
    

