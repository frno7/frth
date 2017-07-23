 sys-input value stdin
sys-output value stdout

1005 constant r/o
1006 constant w/o
1004 constant r/w

 stdin value  infile-id
stdout value outfile-id

: errno ( -- n ) sys-io-err ;

: read-file  ( a-addr u fd -- n ior ) swup  sys-read dup 0< ;
: write-file ( a-addr u fd -- ior )   swup sys-write     0< ; \ FIXME Repeat as necessary.

: open-file   ( c-addr u fam -- fileid ior )
   >r tuck cmove, 0 c,
   dup here swap - 1- r> swap sys-open
   >r 1+ negate allot r> dup 0< if dup else 0 then ;

: create-file ( c-addr u fam -- fileid ior ) 3drop -1 false ; \ FIXME
: close-file  ( fd -- ior ) sys-close ;

: tx! ( c -- f )   sp@ cell+ 3 + 1 outfile-id write-file nip 0 = ;
: ?rx ( -- c f ) 0 sp@ cell+ 3 + 1  infile-id  read-file 0 = swap 1 = and ;

0 value exit-success
1 value exit-failure

: bye  ( -- )   exit-success sys-exit ; \ --
: bye! ( n -- )              sys-exit ; \ status --

: cr ( -- ) 10 tx! drop ;
