: (s") ( c-addr1 u1 -- c-addr2 u2 )
   dup allot dup >r cmove, here r@ - r> t:align ;
: s" ( "ccc<quote>" -- c-addr u )
   state @ 0<> if
      postpone ahead
      '"' parse (s") 2>r
      postpone then r> r>
      postpone literal
      postpone literal
   else
      '"' parse (s")
   then ; immediate

: ." ( "ccc<quote>" -- )
   state @ 0<> if
      postpone s"
      postpone type
   else
      '"' parse 0 max type
   then ; immediate
