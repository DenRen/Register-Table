end_schr equ '$'

;___________________________ 
;    This macro find for the
; first occurrence of the
; string DS:[SI] in the 
; string ES:[DI].
; SI - "__________________"
; DI - "___"
;--------------------�����Ŀ
; AL, CX, ES, DI     �Input�
;		     �������
;------------------�������Ŀ
; CX => 0, DI  	   �Destroy�
; 	  	   ���������
;___________________________
strstr macro
	mov al, end_schr
	mov dx, di

	memstrlen
	mov bx, di		; bx - length of DI
	inc bx	
	cld
L_ss:	mov cx, bx
	mov di, dx

	repe cmpsb
	dec di
	scasb 
	
	jne L_ss
	
	sub si, bx
	endm
;___________________________ 
; 
;--------------------�����Ŀ
; AL, CX, ES, DI     �Input�
;		     �������
;------------------�������Ŀ
; CX => 0, DI  	   �Destroy�
; 	  	   ���������
;___________________________
strcpy macro
	mov al, end_schr
L_scpy: cmp byte ptr ds:[si], al
	movsb
	jne L_scpy
	endm

;___________________________ 
;   This macro searches for
; the position of the AH
; characterint from the end 
; DS:SIof the line line. The 
; position is counted from 
; zero. The result is 
; recorded in BX.
;--------------------�����Ŀ
; AL, CX, ES, DI     �Input�
;		     �������
;------------------�������Ŀ
; CX => 0, DI  	   �Destroy�
; 	  	   ���������
;___________________________
strrchr macro
	cld
	mov al, end_schr
	xor cx, cx
	dec cx
	repne scasb
	dec di		; DI - end string
	
	xor bx, bx
	dec bx
	sub bx, cx
	mov cx, bx
	
	mov al, ah
	std
	repne scasb
	inc di
	mov bx, di	; Result  	
	
	endm
;___________________________ 
;   This macro searches for
; the position of the AH
; characterint the DS:SI
; line. The position is
; counted from zero. The
; result is recorded in BX.
;--------------------�����Ŀ
; AH, DS, SI	     �Input�
;		     �������
;------------------�������Ŀ
; AL CX DI BX DX   �Destroy�
; 	  	   ���������
;___________________________

strchr macro
	xor cx, cx
	dec cx
	xor bx, bx
	mov bl, end_schr
	mov dx, di
	cld
L_schr:
	lodsb
	cmp al, ah
	je short fin_schr 
	cmp al, bl
	LOOPNE L_schr
fin_schr:
	xor bx, bx
	dec bx
	sub bx, cx	
	add bx, dx; Result	
	endm
;___________________________ 
; DANGEROUS!
; Result DI
;--------------------�����Ŀ
; ES:DI		     �Input�
;		     �������
;------------------�������Ŀ
; AX, CX, DI  	   �Destroy�
; 	  	   ���������
;___________________________
memstrlen macro
	cld
	mov al, end_schr
	xor cx, cx
	dec cx
	repnz scasb
	xor di, di
	sub di, cx
	dec di
	dec di
	endm
;___________________________ 
;  This macro compares th
; DS:SI string with the
; ES:DI string. 
;  The result if flagged.
;--------------------�����Ŀ
; CX - quantity symb.�Input�
; DS:SI - 1st	     �������
; ES:DI - 2nd
; Result: ZF
;------------------�������Ŀ
; CX, DI 	   �Destroy�
; 	  	   ���������
;___________________________
memcmp macro
	cld
	repz cmpsb
	endm
;___________________________ 
;  This macro searches for
; the number of the first
; occurrence of the symbol
; AL at the addres ES:DI
; The length of the incoming
; array is in BX.
;  The final address is 
; recorded in the BX,
; relative to the 
; starting ES:DI
;----------------------�����Ŀ
; AL - serched symb.   �Input�
; CX - length array    �������
; ES:DI - pointer to a string
;--------------------�������Ŀ
; CX, BX, DI  	     �Destroy�
; 	  	     ���������
;___________________________
memchr macro
	cld
	repne scasb
	sub bx, cx
	dec bx
	endm
;___________________________ 
; 
;--------------------�����Ŀ
; DS, DI, ES, SI     �Input�
;		     �������
;------------------�������Ŀ
; CX => 0, DI  	   �Destroy�
; 	  	   ���������
;___________________________
memcpy macro
	cld
	rep movsb
	endm


;___________________________ 
; 
;--------------------�����Ŀ
; AL, CX, ES, DI     �Input�
;		     �������
;------------------�������Ŀ
; CX => 0, DI  	   �Destroy�
; 	  	   ���������
;___________________________

memset macro
	cld
	rep stosb
	endm


