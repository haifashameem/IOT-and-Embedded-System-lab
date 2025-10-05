.MODEL small
.STACK 100h

.DATA
n        DW 5                   ; size of array
array    DB 5 DUP(?)            ; array to store user input
msg1     DB 'Enter 5 digits (0-9): $'
newline  DB 0Dh,0Ah,'$'
sum      DW 0

.CODE
main PROC
    mov ax,@data
    mov ds,ax

;-------------------------
; Print message
;-------------------------
    mov ah,09h
    lea dx,msg1
    int 21h

;-------------------------
; User input into array
;-------------------------
    xor si,si
    mov cx,n
input_loop:
    mov ah,01h          ; DOS: read char
    int 21h
    sub al,30h          ; ASCII to number
    mov array[si],al
    inc si
    dec cl
    jnz input_loop
    mov ah,09h
    lea dx,newline
    int 21h
;-------------------------
; 1. Sum using Indirect addressing (SI)
;-------------------------
    xor ax,ax
    xor si,si
    mov cx,n

sum_indirect:
    mov bl,[si+array]  ; indirect addressing
    add ax,bx
    inc si
    loop sum_indirect

    mov sum,ax

; Print sum
    mov ax,sum
    call DISP

;-------------------------
; 2. Sum using Indexed addressing (array[SI])
;-------------------------
    xor ax,ax
    xor si,si
    mov cx,n

sum_indexed:
    mov bl,array[si]    ; indexed addressing
    add ax,bx
    inc si
    loop sum_indexed

    mov sum,ax
    mov ax,sum
    call DISP

;-------------------------
; 3. Sum using Based Indexed addressing (array[SI])
;-------------------------
    xor bx, bx
    lea bx, array
    xor si, si
    xor ax, ax
    mov cx, n
    mov sum, 0
sum_basedindexed:
    mov al, [bx+si]
    cbw
    add sum, ax
    inc si
    loop sum_basedindexed
    mov ax, sum
    call DISP

; Exit program
    mov ah,4Ch
    int 21h

main ENDP

;-------------------------
; DISP: print AX in decimal
;-------------------------
DISP PROC
    mov bx,10
    xor cx,cx

next_digit:
    xor dx,dx
    div bx
    push dx
    inc cx
    cmp ax,0
    jne next_digit

print_loop:
    pop dx
    add dl,30h
    mov ah,02h
    int 21h
    loop print_loop
    mov ah,09h
    lea dx,newline
    int 21h
    ret
DISP ENDP

END main
