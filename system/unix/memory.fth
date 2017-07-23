0 sys-brk to here \ FIXME Use mmap instead?
here value break

: unused ( -- u ) break here - ;

4096 constant margin

\ Reserve u items of dataspace.
: reserve ( u -- ) here + sys-brk to break ; \ FIXME Throw exception on allot failure.

\ Gives true if there is enough dataspace to allot n items with margin.
: reserve? ( u -- ) unused - margin > ;
: allot ( n -- )
   dup reserve? if dup margin + margin + reserve then here + to here ;

$100000 reserve \ FIXME Test low memory conditions.

: align ( -- ) here aligned here - allot ;
