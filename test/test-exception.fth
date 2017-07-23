suite exception
    -1 constant exc_abort
    -2 constant exc_abort"
   -13 constant exc_undef

   : t6 abort ;
   : t10 77 swap abort" This should not be displayed." ;
   : c6 catch
      case exc_abort  of 11 endof
           exc_abort" of 12 endof
           exc_undef  of 13 endof
      endcase ;

   T{ 1 2 '  t6 c6 ->  1 2 11 }T    \ Test that ABORT is caught.
   T{ 3 0 ' t10 c6 ->    3 77 }T    \ ABORT" does nothing.
   T{ 4 5 ' t10 c6 -> 4 77 12 }T    \ ABORT" caught, no message.

\  : t7 s" 333 $$undefedword$$ 334" evaluate 335 ;
\  : t8 s" 222 t7 223" evaluate 224 ;
\  : t9 s" 111 112 t8 113" evaluate 114 ;

\  t{ 6 7 ' t9 c6 3 -> 6 7 13 3 }t \ FIXME

   : t1 9 ;
   : c1 1 2 3 ['] t1 catch ;

   T{ c1 -> 1 2 3 9 0 }T               \ No THROW executed.

   : t2 8 0 throw ;
   : c2 1 2 ['] t2 catch ;

   T{ c2 -> 1 2 8 0 }T                 \ 0 THROW does nothing.

   : t3 7 8 9 99 throw ;
   : c3 1 2 ['] t3 catch ;

   T{ c3 -> 1 2 99 }T                  \ Restores stack to CATCH depth.

   : t4 1- dup 0> if recurse else 999 throw -222 then ;
   : c4 3 4 5 10 ['] t4 catch -111 ;

   T{ c4 -> 3 4 5 0 999 -111 }T        \ Test return stack unwinding.

   : t5 2drop 2drop 9999 throw ;
   : c5 1 2 3 4 ['] t5 catch           \ Test depth restored correctly
      depth >r drop 2drop 2drop r> ;   \ after stack has been emptied.

   T{ c5 -> 5 3 + }T
end-suite
