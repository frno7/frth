\ A dictionary is a linked list of words. Padding is added as needed preceding
\ the name for the link and body fields to be aligned. The link offset at the
\ end of the list is zero. The offset is the positive number of chars to the
\ previous entry. The main reason to store an offset instead of a pointer is
\ that it does not need to be address relocated.
\                                                         ^
\                                                         |
\ +---- - - +---- - - +--------+------------+--------+----+-----+---- - -
\ | Padding | Name    | Name   | Body size  | Flags  | Link     | Code or
\ |         |         | length | or zero    |        | offset   | body
\ +---- - - +---- - - +(1 byte)+--(1 byte)--+(1 byte)+--(cell)--+---- - -
\                                                         ^
\                                                         |
\                                                       LATEST
\
\ A code size of zero means either that the size is unknown or larger than
\ 255 bytes. The code size is primarily used for inlining machine code and
\ this is only done for small pieces of code anyway.
\
\ By putting the name before the link offset one can avoid having to deal
\ with the name name length when accessing the code or body which can be found
\ at a fixed offset directly after the link. The name is truncated to a maximum
\ of 255 chararacters.

: >name ( nt -- c-addr u ) 3 - dup c@ dup >r - r> ;
: name= ( c-addr u nt -- f ) >name s== ;
: name# ( nt -- u ) 3 - c@ ;
: code# ( nt -- u ) 2 - c@ ;
: flags ( nt -- u ) 1 - c@ ;
: >code ( nt -- a-addr ) t:cell+ ;
: >body ( nt -- a-addr ) dup >code swap code# t:aligned + ;
: flags! ( u nt -- ) 1 - c! ;
: code#! ( nt -- ) dup here swap >code - 256 min swap 2 - c! ;

%00000001 constant    immediate-flag
%00000010 constant       inline-flag
%00000100 constant compile-only-flag

: immediate? ( nt -- f ) flags immediate-flag and 0<> ;
: immediate! ( nt -- f ) dup flags immediate-flag or swap flags! ;

: inline? ( nt -- f ) flags inline-flag and 0<> ;
: inline! ( nt -- f ) dup flags inline-flag or swap flags! ;
: !inline ( nt -- f ) dup flags inline-flag invert and swap flags! ;

: compile-only? ( nt -- f ) flags compile-only-flag and 0<> ;
: compile-only! ( nt -- f ) dup flags compile-only-flag or swap flags! ;

: create-align ( u -- u ) 3 + here + dup t:aligned swap - erase, ;
: create-name, ( c-addr u -- ) 255 min dup >r dup create-align cmove, r> c, ;
: create-link, ( -- ) here get-current @ dup if nup - then t:, get-current ! ;
