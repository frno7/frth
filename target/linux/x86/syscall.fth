code sys-call0 ( n -- n )
 8b 45 00                \ mov  eax,[ebp]
 cd 80                   \ int  0x80
 89 45 00                \ mov  [ebp],eax
end-code

code sys-call1 ( x n -- n )
 8b 45 00                \ mov  eax,[ebp]
 8b 5d 04                \ mov  ebx,[ebp+4]
 cd 80                   \ int  0x80
 89 45 04                \ mov  [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code sys-call2 ( x x n -- n )
 8b 45 00                \ mov  eax,[ebp]
 8b 5d 04                \ mov  ebx,[ebp+4]
 8b 4d 08                \ mov  ecx,[ebp+8]
 cd 80                   \ int  0x80
 89 45 08                \ mov  [ebp+8],eax
 8d 6d 08                \ lea  ebp,[ebp+8]
end-code

code sys-call3 ( x x x n -- n )
 8b 45 00                \ mov  eax,[ebp]
 8b 5d 04                \ mov  ebx,[ebp+4]
 8b 4d 08                \ mov  ecx,[ebp+8]
 8b 55 0c                \ mov  edx,[ebp+12]
 cd 80                   \ int  0x80
 89 45 0c                \ mov  [ebp+12],eax
 8d 6d 0c                \ lea  ebp,[ebp+12]
end-code

\ FIXME Restart system calls properly.
: sys-exit   ( n -- )                    1 sys-call1 ; \ status --
: sys-read   ( u a-addr fd -- n )        3 sys-call3 ; \ nbyte buf fd -- size
: sys-write  ( u a-addr fd -- n )        4 sys-call3 ; \ nbyte buf fd -- size
: sys-open   ( u fam c-addr -- fd )      5 sys-call3 ; \ mode flags path -- fd
: sys-close  ( fd -- ior )               6 sys-call1 ; \ fd -- status
: sys-unlink ( c-addr u -- ior )        10 sys-call1 ; \ name -- status
: sys-brk    ( a-addr -- a-addr )       45 sys-call1 ; \ addr -- addr
