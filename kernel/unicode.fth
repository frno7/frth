: (utf-8>utf-32) ( c-addr u c u u -- c-addr u 0 | c-addr u u -1 )
   dup 4 pick < if ( Check length is enough. )
      -rot and ( Apply mask on first character. ) ( c-addr u u c )
      2>r 1/string 2r> ( Remove first character from string. )
      swap 0 ?do ( c-addr u c )
	 6 lshift ( Every following character represents 6 additional bits. )
	 2 pick c@ ( c-addr u c c )
	 dup %10000000 %11000000 within if
	    %00111111 and or >r 1/string r>
	 else ( Invalid code so undo adjusted string and indicate failure. )
	    2drop i negate /string false unloop exit
	 then
      loop true ( UTF-8 code is proper so indicate success. )
   else ( String to short. ) 3drop false then ;

\ FIXME Give double to conform with 16 bit Forths?
: utf-8>utf-32 ( c-addr u -- c-addr u 0 | c-addr u u -1 )
   dup if over c@
      dup %01111111 <= if %01111111 0 else
      dup %11011111 <= if %00011111 1 else
      dup %11101111 <= if %00001111 2 else
      dup %11110111 <= if %00000111 3 else drop false exit ( Invalid code. )
   then then then then (utf-8>utf-32) exit then false ( Empty string. ) ;
