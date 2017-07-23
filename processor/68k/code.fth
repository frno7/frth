variable code:depth

: code ( "name" -- )
   prologue, base @
   parse-name ?redefined create-name, 0 c, 0 c, create-link,
   depth code:depth ! hex ;

: end-code ( x1 ... xn -- )
   depth code:depth @ -
   dup allot 0 ?do here 1- i - c! loop
   $4e c, $75 c, \ rts
   latest code#! latest inline! base ! epilogue, ;
