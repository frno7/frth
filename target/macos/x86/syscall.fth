code sys-call0 ( n -- n )
 8b 45 00                \ mov  eax,[ebp]
 50                      \ push eax
 cd 80                   \ int  0x80
 89 45 00                \ mov  [ebp],eax
 8d 64 24 04             \ lea  esp,[esp+4]
end-code

code sys-call1 ( x n -- n )
 8b 45 00                \ mov  eax,[ebp]
 ff 75 04                \ push dword [ebp+4]
 50                      \ push eax
 8d 6d 04                \ lea  ebp,[ebp+4]
 cd 80                   \ int  0x80
 89 45 00                \ mov  [ebp],eax
 8d 64 24 08             \ lea  esp,[esp+8]
end-code

code sys-call2 ( x x n -- n )
 8b 45 00                \ mov  eax,[ebp]
 ff 75 08                \ push dword [ebp+8]
 ff 75 04                \ push dword [ebp+4]
 50                      \ push eax
 8d 6d 08                \ lea  ebp,[ebp+8]
 cd 80                   \ int  0x80
 89 45 00                \ mov  [ebp],eax
 8d 64 24 0c             \ lea  esp,[esp+12]
end-code

code sys-call3 ( x x x n -- n )
 8b 45 00                \ mov  eax,[ebp]
 ff 75 0c                \ push dword [ebp+12]
 ff 75 08                \ push dword [ebp+8]
 ff 75 04                \ push dword [ebp+4]
 50                      \ push eax
 8d 6d 0c                \ lea  ebp,[ebp+12]
 cd 80                   \ int  0x80
 89 45 00                \ mov  [ebp],eax
 8d 64 24 10             \ lea  esp,[esp+16]
end-code

code sys-call6 ( x x x x x x n -- n )
 8b 45 00                \ mov  eax,[ebp]
 ff 75 18                \ push dword [ebp+24]
 ff 75 14                \ push dword [ebp+20]
 ff 75 10                \ push dword [ebp+16]
 ff 75 0c                \ push dword [ebp+12]
 ff 75 08                \ push dword [ebp+8]
 ff 75 04                \ push dword [ebp+4]
 50                      \ push eax
 8d 6d 18                \ lea  ebp,[ebp+24]
 cd 80                   \ int  0x80
 89 45 00                \ mov  [ebp],eax
 8d 64 24 1c             \ lea  esp,[esp+28]
end-code

\ FIXME Restart system calls properly.
: sys-exit   ( n -- )                    1 sys-call1 ; \ status --
: sys-read   ( u a-addr fd -- n )        3 sys-call3 ; \ nbyte buf fd -- size
: sys-write  ( u a-addr fd -- n )        4 sys-call3 ; \ nbyte buf fd -- size
: sys-open   ( u fam c-addr -- fd )      5 sys-call3 ; \ mode flags path -- fd
: sys-close  ( fd -- ior )               6 sys-call1 ; \ fd -- status
: sys-unlink ( c-addr u -- ior )        10 sys-call1 ; \ name -- status

: sys-mmap   ( u fd u u u addr -- addr )
   197 sys-call6 ; \ offset fd flags prot len addr -- addr

include system/macos/brk.fth
