code sys-call0 ( n -- n )
 48 8b 45 00             \ mov  rax,[rbp]
 0f 05                   \ syscall
 48 89 45 00             \ mov  [rbp],rax
end-code

code sys-call1 ( x n -- n )
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 7d 08             \ mov  rdi,[rbp+8]
 48 8d 6d 08             \ lea  rbp,[rbp+8]
 0f 05                   \ syscall
 48 89 45 00             \ mov  [rbp],rax
end-code

code sys-call2 ( x x n -- n )
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 7d 08             \ mov  rdi,[rbp+8]
 48 8b 75 10             \ mov  rsi,[rbp+16]
 48 8d 6d 10             \ lea  rbp,[rbp+16]
 0f 05                   \ syscall
 48 89 45 00             \ mov  [rbp],rax
end-code

code sys-call3 ( x x x n -- n )
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 7d 08             \ mov  rdi,[rbp+8]
 48 8b 75 10             \ mov  rsi,[rbp+16]
 48 8b 55 18             \ mov  rdx,[rbp+24]
 48 8d 6d 18             \ lea  rbp,[rbp+24]
 0f 05                   \ syscall
 48 89 45 00             \ mov  [rbp],rax
end-code

code sys-call6 ( x x x x x x n -- n )
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 7d 08             \ mov  rdi,[rbp+8]
 48 8b 75 10             \ mov  rsi,[rbp+16]
 48 8b 55 18             \ mov  rdx,[rbp+24]
 4c 8b 55 20             \ mov  r10,[rbp+32]
 4c 8b 45 28             \ mov  r8,[rbp+40]
 4c 8b 4d 30             \ mov  r9,[rbp+48]
 48 8d 6d 30             \ lea  rbp,[rbp+48]
 0f 05                   \ syscall
 48 89 45 00             \ mov  [rbp],rax
end-code

\ FIXME Restart system calls properly.
: sys-exit   ( n -- )               $2000001 sys-call1 ; \ status --
: sys-read   ( u a-addr fd -- n )   $2000003 sys-call3 ; \ nbyte buf fd -- size
: sys-write  ( u a-addr fd -- n )   $2000004 sys-call3 ; \ nbyte buf fd -- size
: sys-open   ( u fam c-addr -- fd ) $2000005 sys-call3 ; \ mode flags path -- fd
: sys-close  ( fd -- ior )          $2000006 sys-call1 ; \ fd -- status
: sys-unlink ( c-addr u -- ior )    $200000a sys-call1 ; \ name -- status

: sys-mmap   ( u fd u u u addr -- addr )
   $20000c5 sys-call6 ; \ offset fd flags prot len addr -- addr

include system/macos/brk.fth
