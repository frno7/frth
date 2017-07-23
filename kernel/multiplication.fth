\ Multiplication definitions taken from eForth Overview by C.H. Ting.

: um* ( u u -- ud )
   0 swap ( u1 0 u2 )
   bits/cell 0 do
      dup um+ >r >r dup um+ r> + r>
      if >r over um+ r> + then
   loop rot drop ;

: m* ( n n -- d ) 2dup xor 0< >r abs swap abs um*  r> if dnegate then ;

: */mod ( n n n -- r q ) >r m* r> m/mod ;

: */ ( n n n -- q ) */mod swap drop ;
