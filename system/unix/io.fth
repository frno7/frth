0 value stdin
1 value stdout
2 value stderr

0 constant r/o
1 constant w/o
2 constant r/w

 stdin value  infile-id
stdout value outfile-id

0 value errno

: (errno) ( n exc# -- n ) over 0< if swap to errno throw then drop 0 to errno 0 ;

: read-file  ( a-addr u fd -- ior ) swup sys-read  dup 0< ;
: write-file ( a-addr u fd -- ior ) swup sys-write     0< ; \ FIXME Repeat as necessary.

: open-file   ( a-addr u fam -- fileid ior )
   >r tuck cmove, 0 c,
   dup here swap - 1- r> %110110110 swap rot sys-open \ FIXME Simplify this.
   >r 1+ negate allot r> -69 (errno) ;

: create-file ( c-addr u fam -- fileid ior ) %1001000000 or open-file ;
: close-file  ( fd -- ior ) sys-close ;
: delete-file ( c-addr u -- ior )
   dup >r cmove, 0 c, here r@ - 1- sys-unlink r> 1+ negate allot ;

\ FIXME Restart EAGAIN for signals and buffer with select.
: tx! ( c -- f )   sp@ cell+ 1 outfile-id write-file nip 0 = ;
: ?rx ( -- c f ) 0 sp@ cell+ 1 infile-id  read-file  0 = swap 1 = and ;

0 value exit-success
1 value exit-failure

: bye  ( -- )   exit-success sys-exit ; \ --
: bye! ( n -- )              sys-exit ; \ status --

: cr ( -- ) 10 tx! drop ;
