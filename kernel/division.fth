\ Division definitions taken from eForth Overview by C.H. Ting.

: um/mod ( ud u -- ur uq )
   2dup u< if negate
      bits/cell 0 do
	 >r dup um+ >r >r dup um+ r> + dup
	 r> r@ swap >r um+  r> or
	 if >r drop 1 + r> else drop then
	 r>
      loop drop swap exit
   then drop 2drop -1 dup ;

: m/mod ( d n -- r q ) \ Floored division.
   dup 0< dup >r if negate >r dnegate r> then
       >r dup 0< if r@ + then
    r> um/mod r> if swap negate swap then ;

: /mod ( n n -- r q ) over 0< swap m/mod ;

: mod ( n n -- r ) /mod drop ;

: / ( n n -- q ) /mod swap drop ;
