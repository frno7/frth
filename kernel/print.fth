: ?key ( -- c f ) ?rx ;
: emit ( c -- ) tx! drop ;
: type ( c-addr u -- ) outfile-id write-file throw ;

: space ( -- ) bl emit ;
: spaces ( n -- ) 0 ?do space loop ;
