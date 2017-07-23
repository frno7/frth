\ FIXME ?:

: 2! ( d a-addr -- ) swap over ! cell+ ! ; inline
: 2@ ( a-addr -- d )  dup cell+ @ swap @ ; inline

: 1= ( n -- f ) 1 = ; inline
: 2* ( n -- n ) dup + ; inline
: min ( n n -- n ) 2dup < if drop else nip then ;
: max ( n n -- n ) 2dup > if drop else nip then ;

: within ( u1 u2 u3 -- f ) over - >r - r> u< ; \ u2 <= u1 < u3
: bounds ( addr u -- addr+u addr ) over + swap ; inline

include kernel/image.fth \ FIXME Proper place?
include kernel/relocate.fth \ FIXME Proper place?
