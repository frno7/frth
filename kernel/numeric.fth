: base*+ ( ud1 u -- ud2 ) >r >r base @ um* r> base @ * + r> s>d d+ ;

: >digit ( c -- 0 | u -1 )
   dup '0' <  if drop      false exit then
   dup '9' <= if      '0' - true exit then
   dup 'A' <  if drop      false exit then
   dup 'Z' <= if 10 + 'A' - true exit then
   dup 'a' <  if drop      false exit then
   dup 'z' <= if 10 + 'a' - true exit then
                 drop      false ;

: digit> ( u -- c ) dup 9 <= if '0' else 10 - 'A' then + ;

: >number ( ud1 c-addr1 u1 -- ud2 c-addr2 u2 )
   begin dup
   while over c@ >digit
   while dup 0 base @ within keep
   while -rot 2>r base*+ 2r> 1/string
   repeat then then ;

\ Give UTF-32 representation of UTF-8 string within quotes or indicate failure.
: (char?) ( c-addr u -- 0 | u -1 )
   dup 3 7 within if ( At least 3 and at most 6 characters needed. )
      over c@ ''' = if ( Check that first character is '. )
	 1/string utf-8>utf-32 if ( c-addr u u )
	    over 1 = if ( Check that there is exactly one character left. )
	       2 pick c@ ''' = if ( Check that this character is '. )
		  >r 2drop r> true exit
   then then drop then then then 2drop false ;

: (>number-sign) ( c-addr u xt -- 0 | d -1 )
   >r dup if ( Needs at least one more digit. )
      over c@ '-' = if
	 1/string r@ execute if dnegate true else false then
      else r@ execute then
   else 2drop false then rdrop ;

: (>number)'' ( c-addr u -- 0 | d -1 )
   dup if ( Needs at least one more digit. )
      2>r 0 0 2r> >number 0= if drop true else 3drop false then
   else 2drop false then ;

: (>number)' ( c-addr u -- 0 | d -1 )
   ['] (>number)'' (>number-sign) ;

: (>number-base) ( c-addr u -- 0 | d -1 )
   dup if ( Needs at least one more digit. )
      over c@ '%' = if 1/string ['] (>number)'  2 base-execute else
      over c@ '&' = if 1/string ['] (>number)' 10 base-execute else
      over c@ '#' = if 1/string ['] (>number)' 10 base-execute else
      over c@ '$' = if 1/string ['] (>number)' 16 base-execute else
      2dup (char?) if >r 2drop r> true else (>number)'
   then then then then then else 2drop false then ;

\ If number ends with dot remove it and indicate double.
: (double?) ( c-addr u -- c-addr u 0 | c-addr u -1 )
   dup if ( Needs at least one character. )
      2dup + char- c@ '.' = if 1- true exit then
   then false ;

: (>number) ( c-addr u -- 0 | n -1 | d -2 )
   (double?) if
      ['] (>number-base) (>number-sign) if -2 else 0 then
   else 2dup 2>r (char?) ?dup if
      2rdrop
   else
      2r> ['] (>number-base) (>number-sign) if d>s -1 else 0 then
   then then ;
