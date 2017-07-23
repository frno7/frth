: t:offset, ( addr -- ) \ FIXME Use image/types.fth
   dup c, 8 rshift
   dup c, 8 rshift
   dup c, 8 rshift
       c, ;
: t:offset@ ( addr -- u )
   dup c@                    swap char+
   dup c@           8 lshift swap char+
   dup c@          16 lshift swap char+
       c@ 8 lshift 16 lshift or or or ;
: t:offset! ( addr1 addr2 -- )
   2dup c! char+ swap 8 rshift swap
   2dup c! char+ swap 8 rshift swap
   2dup c! char+ swap 8 rshift swap
        c! ;
: t:relative; ( -- addr ) here 0 t:offset, ;
: t:relative, ( addr -- ) here - 4 - t:offset, ;
: t:relative! ( addr -- ) dup here swap - 4 - swap t:offset! ;
: (t:relative!) ( a-addr1 a-addr2 -- ) swap over - 4 - swap t:offset! ;

: if, ( x -- ) ( C: -- orig )
   $48 c, $8b c, $45 c, $00 c,    \ mov  rax,[rbp]
   $48 c, $8d c, $6d c, $08 c,    \ lea  rbp,[rbp+8]
   $48 c, $85 c, $c0 c,           \ test rax,rax
   $0f c, $84 c, t:relative; ;    \ je   xxxxxxxx

: ahead, ( C: -- orig )
   $e9 c, t:relative; ;           \ jmp  xxxxxxxx

: then, ( C: orig -- )
   t:relative! ;

: until, ( C: dest -- )
   $48 c, $8b c, $45 c, $00 c,    \ mov  rax,[rbp]
   $48 c, $8d c, $6d c, $08 c,    \ lea  rbp,[rbp+8]
   $48 c, $85 c, $c0 c,           \ test rax,rax
   $0f c, $84 c, t:relative, ;    \ je   xxxxxxxx

: again, ( C: dest -- )
   $e9 c, t:relative, ;           \ jmp  xxxxxxxx

include kernel/leave.fth

: leave, ( C: -- )
   $e9 c, leave> (leave,) >leave ; \ jmp xxxxxxxx
