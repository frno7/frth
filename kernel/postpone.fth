: postpone ( "<spaces>name" -- )
   parse-name ?found dup immediate? if
      compile,
   else
      t:>address t:address-literal, postpone compile,
   then ; immediate compile-only
