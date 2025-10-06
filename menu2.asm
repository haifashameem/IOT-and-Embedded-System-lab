.model small
.stack 100h

.data
m1 db "enter first num$"
m2 db 0ah, 0dh,"enter sec num$"
m3 db 0ah, 0dh,"enter op$"
m4 db 0ah, 0dh,"result $"
m5 db 0ah, 0dh, "zero error$"

num1 dw ?
num2 dw ?
result dw ?
buffer db 5 dup(?)

.code
main PROC
    mov ax, @data
    mov ds, ax
;print m1
    lea dx, m1
    mov ah, 09h
    int 21h
;read ones
    mov ah, 01h
    int 21h
    sub al, '0'
    mov bl, al
    
;read tens
    mov ah, 01h
    int 21h
    sub al, '0'
    mov bh, al
    
;normalise
    mov cl, 10
    mov al, bh
    mul cl
    add al, bl
    mov bx, ax
    mov num1, bx
;second input
    lea dx, m2
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov cl, al
    

    mov ah, 01h
    int 21h
    sub al, '0'
    mov ch, al 

    mov dl, 10
    mov al, ch
    mul dl
    add al, cl
    mov cx, ax
    mov num2, cx
    ;op
    lea dx, m3
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
    mov dl, al

    cmp dl, '+'
    je add_opp
    cmp dl, '-'
    je sub_opp
    cmp dl, '*'
    je mul_opp
    cmp dl, '/'
    je div_opp

add_opp:
    mov ax, num1
    add ax, num2
    mov result, ax
    jmp print_result
sub_opp:
    mov ax, num1
    sub ax, num2
    mov result, ax
    jmp print_result
mul_opp:
    mov ax, num1
    mul num2
    mov result, ax
    jmp print_result
div_opp:
    mov dx, num2
    cmp dx, 0
    je zer_error
    xor dx, dx
    xor ax, ax
    mov ax, num1
    div num2
    mov result, ax
    jmp print_result
zer_error:
    lea dx, m5
    mov ah, 09h
    int 21h
    jmp done
    
print_result:
    mov ah, 09h
    mov dx, offset m4
    int 21h
    mov ax, result
    call display
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
    
    