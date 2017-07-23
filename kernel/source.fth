256 constant tib# \ Character capacity of TIB.
0 value tib
here to tib tib# allot

variable #tib \ Number of characters in the terminal input buffer.

0 value source-id \ 0 means user input device and -1 string via EVALUATE.
2variable source-buffer \ FIXME Split into separate variables or values?
2variable (source)      \ FIXME Split into separate variables or values?
: source ( -- c-addr u )
   source-buffer cell+ @ (source) 2@ -rot + swap
   dup if 2dup + 1- c@ 10 = if 1- then then ; \ Trim trailing CR from source.

\ Offset in characters from the start of the input buffer to the start of the
\ parse area relative to the SOURCE address.
variable >in

: string-source ( c-addr u -- ) \ Assign string source to source buffer.
   -1 to source-id
   source-buffer 2!
   0 0 (source) 2!
   0 >in ! ;

: tib-source ( fileid -- ) \ Assign terminal input source to source buffer.
   to source-id
   tib #tib @ source-buffer 2!
   0 0 (source) 2!
   0 >in ! ;

: save-source ( -- x1 ... x6 6 )
   source-buffer 2@
   (source) 2@
   >in @
   source-id 6 ;

: restore-source ( x1 ... x6 6 -- )
   drop
   to source-id
   >in !
   (source) 2!
   source-buffer 2! ;

: save-input ( -- x1 ... xn n )
   source-buffer 2@ bounds ?do i c@ loop
   save-source dup source-buffer @ + 1+ ;

: restore-input ( x1 ... xn n -- )
   drop restore-source
   source-buffer 2@
   swap over + swap 0 ?do 1 - >r r@ c! r> loop
   drop ;

stdin tib-source
