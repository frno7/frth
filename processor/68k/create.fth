: (create) ( c-addr u -- )
   ?redefined create-name, 12 c, 0 c, create-link,
   $2d c, $3c c, here t:>address 10 + t:address, \ move.l #xxxxxxxx,-(a6)
   $4e c, $71 c,                          \ nop
   $4e c, $71 c,                          \ nop
   $4e c, $75 c, ;                        \ rts

: (value) ( x c-addr u -- )
   ?redefined create-name, 8 c, 0 c, create-link,
   $2d c, $3c c, t:address,                      \ move.l #xxxxxxxx,-(a6)
   $4e c, $75 c, ;                        \ rts

: (variable) ( c-addr u -- )
   ?redefined create-name, 8 c, 0 c, create-link,
   $2d c, $3c c, here t:>address 6 + t:address,  \ move.l #xxxxxxxx,-(a6)
   $4e c, $75 c, ;                        \ rts
\  $41 c, $fa c, $00 c, $06 c,            \ lea     6(pc),a0 FIXME
\  $2d c, $08 c,                          \ move.l  a0,-(a6)
\  $4e c, $75 c, ;                        \ rts

: >value ( xt -- addr ) >code 2 + ; \ Address to value given execution token.

: relative-call, ( xt -- )
   $61 c, $00 c, >code t:relative, ;     \ bsr.w xxxx

: absolute-call, ( xt -- )
   $4e c, $b9 c, >code t:>address t:address, ;  \ jsr   xxxxxxxx

: call, ( xt -- ) \ Prefer relative call if possible.
   dup here - abs $7fff u< if relative-call, else absolute-call, then ;

: inline, ( xt -- ) dup >code swap code# 2 - ( 2- for rts ) cmove, ;
