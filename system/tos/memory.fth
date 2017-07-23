: unused ( -- u ) break here - ;

: allot ( n -- ) here + to here ; \ FIXME Exception on overflow.

: align ( -- ) here aligned here - allot ;
