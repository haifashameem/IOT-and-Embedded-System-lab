.MODEL small
.STACK 100h

.DATA
msg1 db 'enter str$'
msg2 db 0ah, 0dh, 'lenght:$'
BUFFER db 50
       db ?
       db 50 DUP(?)
LEN db ?

.CODE
main PROC
  mov ax, @data
  mov ds, ax

  ;print first msg
  lea dx, msg1
  mov ah, 09h
  int 21h

  ;read input
  mov ah, 0ah
  lea dx, BUFFER
  int 21h

  mov al, [BUFFER+1]
  mov LEN, al

  ;print sec msg
  lea dx, msg2
  mov ah, 09h
  int 21h

  ;print length
  mov al, LEN
  add al, 30h
  mov dl, al
  mov ah, 02h
  int 21h 

  mov ah, 4ch
  int 21h

main ENDP
END main