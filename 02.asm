INCLUDE Irvine32.inc
INCLUDE Macros.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	 out1		           BYTE    "�п�J�G���h����ax^2+bx+c���Y�ơG", 0
	 out2		           BYTE    "�п�Ja���G", 0
	 out3		           BYTE    "�п�Jb���G", 0
	 out4		           BYTE    "�п�Jc���G", 0

	 out5		           BYTE    "�����", 0
	 out6		           BYTE    "�⭫�ڬ��G", 0
     out7		           BYTE    "��۲���ڤ��O���G", 0

	 two                   Real4    2.0
	 four                  DD       4
	 whata                 Real4    ? 
	 whatb                 Real4    ?
	 whatc                 Real4    ?
	 bmulb                 Real4    ?
	 fac                   Real4    ?
	 whatD                 Real4    ?
	 zeroo                 Real4    0.0

	 negb                  Real4    ?
	 sqrtD                 Real4    ?
	 negbaddsqrtD          Real4    ?
	 negbsubsqrtD          Real4    ?
.code
main PROC
	call Clrscr ;�M���ù�
	;finit       ;��l��FPU
;----------------------------------------------------------------
	mov edx , OFFSET out1			
	call WriteString
	call Crlf
	
	mov edx , OFFSET out2			;�i����Xa
	call WriteString
	call Crlf

	call Readfloat
	fstp whata

	mov edx , OFFSET out3			;�i����Xb
	call WriteString
	call Crlf

	call Readfloat
	fstp whatb

	mov edx , OFFSET out4			;�i����Xc
	call WriteString
	call Crlf

	call Readfloat
	fstp whatc
;-----------------------------------------------------------------------------��J�����A��X�P�O��

    fld whatb                ;���Xb^2
	fmul whatb
	fstp bmulb
	
	fld whata                 ;���X4ac
	fmul whatc
	fild four
	fmul 
	fstp fac
	
	

	fld bmulb
	fsub fac
	fstp whatD                ;�s��P�O��
	

;-------------------------------------------------------------------------------�H�W�����X�P�O��
;-------------------------------------------------------------------------------�P�_�P�O���A�P�O��<0��������
	fld whatD
	fcomp zeroo
	fnstsw ax
	sahf
	jae equall
	
smalll:
       mov edx , OFFSET out5			;�i���P�O���p��0
	   call WriteString
	   call Crlf
       jmp  EXITTT
;----------------------------------------------------------------------------------�P�O��=0
equall:
	finit
	fld whatD
	fcomp zeroo
	fnstsw ax
	sahf
	ja  biggg

    mov edx , OFFSET out6			    ;�i���P�O������0
	call WriteString
	call Crlf
	fld whata
	fmul two                            ;2a
	fld whatb                           ;b/2a
	fdiv ST(0),ST(1)

	fchs                                ;�[�W�t��
	call WriteFloat
	call crlf

	jmp  EXITTT
;----------------------------------------------------------------------------------�P�O��>0
biggg:
    
    mov edx , OFFSET out7			    ;�i���P�O���j��0
	call WriteString
	call Crlf

	fld whatb
	fchs                                 ;-b
	fstp negb
	
	fld whatD
	fsqrt                                ;�ڸ�D
	fstp sqrtD

	fld negb
	fadd sqrtD
	fstp negbaddsqrtD                    ;-b+�ڸ�D

	fld negb
	fsub  sqrtD
	fstp negbsubsqrtD                    ;-b-�ڸ�D
	

	fld whata                           
	fmul two                              ;2a
	fld negbaddsqrtD                     ;-b+�ڸ�D/2a
	fdiv ST(0),ST(1)
	call WriteFloat
	call crlf	

	fld whata                           
	fmul two                             ;2a
	fld negbsubsqrtD                     ;-b-�ڸ�D/2a
	fdiv ST(0),ST(1)
	call WriteFloat
	call crlf
	

	jmp  EXITTT

EXITTT:
call WaitMsg
	INVOKE ExitProcess , 0
main ENDP
END main