.model small
.stack 100h

.data
m1 db 'enter first num $'
m2 db 0ah,0dh,'enter sec num $'
m3 db 0ah,0dh,'enter op(+,-,*,/) $'
m4 db 0ah,0dh,'result = $'
watbro db 0ah,0dh,'invalid input$'
res db ?
divz db 0ah,0dh,'error'

.code
main PROC
  mov ax, @data
  mov ds, ax

  ;print m1
  lea dx, m1
  mov ah, 09h
  int 21h

  ;read first num
  mov ah, 01h
  int 21h
  sub al, '0'
  mov bl, al

  ;print m2
  lea dx, m2
  mov ah, 09h
  int 21h

  ;read sec num
  mov ah, 01h
  int 21h
  sub al, '0'
  mov cl, al

  ;print m3
  lea dx, m3
  mov ah, 09h
  int 21h

  mov ah, 01h
  int 21h
  mov dl, al

  cmp dl, '+'
  je add_no
  cmp dl, '-'
  je sub_no
  cmp dl, '*'
  je mul_no
  cmp dl, '/'
  je div_no
  jmp wat_bro

add_no:
  mov al, bl
  add al, cl
  jmp print_res

sub_no:
  mov al, bl
  sub al, cl
  jmp print_res

mul_no:
  mov al, bl
  mul cl
  jmp print_res

div_no:
  cmp dl, 0
  je error_zero
  xor ah,ah
  mov al, bl
  div cl
  jmp print_res

error_zero:
  lea dx, divz
  mov ah, 09h
  int 21h
  jmp done

wat_bro:
  lea dx, watbro
  mov ah, 09h
  int 21h

print_res:
  lea dx, m4
  mov ah, 09h
  int 21h

  add al, '0'
  mov dl, al
  mov ah, 02h
  int 21h

done:
  mov ah, 4ch
  int 21h

main ENDP
END main
  

