: (create) ( c-addr u -- )
   ?redefined create-name, 19 c, 0 c, create-link,
   $48 c, $b8 c, here t:>address 22 + t:address,    \ mov rax,xxxxxxxxxxxxxxxx
   $48 c, $89 c, $45 c, $f8 c,               \ mov [rbp-8],rax
   $48 c, $8d c, $6d c, $f8 c,               \ lea rbp,[rbp-8]
   $c3 c, 5 erase, ;                         \ ret and align

: (value) ( x c-addr u -- )
   ?redefined create-name, 19 c, 0 c, create-link,
   $48 c, $b8 c, t:address,                         \ mov rax,xxxxxxxxxxxxxxxx
   $48 c, $89 c, $45 c, $f8 c,               \ mov [rbp-8],rax
   $48 c, $8d c, $6d c, $f8 c,               \ lea rbp,[rbp-8]
   $c3 c, ;                                  \ ret

: (variable) ( c-addr u -- )
   ?redefined create-name, 15 c, 0 c, create-link,
   $8d c, $05 c, $0a c, $00 c, $00 c, $00 c, \ lea eax,[rel $ +16]
   $48 c, $89 c, $45 c, $f8 c,               \ mov [rbp-8],rax
   $48 c, $8d c, $6d c, $f8 c,               \ lea rbp,[rbp-8]
   $c3 c, $00 c, ;                           \ ret and align

: >value ( xt -- addr ) >code 2 + ; \ Address to value given execution token.

: relative-call, ( xt -- )
   $e8 c, >code t:relative, ;         \ call xxxxxxxx

: absolute-call, ( xt -- )
   $48 c, $b8 c, >code t:>address t:address, \ mov  rax,xxxxxxxxxxxxxxxx
   $ff c, $d0 c, ;                    \ call rax

: call, ( xt -- ) \ Prefer relative call if possible.
   dup here - abs $7fffffff u< if relative-call, else absolute-call, then ;

: inline, ( xt -- ) dup >code swap code# 1- ( 1- for ret ) cmove, ;
