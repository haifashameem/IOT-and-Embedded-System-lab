.MODEL small
.STACK 100h

.DATA
  msg db 'hello world$'
.CODE
main PROC
  mov ax,@data
  mov ds,ax

  mov ah,09h
  mov dx, OFFSET msg
  int 21h

  mov ah, 4Ch
  mov al,00
  int 21h

main ENDP
END main