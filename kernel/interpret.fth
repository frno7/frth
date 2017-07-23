: error-compile-only ( xt -- )
   >name type ." : Interpreting compile-only word." cr -14 throw ;

: interpret-number ( n -1 | d -2 -- | n | d )
   state @ 0= if
      drop
   else
      compile-number,
   then ;

: interpret-definition ( xt -- )
   state @ 0= if
      dup compile-only? if error-compile-only else execute then
   else
      dup immediate? if execute else compile, then
   then ;

: interpret-word ( c-addr u -- )
   2>r  2r@     found ?dup if interpret-definition
   else 2r@ (>number) ?dup if interpret-number
   else 2r@ error-undefined-word
   then then 2rdrop ;

: (interpret) ( xt -- )
   >r r@ execute
   begin refill
   while begin parse-name ?dup
         while interpret-word
         repeat drop
         r@ execute
   repeat rdrop ;

: prompt' ( -- ) ;
: prompt  ( -- ) ."   ok " .s cr ;

: interpret ( -- ) ['] prompt' (interpret) ;

: (quit) ( -- ) ['] prompt (interpret) ;

: quit ( -- )
   begin ['] (quit) catch ?dup
   while . errno . s" : exception" type cr
   repeat ;
