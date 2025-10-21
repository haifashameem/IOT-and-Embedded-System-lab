.model small
.stack 100h
.data
msg1 db "enter no. of numbers to find largest$"
msg2 db 0ah,0dh,"enter number$"
num dw ?
n db ?
temp dw ?
max dw ?
min dw ?
t1 dw ?
t2 dw ?
hcf dw ?
newline db 0ah,0dh,"$"
factarr dw 20 dup('$')
buffer dw 20 dup('$')
.code
main PROC
    mov ax, @data
    mov ds, ax
;read n
    lea dx, msg1
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
    sub al, '0'
    mov n, al

;read input
    xor cl,cl
    xor si, si
    mov cl, n
input_loop:
    lea dx, msg2
    mov ah, 09h
    int 21h
    xor bx, bx
    ;read tens
    mov ah, 01h
    int 21h
    sub al, '0'
    mov bh, al
    ;read ones
    mov ah, 01h
    int 21h
    sub al, '0'
    mov bl, al
    ;normalise
    xor dl, dl
    mov dl, 10
    mov al, bh
    mul dl
    add al, bl
    mov buffer[si], ax
    inc si
    inc si
    loop input_loop
    xor si, si
    mov cl, n
    mov ax, buffer[si]
    mov max, ax

check_large:
    mov ax, buffer[si]
    cmp ax, max
    ja replace
next:
    inc si
    inc si
    dec cl
    jne check_large
    jmp min_find
replace:
    mov max, ax
    jmp next

min_find:
    xor si, si
    mov cl, n
    mov ax, buffer[si]
    mov min, ax

check_min:
    mov ax, buffer[si]
    cmp ax, min
    jb replace2
next2:
    inc si
    inc si
    dec cl
    jne check_min
    jmp print_minmax
replace2:
    mov min, ax
    jmp next2   
print_minmax:
    lea dx, newline
    mov ah, 09h
    int 21h
    mov ax, max
    call display
    lea dx, newline
    mov ah, 09h
    int 21h
    mov ax, min
    call display

;-----
    mov temp, 1
    xor di, di
    xor cx,cx
factors:
    xor ax, ax
    xor dx, dx
    mov ax, min
    mov bx, temp
    div bx
    cmp dx, 0
    je addtoarr
    jmp update

addtoarr:
    mov num, di
    mov ax, temp
    mov factarr[di], ax
    inc di
    inc di
update:
    inc temp 
    mov ax, min
    cmp ax, temp
    jb find_hcf
    jmp factors
;-----
    xor si, si
    dec di
    dec di
    mov cl, n

find_hcf:
    mov ax, buffer[si]
    mov t1, ax
    mov ax, factarr[di]
    mov t2, ax
    xor ax, ax
    xor dx, dx
    mov ax, t1
    mov bx, t2
    div t2
    cmp dx, 0
    jne update_t2
    jmp next_step
update_t2:
    dec di
    dec di
    xor si, si
    mov cl, n
    jmp find_hcf
next_step:
    inc si
    inc si
    dec cl
    jz done
    jmp find_hcf
done:
    lea dx, newline
    mov ah, 09h
    int 21h
    mov ax, t2
    mov hcf, ax
    call display
    mov ah, 4ch
    int 21h
main ENDP
display PROC
    push cx
    xor cx, cx 
    mov bx, 10
read_loop:
    xor dx, dx
    div bx
    push dx
    inc cl
    cmp ax, 0
    jne read_loop
print_loop:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    dec cl
    jnz print_loop
    pop cx
    ret
display ENDP
END main

    
    
    
  
    
    

done:
    mov ah, 4ch
    int 21h
main ENDP
display PROC
    push cx
    xor cx, cx 
    mov bx, 10
read_loop:
    xor dx, dx
    div bx
    push dx
    inc cl
    cmp ax, 0
    jne read_loop
print_loop:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    dec cl
    jnz print_loop
    pop cx
    ret
display ENDP
END main
    
    
    


    


