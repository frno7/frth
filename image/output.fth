: save-target-image ( addr u -- )
   2>r
   \ FIXME ((commands)) \ Commands pass 2.
   cmd:output 2@ w/o create-file throw
   dup 2r> rot write-file throw
   close-file throw ; \ FIXME Catch, close and delete file on exceptions.

: error-missing-target
   ." frth: Output option requires target option." cr exit-failure bye! ;

: target-image-filepath
   cmd:target 2@ or 0= if error-missing-target then
   here >r
      s" target/" r@  place
    cmd:target 2@ r@ +place
   s" /image.fth" r@ +place
   r@ c@ 1+ allot
   r> count ;

include image/image0.fth

target-image-filepath included

include image/image3.fth

save-target-image

bye
