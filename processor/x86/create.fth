: (create) ( c-addr u -- )
   ?redefined create-name, 12 c, 0 c, create-link,
   $b8 c, here t:>address 11 + t:address, \ mov eax,xxxxxxxx
   $89 c, $45 c, $fc c,            \ mov [ebp-4],eax
   $8d c, $6d c, $fc c,            \ lea ebp,[ebp-4]
   $c3 c, ;                        \ ret

: (value) ( x c-addr u -- )
   ?redefined create-name, 12 c, 0 c, create-link,
   $b8 c, t:,                      \ mov eax,xxxxxxxx
   $89 c, $45 c, $fc c,            \ mov [ebp-4],eax
   $8d c, $6d c, $fc c,            \ lea ebp,[ebp-4]
   $c3 c, ;                        \ ret

: (variable) ( c-addr u -- )
   ?redefined create-name, 12 c, 0 c, create-link,
   $b8 c, here t:>address 11 + t:address, \ mov eax,xxxxxxxx
   $89 c, $45 c, $fc c,            \ mov [ebp-4],eax
   $8d c, $6d c, $fc c,            \ lea ebp,[ebp-4]
   $c3 c, ;                        \ ret

: >value ( xt -- addr ) >code 1+ ; \ Address to value given execution token.

: call, ( xt -- ) $e8 c, >code t:relative, ; \ FIXME Absolute call.
\ : call, ( xt -- ) $ff c, $15 c, >code t:>address t:address, ; \ call [xxxxxxxx]

: inline, ( xt -- ) dup >code swap code# 1- ( 1- for ret ) cmove, ;
