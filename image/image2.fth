\ The image compiler interpreter.

: compile, ( xt -- )
   dup inline? if inline, else call, then ;

: compile-number, ( n -1 | d -2 -- )
   abs 0 ?do i roll literal, loop ;

: compile-word ( c-addr u -- )
   2>r  2r@     found ?dup if compile,
   else 2r@ (>number) ?dup if compile-number,
   else 2r@ error-undefined-word
   then then 2rdrop ;

: interpret-word ( c-addr u -- )
   2dup target c:search-wordlist
     if nip nip execute
   else state @ 2 = if evaluate else compile-word then
   then ;

: compiler-interpret ( -- )
   begin refill
   while begin parse-name ?dup
         while interpret-word
         repeat drop
   repeat ;

: compile-file ( c-addr u -- )
   r/o open-file throw ['] compiler-interpret execute-parsing-file ;

: precompiled! ( -- ) \ Update precompiled definition if it exists.
   s" precompiled" found ?dup if latest t:>address swap >literal t:address! then ;

: text:size! ( -- ) \ Update text:size definition if it exists.
   s" text:size" found ?dup if image:text> nip swap >literal t:! then ;

: compile-image ( c-addr u -- a-addr u )
   image:open compile-file
   t:align precompiled! text:size!
   image:text> drop relocate,
   image:close image> ;

: compilable ( -- )
   postpone state
   postpone @ 1
   postpone literal
   postpone =
   postpone if c:latest>name
   postpone sliteral
   postpone compile-word
   postpone exit
   postpone then ; immediate compile-only

: (postpone) ( "<spaces>name" -- )
   parse-name postpone sliteral postpone interpret-word ;
: postpone (postpone) ; immediate compile-only

include kernel/control.fth
include kernel/value.fth

: [ ( -- ) 0 state ! ; \ Enter interpretation state.
: ] ( -- ) 1 state ! ; \ Enter compilation state.

: (sliteral) ( c-addr1 u1 -- c-addr2 u2 ) \ FIXME smove,
   2>r state @ 1 = if ahead, else prologue, then 2r>
   dup erase, dup >r cmove, here t:>address r@ - r> \ Copy string to data space.
   2>r state @ 1 = if t:align then, else epilogue, then 2r> ;

: compile-only ; \ The image compiler needs to interpret compile-only as well.

target c:set-current

include image/target.fth

c:definitions
