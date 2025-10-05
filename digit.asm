.model small
.stack 100h

.data
dmsg db 'digit$'
ndmsg db 'not digit$'

.code
main PROC
  mov ax, @data
  mov ds, ax

  mov ah, 00h
  int 16h

  cmp al, '0'
  jb not_digit
  cmp al, '9'
  ja not_digit
  mov dx, offset dmsg
  jmp display

not_digit:
  mov dx, offset ndmsg

display:
  mov ah, 09h
  int 21h

  mov ah, 4ch
  int 21h

main ENDP
END main  