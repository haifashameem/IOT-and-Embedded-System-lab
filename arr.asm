.model small
.stack 100h

.data
msg db 'enter array elements$'
n dw 5
array db 5 dup(?)
newline db 0ah, 0dh,'$'
sum dw 0

.code
main PROC
  mov ax, @data
  mov ds, ax

  lea dx, msg
  mov ah, 09h
  int 21h
  
 mov cx, n
 xor si,si

read:
  mov ah, 01h
  int 21h
  sub al, 30h
  mov array[si], al
  inc si
  loop read
  mov ah, 09h
  lea dx, newline
  int 21h
  xor si, si
  xor ax, ax
  mov cx, n
index_loop:
  xor bx, bx
  mov bl, array[si]
  add ax, bx
  inc si
  loop index_loop
  mov sum, ax
  mov ax, sum
  call disp 
  
  
  
  mov ah, 4ch
  int 21h

main ENDP

disp PROC
  mov bx, 10
  xor cx, cx

next_loop:
  xor dx, dx
  div bx
  push dx
  inc cx
  cmp ax, 0
  jne next_loop

print: 
  pop dx
  add dl, 30h
  mov ah, 02h
  int 21h
  loop print
  ret
disp ENDP
END main
