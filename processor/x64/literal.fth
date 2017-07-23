: literal, ( n -- )
   $48 c, $b8 c, t:,             \ mov  rax,xxxxxxxxxxxxxxxx
   $48 c, $89 c, $45 c, $f8 c,   \ mov  [rbp-8],rax
   $48 c, $8d c, $6d c, $f8 c, ; \ lea  rbp,[rbp-8]
: >literal ( xt -- addr ) t:cell+ 2 + ;

: t:address, ( addr -- ) here t:relocate t:, ;
: t:address! ( addr addr -- ) dup t:relocate t:! ;
: t:address-literal, ( addr -- ) here 2 + t:relocate literal, ;
