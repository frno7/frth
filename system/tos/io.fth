0 value stdin
1 value stdout
2 value stderr

0 constant r/o
1 constant w/o
2 constant r/w

 stdin value  infile-id
stdout value outfile-id

0 value errno

: read-file  ( a-addr u fd -- n ior ) sys-fread  dup 0< ;
: write-file ( a-addr u fd -- ior )   sys-fwrite     0< ; \ FIXME Repeat as necessary.

: open-file   ( c-addr u fam -- fileid ior )
   >r tuck cmove, 0 c,
   dup here swap - 1- r> swap sys-fopen
   >r 1+ negate allot r> dup 0< if dup else 0 then ;

: create-file ( c-addr u fam -- fileid ior ) 3drop -1 false ; \ FIXME
: close-file  ( fd -- ior ) sys-fclose ;
: delete-file ( c-addr u -- ior ) \ FIXME
   dup >r cmove, 0 c, here r@ - 1- sys-fdelete r> 1+ negate allot ;

: tx! ( c -- f ) sys-cconout true ;
: ?rx ( -- c f ) sys-cconin true ;

0 value exit-success
1 value exit-failure

: bye  ( -- )   exit-success sys-pterm ; \ --
: bye! ( n -- )              sys-pterm ; \ status --

: cr ( -- ) 10 tx! 13 tx! 2drop ;
