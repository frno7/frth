\ FIXME The REFILL word is possibly the most complex word in the kernel and
\ could be split up. The buffer is a considerably more efficient than character
\ for character handling.

: accept ( c-addr +n1 -- +n2 ) source-id read-file throw ;

: refill? ( -- f ) source nip >in @ = ;

: (refill) ( u -- f )
   tib tib# source-buffer 2!
   dup source-buffer 2@ rot /string ( u c-addr u )
   accept + source-buffer cell+ @
   swap source-buffer 2! ( u -- ) \ FIXME ACCEPT until CR or 0.
   0 source-buffer 2@ 10 index
   dup tib# = if 1 throw then
   1+ source-buffer @ min
   (source) 2! ;

\ | .............. | ..................(CR) | ..(CR...).. |
\ ^source-buffer@  ^+source@ ^+source@+>in  ^+source@+@   ^source-buffer@+@
: refill ( -- f )
   (source) 2@ dup /string (source) 2! \ Skip passed source.
   source-buffer 2@ (source) cell+ @ /string ( c-addr u ) \ Remaining after source.
   2dup 10 index ( c-addr u u ) \ Offset to following CR, if it exists.
   2dup = if ( c-addr u u ) \ CR was not found so remain might be partial.
      source-id -1 = if
         (source) cell+ @ swap
         (source) 2!
         2drop
      else
         drop tuck source-buffer cell+ @ swap ( u c-addr c-addr u )
         cmove ( u ) \ Move remaining to start.
         (refill)
      then
   else ( c-addr u u ) \ CR was found so update source.
      1+ source-buffer @ min
      (source) cell+ @ swap
      (source) 2!
      2drop
   then 0 >in ! (source) @ 0<> ;
