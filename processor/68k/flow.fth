: t:offset, ( u -- )
   dup 8 rshift c, c, ;
: t:offset@ ( addr -- u )
   dup c@ 8 lshift swap char+ c@ or ;
: t:offset! ( u addr -- )
   2dup swap 8 rshift swap c! char+ c! ;
: t:relative; ( -- addr ) here 0 t:offset, ;
: t:relative, ( addr -- ) here - t:offset, ;
: t:relative! ( addr -- ) dup here swap - swap t:offset! ;
: (t:relative!) ( a-addr1 a-addr2 -- ) swap over - swap t:offset! ;
: t:absolute! ( addr1 addr2 -- ) t:! ;

: if, ( x -- ) ( C: -- orig )
   $4a c, $9e c,                  \ tst.l   (a6)+
   $67 c, $00 c, t:relative; ;    \ beq.w   xxxx

: ahead, ( C: -- orig )
   $60 c, $00 c, t:relative; ;    \ bra.w   xxxx

: then, ( C: orig -- )
   t:relative! ;

: until, ( C: dest -- )
   $4a c, $9e c,                  \ tst.l   (a6)+
   $67 c, $00 c, t:relative, ;    \ beq.w   xxxx

: again, ( C: dest -- )
   $60 c, $00 c, t:relative, ;    \ bra.w   xxxx

include kernel/leave.fth

: leave, ( C: -- )
   $60 c, $00 c, leave> (leave,) >leave ; \ bra.w xxxx
