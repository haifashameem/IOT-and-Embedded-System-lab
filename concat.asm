.MODEL small
.STACK 100h

.data
m1 db 'enter first str$'
m2 db 0ah,0dh,'enter sec str$'
m3 db 0ah,0dh,'concat str $'
buffer1 db 50
        db ?
        db 50 dup('$')
buffer2 db 50
        db ?
        db 50 dup('$')

.code
main PROC
  mov ax, @data
  mov ds, ax

  ;print m1
  mov ah, 09h
  lea dx, m1
  int 21h

  lea dx, buffer1
  mov ah, 0ah
  int 21h

  mov ah, 09h
  lea dx, m2
  int 21h

  lea dx, buffer2
  mov ah, 0ah
  int 21h

  ;length of first index
  lea si, buffer1+2
  mov cl, [buffer1+1]
  add si, cx

  lea di, buffer2+2
  mov cl, [buffer2+1]

next:
  mov al, [di]
  mov [si], al
  inc si
  inc di
  dec cl
  jnz next

  lea dx, m3
  mov ah, 09h
  int 21h

  lea dx, buffer1+2
  mov ah, 09h
  int 21h

  mov ah, 4ch
  int 21h
main ENDP
END main



