: count ( c-addr -- c-addr u ) dup 1+ swap c@ ;
: 0count ( c-addr -- c-addr u ) 0 begin 2dup + c@ while 1+ repeat ;

: /string ( c-addr1 u1 n -- c-addr2 u2 ) tuck - -rot + swap ; \ FIXME under
: 1/string ( c-addr1 u1 -- c-addr2 u2 ) 1 /string ; \ FIXME under

: (s=) ( c-addr1 c-addr2 u -- f )
   bounds ?do dup c@ i c@ <> if drop false unloop exit then 1+ loop drop true ;

: s= ( c-addr1 u1 c-addr2 u2 -- f )
   rot over ( c-addr1 c-addr u2 u1 u2 ) = if (s=) else 3drop false then ;

: sprefix? ( c-addr1 u1 c-addr u2 -- f ) \ Is c-addr2 u2 a prefix of c-addr1 u1?
   rot over ( c-addr1 c-addr u2 u1 u2 ) >= if (s=) else false then ;

: csuffix? ( c-addr u char -- f ) \ Is char a prefix of the string c-addr u?
   over if -rot + 1- c@ = else 3drop false then ;

: >lower ( c -- c ) dup 'A' 'Z' 1+ within if 'A' - 'a' + then ; \ FIXME Literal

: s== ( c-addr1 u1 c-addr2 u2 -- f )
   rot over = if bounds ?do
	 dup c@ >lower i c@ >lower <> if drop false unloop exit then 1+
      loop drop true
   else 3drop false then ;

: index ( c-addr1 u1 c -- u2 ) \ FIXME Better name
   >r nup bounds
   begin 2dup <>
   while dup c@ r@ <>
   while char+
   repeat then nip - negate rdrop ;

: split ( c-addr1 u c -- c-addr2 u2 c-addr1 u1 ) \ FIXME Better name
   dup 2>r 2dup r> index
   swap >r 2dup + over r> - negate
   over c@ r> = if 1/string then
   2swap ;

: place ( c-addr1 u1 c-addr2 -- )
   over 255 swap u< if -18 throw then
   2dup 2>r char+ swap chars cmove 2r> c! ;

: +place ( c-addr1 u1 c-addr2 -- )
   2dup c@ chars + 255 swap u< if -18 throw then
   2dup 2>r count chars + swap chars cmove
   2r> dup >r c@ + r> c! ;
