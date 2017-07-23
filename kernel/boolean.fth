 0 constant false
-1 constant true

: off!  ( a-addr -- ) false swap ! ;
: on!   ( a-addr -- ) true  swap ! ;

: off? ( a-addr -- ) @  0= ;
: on?  ( a-addr -- ) @ 0<> ;
