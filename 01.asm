INCLUDE Irvine32.inc
INCLUDE Macros.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	 out1		           BYTE    "請輸入攝氏溫度：", 0
	 out2		           BYTE    "轉成的華氏溫度為：", 0
	 nine                  real4    9.0
	 five                  real4    5.0
	 thirty_two            real4    32.0
.code
main PROC
	call Clrscr ;清除螢幕
	;finit       ;初始化FPU
;----------------------------------------------------------------
	mov edx , OFFSET out1			;告知輸入攝氏溫度
	call WriteString
	call Crlf
	call ReadFloat
	 
	fmul nine  ;*9

	fdiv five   ;/5

	fld thirty_two
	fadd 

	mov edx , OFFSET out2			;告知輸出之華式溫度
	call WriteString
	call Crlf
	call WriteFloat
	call crlf

	
call WaitMsg
	INVOKE ExitProcess , 0
main ENDP
END main