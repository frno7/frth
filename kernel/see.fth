: see ( "<spaces>name" -- )
   parse-name
   2dup found ?dup
   if
      -rot type
      dup    immediate? if    ."  immediate" then
      dup       inline? if       ."  inline" then
      dup compile-only? if ."  compile-only" then
      cr dup >code swap code# dump
   else
      type ." : undefined" cr
   then ;
