.model small
.stack 100h

.data
.code
main PROC
  mov ax, @data
  mov ds, ax

hours:
  mov ah, 2ch
  int 21h
  mov al, ch
  aam
  mov bx, ax
  call disp

  mov dl, ':'
  mov ah, 02h
  int 21h

minutes:
  mov ah, 2ch
  int 21h
  mov al, cl
  aam
  mov bx, ax
  call disp

  mov dl, ':'
  mov ah, 02h
  int 21h

seconds:
  mov ah, 2ch
  int 21h
  mov al, dh
  aam
  mov bx, ax
  call disp

  mov ah, 4ch
  int 21h
main ENDP

disp PROC
  mov dl, bh
  add dl, 30h
  mov ah, 02h
  int 21h
  mov dl, bl
  add dl, 30h
  mov ah, 02h
  int 21h
  ret
disp ENDP
END main