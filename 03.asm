INCLUDE Irvine32.inc
INCLUDE Macros.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	 out1		           BYTE    "������ƪ�G", 0
	 out2                  BYTE    "Sin",0
	 out3                  BYTE    ":",0
	 times                 DD      19         ;�H�C5�׬��@���A�@�ݰ�19��
	 nu180                 DD      180            
	 num                   DD      0 
.code
main PROC
	call Clrscr ;�M���ù�
	;finit       ;��l��FPU
;----------------------------------------------------------------
	mov edx , OFFSET out1			;�g�X������ƪ�
	call writestring
	call crlf

	mov ecx,times 
Timesss:
     
	mov edx , OFFSET out2			
	call writestring
	mov eax,num
	call writeDec
	mov edx , OFFSET out3		
	call writestring

	fldpi      ;ST(1)
	fild nu180 ;ST(0)
	fdiv
	fild num
	fmul
	
	fsin
	;call ShowFPUStack
	call writefloat
	call crlf
	finit
	mov eax,num
	add eax,5
	mov num,eax

	loop Timesss

call WaitMsg
	INVOKE ExitProcess , 0
main ENDP
END main