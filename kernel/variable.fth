: variable ( "<spaces>name" -- )
   prologue, parse-name (variable) 0 t:,       epilogue, ;

: 2variable ( "<spaces>name" -- )
   prologue, parse-name (variable) 0 t:, 0 t:, epilogue, ;
