: execute-parsing-file ( fileid xt -- )
   save-input n>r swap tib-source execute nr> restore-input ;

: (include-file) ( fileid -- ) ['] interpret execute-parsing-file ;

: include-file ( fileid -- )
   >r r@ ['] (include-file) catch \ Close fileid in event of exceptions.
   ?dup if
      \ Ignore possible CLOSE-FILE exception since another
      \ exception is already being processed.
      r> close-file drop throw
   else
      r> close-file throw
   then ;

: included ( c-addr u -- ) r/o open-file throw include-file ;

: include ( "<spaces>name<space>" -- c-addr u ) parse-name included ;
