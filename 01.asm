INCLUDE Irvine32.inc
INCLUDE Macros.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	 out1		           BYTE    "�п�J���ūסG", 0
	 out2		           BYTE    "�ন���ؤ�ū׬��G", 0
	 nine                  real4    9.0
	 five                  real4    5.0
	 thirty_two            real4    32.0
.code
main PROC
	call Clrscr ;�M���ù�
	;finit       ;��l��FPU
;----------------------------------------------------------------
	mov edx , OFFSET out1			;�i����J���ū�
	call WriteString
	call Crlf
	call ReadFloat
	 
	fmul nine  ;*9

	fdiv five   ;/5

	fld thirty_two
	fadd 

	mov edx , OFFSET out2			;�i����X���ئ��ū�
	call WriteString
	call Crlf
	call WriteFloat
	call crlf

	
call WaitMsg
	INVOKE ExitProcess , 0
main ENDP
END main