: char- 1- ;
: char+ 1+ ;

32 constant bl

: space? ( c -- f ) bl <= ;
: nonspace? ( c -- f ) space? 0= ;
: printable? ( c -- f ) $20 $7f within ;

: c, ( x -- ) here c! here char+ to here ;

: fill ( c-addr u char -- ) -rot bounds ?do dup i c! loop drop ;
: blank ( addr u -- ) bl fill ;
: erase ( addr u -- ) 0 fill ;
: erase, ( u -- ) here swap dup allot erase ;
: cmove, ( c-addr u -- ) here swap dup allot cmove ;
