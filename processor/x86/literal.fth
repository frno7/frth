: literal, ( n -- ) \ FIXME Optimise CREATE with this.
   $c7 c, $45 c, $fc c, t:, \ mov  dword [ebp-4],xxxxxxxx
   $8d c, $6d c, $fc c, ;   \ lea  ebp,[ebp-4]
: >literal ( xt -- addr ) t:cell+ 3 + ;

: t:address, ( addr -- ) here t:relocate t:, ;
: t:address! ( addr addr -- ) dup t:relocate t:! ;
: t:address-literal, ( addr -- ) here 3 + t:relocate literal, ;
