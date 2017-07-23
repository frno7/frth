1000 value relocation-list# \ Maximum number of relocatable addresses.

0 value relocation-list \ Ordered list of addresses to be relocated.
align here to relocation-list
relocation-list# cells allot

0 value #relocation-list \ Number of addresses in relocation list.

\ Store address to be relocated. The addresses can be given out-of-order as
\ they will be sorted by the function.
: t:relocate ( addr -- )
   #relocation-list 1+ to #relocation-list
   relocation-list# #relocation-list <= if -52 throw then \ FIXME Better code?
   relocation-list #relocation-list 1- cells + !
   #relocation-list 2 -
   begin dup 0 >= \ Maintain address ordering by insertion sort.
   while dup cells relocation-list + 2@ u<
   while dup cells relocation-list + dup 2@ swap rot 2! 1-
   repeat then drop ;

\ Encode relocation list as 16 bit LSB words of offsets. The 0 value
\ terminates the list. The 1 value has a special meaning of adding $FFFE
\ to the offset and is used to handle offsets greater than 16 bits.

: relocation-word, ( u -- ) dup c, 8 rshift c, ;

: relocation-code, ( n -- )
   begin dup $ffff u>
   while 1 relocation-word, $fffe -
   repeat relocation-word, ;

: relocate, ( -- )
   #relocation-list 0 ?do
      relocation-list i cells + @ dup >r swap - relocation-code, r>
   loop drop 0 relocation-word, ;
