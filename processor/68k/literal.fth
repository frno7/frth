: literal, ( n -- ) $2d c, $3c c, t:, ; \ move.l #xxxxxxxx,-(a6)
: >literal ( xt -- addr ) t:cell+ 2 + ;

: t:address, ( addr -- ) here t:relocate t:, ;
: t:address! ( addr addr -- ) dup t:relocate t:! ;
: t:address-literal, ( addr -- ) here 2 + t:relocate literal, ;
