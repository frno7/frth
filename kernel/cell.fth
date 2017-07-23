: aligned ( a-addr -- a-addr )
   cell 1- + cell 1- invert and ; \ FIXME [ cell 1- literal ]

: , ( x -- ) here ! here cell+ to here ;

: move, ( x2 ... xu u -- ) 0 ?do , loop ;
