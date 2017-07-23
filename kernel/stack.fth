: nup  ( x1 x2 -- x1 x1 x2 ) over swap ;
: swup ( x1 x2 x3 -- x2 x1 x3 ) >r swap r> ;

: 3drop ( x x x -- ) 2drop drop ;
: tuck  ( x1 x2 -- x2 x1 x2 ) swap over ;
: pick  ( x0...xu u -- x0...xu x0 ) 2 + cells sp@ + @ ;
: keep  ( x f -- x -1 | 0 ) if true else drop false then ; \ FIXME Keep this?

: roll ( x1 x2 ... xu u -- x2 ... xn x1 )
   ?dup if >r
      here r@ 0 ?do swap over ! cell+ loop ( x1 a-addr )
      swap r> ( a-addr x1 u )
      swap >r ( a-addr u )
              0 ?do cell- dup @ swap loop drop
   r> then ;

\ This implementation depends on the return address being on the return stack.
: n>r ( xn ... x1 n -- ) ( R: -- x1 ... xn n )
   dup
   begin dup                  \ xn .. x1 n n --
   while rot r> swap >r >r 1- \ xn .. n n -- ; R: .. x1 --
   repeat                     \ xn .. n 'n -- ; R: .. x1 --
   drop                       \ n -- ; r: x1 .. xn --
   r> swap >r >r ; inline compile-only

\ This implementation depends on the return address being on the return stack.
: nr> ( -- xn ... x1 n ) ( R: x1 ... xn n -- )
   r> r> swap >r dup
   begin dup
   while r> r> swap >r -rot 1-
   repeat
   drop ; inline compile-only

: clearstack ( n * x -- ) sp0 sp! ;
