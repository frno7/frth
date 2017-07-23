: traverse-wordlist ( xt wid -- ) ( xt: nt -- f )
   swap >r
   begin dup
   while r@ over >r execute r> swap
   while dup t:@ ?dup if - else drop rdrop exit then
   repeat then drop rdrop ;

: (found) ( c-addr u 0 nt -- c-addr u nt 0 | c-addr u 0 -1 )
   nip >r 2dup r@ name= if r> false else rdrop 0 true then ;

: search-wordlist ( c-addr u wid -- 0 | xt 1 | xt -1 )
   >r 0 ['] (found) r> @ traverse-wordlist >r 2drop r>
   dup if dup immediate? if 1 else -1 then then ; \ FIXME Is immediate accurate?

: found ( c-addr u -- 0 | nt )
   #order @ 0 ?do
      2dup i cells context + @ search-wordlist
      if >r 2drop r> unloop exit then
   loop 2drop 0 ;

: ?found ( c-addr u -- nt )
   2dup found ?dup 0= if error-undefined-word else >r 2drop r> then ;

: ?redefined ( c-addr u -- c-addr u ) \ FIXME source-file:row: <error>
   2dup get-current search-wordlist if drop 2dup type ." : Redefined word." cr then ; \ FIXME warning

: (words) ( nt -- -1 ) >name type space true ;
: words ( -- ) ['] (words) context @ @ traverse-wordlist cr ;
