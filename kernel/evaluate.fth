: evaluate ( c-addr u -- )
   save-source n>r
   string-source interpret
   nr> restore-source ;
