: (sliteral) ( c-addr1 u1 -- c-addr2 u2 )
   2>r state @ 1 = if ahead, else prologue, then 2r>
   dup erase, dup >r cmove, here t:>address r@ - r> \ Copy string to data space.
   2>r state @ 1 = if t:align then, else epilogue, then 2r> ;

: literal ( n -- ) literal, ; immediate compile-only
: sliteral ( c-addr u -- )
   (sliteral) swap t:address-literal, literal, ; immediate compile-only

: compile, ( xt -- )
   dup inline? if inline, else call, then ;

: compile-number, ( n -1 | d -2 -- )
   abs 0 ?do i roll postpone literal loop ;

include kernel/postpone.fth

: ' ( "<spaces>name" -- xt ) parse-name ?found ; immediate

: ['] ( "<spaces>name" -- xt )
   postpone ' postpone literal ; immediate compile-only

: to ( "<spaces>name" -- )
   ' >value state @ if postpone literal postpone ! else ! then ; immediate

: char ( "char"<space> -- c ) parse-name 0= if 0 else c@ then ;
: [char] ( "<spaces>name" -- ) char postpone literal ; immediate compile-only

: recurse ( -- )
   latest literal postpone execute ; immediate compile-only
