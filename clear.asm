.model small
.stack 100h

.data
msg db "hello, suckerss",0

.code
main PROC
  mov ax, @data
  mov ds, ax

  ;vid mode, clear screen
  mov ah, 00h
  mov al, 03h
  int 10h

  ;move cursor to middle
  mov ah, 02h
  mov bh, 0
  mov dh, 12
  mov dl, 34
  int 10h

  mov si, offset msg
print_loop:
  mov al,[si]
  cmp al, 0
  je done
  mov ah, 0eh
  mov bh, 0
  mov bl, 07h
  int 10h
  inc si
  jmp print_loop

done:
  mov ah, 4ch
  int 21h

main ENDP
END main
