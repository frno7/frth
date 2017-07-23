\ When compiling an image code that will be interpreted is interleaved with
\ definitions and data. The PROLOGUE, and EPILOGUE, words are used to jump
\ over these definitions. Apart from the normal states 0 (compilation) and
\ 1 (interpretation), there is a third state 2 which is image interpretation
\ used by for example the CODE ... END-CODE words.

include kernel/comment.fth
include kernel/colon.fth
include kernel/flow.fth
include kernel/flags.fth
include kernel/postpone.fth
include kernel/variable.fth

: include ( "name" -- ) parse-name compile-file ;

: code ( "name" -- ) code 2 state ! ;
: end-code ( x1 ... xn -- ) 0 state ! end-code ;

: value ( -- x ) ( x "<spaces>name" -- ) compilable
   prologue, 0 parse-name ?redefined (value) epilogue,
   latest >value t:>address t:address-literal, postpone ! ;
: constant ( -- x ) ( x "<spaces>name" -- ) compilable
   prologue, 0 parse-name ?redefined (value) epilogue,
   latest >value t:>address t:address-literal, postpone ! ;
: to ( "<spaces>name" -- )
   parse-name ?found >value t:>address t:address-literal, postpone ! ;

: literal ( n -- ) postpone literal, ;
: sliteral ( c-addr u -- ) (sliteral) swap t:address-literal, literal, ;

: s" '"' parse postpone sliteral ;
: ." postpone s" postpone type ;

: '' ( "<spaces>name" -- xt ) parse-name ?found t:>address t:address-literal, ;
: ' ( "<spaces>name" -- xt ) compilable postpone '' ;
: ['] ( "<spaces>name" -- xt ) postpone '' ;
