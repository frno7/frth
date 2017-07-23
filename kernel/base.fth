variable base

: binary  ( -- )  2 base ! ;
: octal   ( -- )  8 base ! ;
: decimal ( -- ) 10 base ! ;
: hex     ( -- ) 16 base ! ;

\ Execute xt in given base and restore base afterwards.
: base-execute ( xt u -- ) ( xt: -- ) base @ >r base ! execute r> base ! ;

decimal
