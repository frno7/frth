\ Decode relocation list from 16 bit LSB words of offsets. The 0 value
\ terminates the list. The 1 value has a special meaning of adding $FFFE
\ to the offset and is used to handle offsets greater than 16 bits.

: relocation-word@ ( addr -- u )
   dup c@ swap 1+ c@ 8 lshift or ;

: relocate! ( addr -- )
   basis swap +! ;

: relocate ( -- )
   text> over >r +
   begin dup relocation-word@ ?dup
   while
      dup 1 = if
         drop $fffe +
      else
         r> + dup >r relocate! 2 + \ Relocate and go to next word.
      then
   repeat drop rdrop ;

relocate
