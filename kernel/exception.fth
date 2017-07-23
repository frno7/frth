\ Forth 2012 standard CATCH THROW words.
\ https://forth-standard.org/standard/exception

\ FIXME Restore HERE, word lists, vocabularies, etc?

variable catch-state 0 catch-state ! \ Last exception catch state.

: catch ( xt -- exception# | 0 )     \ Return addr on stack.
   sp@ >r               ( xt )       \ Save data stack pointer.
   catch-state @ >r     ( xt )       \ And previous catch state.
   rp@ catch-state !    ( xt )       \ Set current catch state.
   execute              (    )       \ Execute returns if no throw.
   r> catch-state !     (    )       \ Restore previous catch state.
   rdrop                (    )       \ Discard saved stack pointer.
   0 ;                  (  0 )       \ Normal completion.

: throw ( ??? exception# -- ??? exception# )
   ?dup if              ( exc# )     \ 0 throw is no operation.
      catch-state @ rp! ( exc# )     \ Restore previous return stack.
      r> catch-state !  ( exc# )     \ Restore previous catch state.
      r> swap >r        ( saved-sp ) \ exc# on return stack.
      sp! drop r>       ( exc# )     \ Restore stack.
   then ;                            \ Return to the caller of catch because
                                     \ return stack is restored to the state
                                     \ that existed when catch began execution.

: abort ( i * x -- ) ( R: j * x -- )
   -1 throw ; compile-only

\   1   line too long
\  -1   ABORT
\  -2   ABORT"
\  -3   stack overflow
\  -4   stack underflow
\  -5   return stack overflow
\  -6   return stack underflow
\  -7   do-loops nested too deeply during execution
\  -8   dictionary overflow
\  -9   invalid memory address
\ -10   division by zero
\ -11   result out of range
\ -12   argument type mismatch
\ -13   undefined word
\ -14   interpreting a compile-only word
\ -15   invalid FORGET
\ -16   attempt to use zero-length string as a name
\ -17   pictured numeric output string overflow
\ -18   parsed string overflow
\ -19   definition name too long
\ -20   write to a read-only location
\ -21   unsupported operation (e.g., AT-XY on a too-dumb terminal)
\ -22   control structure mismatch
\ -23   address alignment exception
\ -24   invalid numeric argument
\ -25   return stack imbalance
\ -26   loop parameters unavailable
\ -27   invalid recursion
\ -28   user interrupt
\ -29   compiler nesting
\ -30   obsolescent feature
\ -31   >BODY used on non-CREATEd definition
\ -32   invalid name argument (e.g., TO name)
\ -33   block read exception
\ -34   block write exception
\ -35   invalid block number
\ -36   invalid file position
\ -37   file I/O exception
\ -38   non-existent file
\ -39   unexpected end of file
\ -40   invalid BASE for floating point conversion
\ -41   loss of precision
\ -42   floating-point divide by zero
\ -43   floating-point result out of range
\ -44   floating-point stack overflow
\ -45   floating-point stack underflow
\ -46   floating-point invalid argument
\ -47   compilation word list deleted
\ -48   invalid POSTPONE
\ -49   search-order overflow
\ -50   search-order underflow
\ -51   compilation word list changed
\ -52   control-flow stack overflow
\ -53   exception stack overflow
\ -54   floating-point underflow
\ -55   floating-point unidentified fault
\ -56   QUIT
\ -57   exception in sending or receiving a character
\ -58   [IF], [ELSE], or [THEN] exception
\ -59   ALLOCATE
\ -60   FREE
\ -61   RESIZE
\ -62   CLOSE-FILE
\ -63   CREATE-FILE
\ -64   DELETE-FILE
\ -65   FILE-POSITION
\ -66   FILE-SIZE
\ -67   FILE-STATUS
\ -68   FLUSH-FILE
\ -69   OPEN-FILE
\ -70   READ-FILE
\ -71   READ-LINE
\ -72   RENAME-FILE
\ -73   REPOSITION-FILE
\ -74   RESIZE-FILE
\ -75   WRITE-FILE
\ -76   WRITE-LINE
\ -77   Malformed xchar
\ -78   SUBSTITUTE
\ -79   REPLACES
