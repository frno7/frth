: . ( n -- ) <# dup abs 0 #s rot sign #> type space ; \ FIXME MIN-INT?

: u. ( u -- ) <# 0 #s #> type space ;

: dec. ( n -- ) ['] . 10 base-execute ;
: hex. ( u -- ) '$' emit ['] u. 16 base-execute ;

: .s ( -- )
   <# '>' hold depth dup abs 0 #s rot sign '<' hold #> type space
   depth dup 0 ?do dup i - pick . loop drop ;

: ascii-line ( addr u -- )
   space space bounds ?do
      i c@ dup printable? if emit else drop '.' emit then
   loop ;

: address-line ( addr -- )
   base @ hex swap <# s>d # # # # # # # # #> type space base ! ;

: bin-dump ( addr u -- )
   base @ -rot binary
   dup 0 ?do
      i 6 mod 0= if over i + address-line then
      space <# over i + c@ s>d # # # # # # # # #> type
      i 6 mod 5 = if
         over i + 5 - 6 ascii-line cr
      then
   loop
   6 over 6 mod - 6 mod 9 * spaces
   2dup dup dup 6 mod - /string dup if ascii-line cr else 2drop then
   2drop base ! ;

: hex-dump ( addr u -- )
   base @ -rot hex
   dup 0 ?do
      i 16 mod 0= if
         <# over i + s>d # # # # # # # # #> type space
      then
      space <# over i + c@ s>d # # #> type
      i 16 mod 15 = if
         over i + 15 - 16 ascii-line cr
      then
   loop
   16 over 16 mod - 16 mod 3 * spaces
   2dup dup dup 16 mod - /string dup if ascii-line cr else 2drop then
   2drop base ! ;

: dump ( addr u -- ) hex-dump ;

\ FIXME Configurable address length for 16, 32 and 64 bit systems.
\ FIXME Configurable columns.
\ FIXME Handle address faults.
