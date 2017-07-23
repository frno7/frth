\ Common error words.

: error-undefined-word ( c-addr u -- ) \ FIXME source file, line, column
   type ." : Undefined word." cr -13 throw ;
