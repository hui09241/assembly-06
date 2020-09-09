INCLUDE Irvine32.inc
INCLUDE Macros.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	 out1		           BYTE    "請輸入二次多項式ax^2+bx+c之係數：", 0
	 out2		           BYTE    "請輸入a為：", 0
	 out3		           BYTE    "請輸入b為：", 0
	 out4		           BYTE    "請輸入c為：", 0

	 out5		           BYTE    "有虛根", 0
	 out6		           BYTE    "兩重根為：", 0
     out7		           BYTE    "兩相異實根分別為：", 0

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
	call Clrscr ;清除螢幕
	;finit       ;初始化FPU
;----------------------------------------------------------------
	mov edx , OFFSET out1			
	call WriteString
	call Crlf
	
	mov edx , OFFSET out2			;告知輸出a
	call WriteString
	call Crlf

	call Readfloat
	fstp whata

	mov edx , OFFSET out3			;告知輸出b
	call WriteString
	call Crlf

	call Readfloat
	fstp whatb

	mov edx , OFFSET out4			;告知輸出c
	call WriteString
	call Crlf

	call Readfloat
	fstp whatc
;-----------------------------------------------------------------------------輸入結束，算出判別式

    fld whatb                ;做出b^2
	fmul whatb
	fstp bmulb
	
	fld whata                 ;做出4ac
	fmul whatc
	fild four
	fmul 
	fstp fac
	
	

	fld bmulb
	fsub fac
	fstp whatD                ;存放判別式
	

;-------------------------------------------------------------------------------以上為做出判別式
;-------------------------------------------------------------------------------判斷判別式，判別式<0直接結束
	fld whatD
	fcomp zeroo
	fnstsw ax
	sahf
	jae equall
	
smalll:
       mov edx , OFFSET out5			;告知判別式小於0
	   call WriteString
	   call Crlf
       jmp  EXITTT
;----------------------------------------------------------------------------------判別式=0
equall:
	finit
	fld whatD
	fcomp zeroo
	fnstsw ax
	sahf
	ja  biggg

    mov edx , OFFSET out6			    ;告之判別式等於0
	call WriteString
	call Crlf
	fld whata
	fmul two                            ;2a
	fld whatb                           ;b/2a
	fdiv ST(0),ST(1)

	fchs                                ;加上負號
	call WriteFloat
	call crlf

	jmp  EXITTT
;----------------------------------------------------------------------------------判別式>0
biggg:
    
    mov edx , OFFSET out7			    ;告之判別式大於0
	call WriteString
	call Crlf

	fld whatb
	fchs                                 ;-b
	fstp negb
	
	fld whatD
	fsqrt                                ;根號D
	fstp sqrtD

	fld negb
	fadd sqrtD
	fstp negbaddsqrtD                    ;-b+根號D

	fld negb
	fsub  sqrtD
	fstp negbsubsqrtD                    ;-b-根號D
	

	fld whata                           
	fmul two                              ;2a
	fld negbaddsqrtD                     ;-b+根號D/2a
	fdiv ST(0),ST(1)
	call WriteFloat
	call crlf	

	fld whata                           
	fmul two                             ;2a
	fld negbsubsqrtD                     ;-b-根號D/2a
	fdiv ST(0),ST(1)
	call WriteFloat
	call crlf
	

	jmp  EXITTT

EXITTT:
call WaitMsg
	INVOKE ExitProcess , 0
main ENDP
END main