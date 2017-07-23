: s>d ( n -- d ) dup 0< ;
: d>s ( d -- n ) drop ;

: d0<  ( d -- f ) nip 0< ;
: d0=  ( d -- f )  or 0= ;
: d0<> ( d -- f ) d0= 0= ;

: d= ( d d -- f ) rot = -rot = and ;
: d+ ( d d -- d ) >r swap >r um+ r> r> + + ;
: dabs ( d -- d ) d0< if dnegate then ;

: udm/mod ( ud u -- u ud ) >r 0 r@ um/mod r> swap >r um/mod r> ;
