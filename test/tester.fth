\ FIXME test vocabulary
\ FIXME Further stack checks using ?stack

base @ decimal

    0 value #errors
    0 value #tests

    0 value test-depth
false value test-failed

: error
   test-failed invert if
      type cr source 1- 0 max type
      true to test-failed
   else 2drop then ;

\ A stack guard is used to check the integrity of the data stack. For example,
\ T{ 1 2 swap 2 1 }T tests as { $8badf00d 1 2 swap $8badf00d 2 1 }.

: guard
   rp@         \ Return stack pointer sentinel not to be unbalanced.
   here        \ HERE sentinel not to be modified by test.
   $8badf00d ; \ Data stack sentinel not to be overwritten by test.

: T{ \ FIXME Catch undefined.
   #tests 1+ to #tests
   false to test-failed
   guard ;

: ->
   depth 0 < if
      s" Stack underflow: " error cr exit-failure bye! \ Unrecoverable error.
   then
   depth to test-depth guard ;

variable actual
variable expected
: }T
   depth test-depth 2* <> if
      s" Wrong number of results: " error cr
   then
   test-depth 0 ?do
      expected ! expected @ test-depth pick actual ! actual @ <> if
         s" Incorrect result: " error cr
	 ." actual " actual @ .
	 ." expected " expected @ . cr
      then
   loop
   test-failed if #errors 1+ to #errors then
   clearstack ;

: suite ( "ccc<eol>" -- )
   cmd:verbose @ 0> if
      ."     Suite: " 10 parse type cr
   else
      10 parse 2drop
   then ;
: end-suite ( -- ) ; \ FIXME Display test time

base !
