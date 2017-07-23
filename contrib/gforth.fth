\ This is a basic Frth emulation layer for Gforth, intended to be used for
\ compiling Frth the first time. Command line arguments supplied after "--"
\ are forwarded to Frth.
\
\ To compile Frth for Linux/x64 one can for example do:
\
\ % gforth -e "fpath+ $PWD" contrib/gforth.fth -e bye -- -o frth-linux-x64 --target linux/x64

vocabulary frth also frth definitions

: 1= 1 = ;
: 4- ( n1 -- n2 ) 4 - ;
: 4+ ( n1 -- n2 ) 4 + ;
: 8- ( n1 -- n2 ) 8 - ;
: 8+ ( n1 -- n2 ) 8 + ;
: 2** ( n n -- n ) dup 0< if 0 swap ?do 2/ loop else lshift then ;

: nup  ( x1 x2 -- x1 x1 x2 ) over swap ;
: swup ( x1 x2 x3 -- x2 x1 x3 ) >r swap r> ;
: keep ( x f -- x -1 | 0 ) if true else drop false then ;
: 3drop 2drop drop ;

: cmove, ( c-addr u -- ) here swap dup allot cmove ;
: erase, ( u -- ) here swap dup allot erase ;

: s= str= ;
: s== str= ; \ FIXME S== is intended to be case insensitive, but str= is not.
: sprefix? string-prefix? ;
: 1/string 1 /string ;

0 value exit-success
1 value exit-failure

: prologue, ;
: epilogue, ;

: bye! ( n -- ) drop bye ; \ FIXME How to exit Gforth with a code?

: ?2dup ( x1 x2 -- x1 x2 x1 x2 | x1 x2 ) 2dup 0 0 d<> if 2dup then ;

include kernel/error.fth
include kernel/unicode.fth
include kernel/numeric.fth

\ FIXME >NAME has a different meaning in Frth.
: >name ( xt -- c-addr u ) name>string ;

: found ( c-addr u -- 0 | nt ) find dup if drop else nip then ;

\ Supply arguments given after "--" to Gforth.
: traverse-arguments ( xt -- ) ( xt: c-addr u -- f )
   >r false 0
   begin dup arg ?2dup 0 0 d<>
   while ( f n c-addr u )
         3 pick if
            2swap ( c-addr u f n )
            r@ -rot 2>r ( c-addr u xt )
            execute 0= if 2rdrop rdrop exit then
            2r>
         else s" --" s= if
            nip true swap
         then then 1+ ( f n )
   repeat ( f n ) 2drop rdrop ;

: wordlist-name ( "<spaces>name" -- wid ) parse-name 2drop wordlist ;

include kernel/command.fth
