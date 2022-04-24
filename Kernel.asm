BITS 16
 mov ax,cs
 mov ds,ax
 mov es,ax
 mov ax, 0x7000
 mov ss,ax
 mov sp,ss 

  mov al,03h
  mov ah,0
  int 10h

   mainloop:
    mov si, prompt
	call write

	mov di, buffer
	call get_string

	mov si, buffer
	cmp byte[si],0
	je mainloop

	 mov si, buffer
	 mov di, test_bruh
	 call strcmp
	 jc .test
	 jmp mainloop
	 .test:
	 mov si,test_ans 
	 call write 
	 
	 jmp mainloop


	mov si, buffer
	call write

	jmp mainloop



  ; change text and background color
  ;mov ah, 09h
  ;mov cx, 1000h
  ;mov al, 20h

  ;mov bl, 30h
  ;int 10h
  strcmp:
   .loop:
   mov al,[si]
   mov bl,[di]
   cmp al,bl
   jne .notequal

   cmp al ,0 
   je .done


   inc di
   inc si
   jmp .loop

   .notequal:
   clc 
   ret

   .done:
   stc
   ret


  mov si, msg
  call write
  jmp $

  get_string:
   xor cl,cl

   .loop:
    mov ah,0
	int 0x16

	cmp al, 0x08
	je .backspace 

	cmp al, 0x0D
	je .done

	cmp cl , 0x3F
	je .loop

	mov ah, 0x0E
	int 0x10


	stosb
	inc cl
	jmp .loop

	.backspace:
	cmp cl, 0
	je .loop


	dec di
	mov byte[di],0
	dec cl

	mov ah,0x0E
	mov al, 0x08
	int 10h

	mov al,''
	int 10h

	mov al, 0x08
	int 10h

	jmp .loop

  .done:
  mov al,0
  stosb
  mov ah,0x0E
  mov al,0x0D
  int 0x10
  mov al,0x0A
  int 0x10
  ret
  
  write:
  lodsb
  or al, al
  jz .done
 
  mov ah,0x0E
  int 0x10
  jmp write


 .done:
  ret


 buffer times 64 db 0
 prompt db '',0
 msg db 'Bye World',0
 test_bruh db 'test',0
 test_ans db 'test de comando',0