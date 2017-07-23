code sys-call0 ( n -- n )
 48 8b 45 00             \ mov  rax,[rbp]
 0f 05                   \ syscall
 48 89 45 00             \ mov  [rbp],rax
end-code

code sys-call1 ( x n -- n )
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 7d 08             \ mov  rdi,[rbp+8]
 0f 05                   \ syscall
 48 89 45 08             \ mov  [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code sys-call2 ( x x n -- n )
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 7d 08             \ mov  rdi,[rbp+8]
 48 8b 75 10             \ mov  rsi,[rbp+16]
 0f 05                   \ syscall
 48 89 45 10             \ mov  [rbp+16],rax
 48 8d 6d 10             \ lea  rbp,[rbp+16]
end-code

code sys-call3 ( x x x n -- n )
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 7d 08             \ mov  rdi,[rbp+8]
 48 8b 75 10             \ mov  rsi,[rbp+16]
 48 8b 55 18             \ mov  rdx,[rbp+24]
 0f 05                   \ syscall
 48 89 45 18             \ mov  [rbp+24],rax
 48 8d 6d 18             \ lea  rbp,[rbp+24]
end-code

\ FIXME Restart system calls properly.
: sys-read   ( u a-addr fd -- n )        0 sys-call3 ; \ nbyte buf fd -- size
: sys-write  ( u a-addr fd -- n )        1 sys-call3 ; \ nbyte buf fd -- size
: sys-open   ( u fam c-addr -- fd )      2 sys-call3 ; \ mode flags path -- fd
: sys-close  ( fd -- ior )               3 sys-call1 ; \ fd -- status
: sys-brk    ( a-addr -- a-addr )       12 sys-call1 ; \ addr -- addr
: sys-exit   ( n -- )                   60 sys-call1 ; \ status --
: sys-unlink ( c-addr u -- ior )        87 sys-call1 ; \ name -- status
