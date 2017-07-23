: t:, ( x -- ) , ;
: t:@ ( x a-addr -- ) @ ; inline
: t:! ( x a-addr -- ) ! ; inline
: t:cell+ ( x a-addr -- ) cell+ ; inline
: t:aligned ( addr -- addr ) aligned ;
: t:align ( addr -- ) align ;
: t:>address ( addr -- addr ) ; inline
: t:address> ( addr -- addr ) ; inline
: t:relocate ( addr -- ) drop ; inline

: prologue, ( -- ) ;
: epilogue, ( -- ) ;
