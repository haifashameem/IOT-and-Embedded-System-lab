.MODEL small
.STACK 100h

.data
msg1 db 'hello$'
msg2 db 0dh,0ah,'world$'
.code
main PROC
  mov ax, @data
  mov ds,ax

  mov ah, 09h
  mov dx, OFFSET msg1
  int 21h

  mov ah, 09h
  mov dx, OFFSET msg2
  int 21h

  mov ah, 4ch
  mov al, 00
  int 21h 

main ENDP
END main

