: precompiled 0 ; \ Predefined definition assigned by the compiler.

0 value #wordlist

: wordlist>name ( wid -- c-addr u ) cell+ 2@ ;
: name>wordlist ( c-addr u wid -- ) >r here over 2>r cmove, 2r> r> cell+ 2! ;

: wordlist ( -- wid )
   align here 0 , 0 , 0 , \ Assign wl0, wl1, wl2, ... to anonymous word lists.
   dup <# #wordlist s>d #s 'l' hold 'w' hold #> rot name>wordlist
   #wordlist 1+ to #wordlist ;

: named-wordlist ( c-addr u -- wid ) wordlist >r r@ name>wordlist r> ;
: wordlist-name ( "<spaces>name" -- wid ) parse-name named-wordlist ;

wordlist value forth-wordlist
precompiled forth-wordlist !
s" forth" forth-wordlist name>wordlist

variable #order \ FIXME Check maximum order.

\ create context 16 ( wordlists ) cells allot
0 value context
align here to context
16 ( wordlists ) cells allot

: get-order ( -- wid1 ... widn n )
   #order @ 0 ?do
      #order @ i - 1- cells context + @
   loop #order @ ;

: set-order ( wid1 ... widn n -- )
   dup -1 = if
      drop forth-wordlist 1
   then
   dup #order !
   0 ?do i cells context + ! loop ;

: previous ( -- ) get-order nip 1- set-order ; \ FIXME Search order underflow.
: only ( -- ) -1 set-order ;
: also ( -- ) get-order over swap 1+ set-order ;

variable current \ The wid of the compilation word list.

: set-current ( wid -- ) current ! ;
: get-current ( -- wid ) current @ ;
: definitions ( -- ) get-order swap set-current 1 ?do drop loop ;

: order ( -- )
   get-order 0 ?do wordlist>name type space loop
   2 spaces get-current wordlist>name type cr ;

: latest ( -- nt ) get-current @ ;

: forth ( -- ) get-order nip forth-wordlist swap set-order ;

only definitions
