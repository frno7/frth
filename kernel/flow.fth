\ Table A.1: Compilation behavior of control-flow words at compile-time,

\    word: supplies: resolves: is used to:
\      IF      orig            mark origin of forward conditional branch
\    THEN                orig  resolve IF or AHEAD
\   BEGIN      dest            mark backward destination
\   AGAIN                dest  resolve with backward unconditional branch
\   UNTIL                dest  resolve with backward conditional branch
\   AHEAD      orig            mark origin of forward unconditional branch
\ CS-PICK                      copy item on control-flow stack
\ CS-ROLL                      reorder items on control-flow stack

: if    if,    ; immediate compile-only
: ahead ahead, ; immediate compile-only
: then  then,  ; immediate compile-only
: until until, ; immediate compile-only
: again again, ; immediate compile-only
: leave leave, ; immediate compile-only

: begin ( C: -- orig )
   here
   ; immediate compile-only

: else ( C: orig -- C: orig )
   postpone ahead
   1 cs-roll
   postpone then
   ; immediate compile-only

: while ( f -- ) ( C: dest -- orig dest )
   postpone if
   1 cs-roll
   ; immediate compile-only

: repeat ( -- ) ( C: orig dest -- )
   postpone again
   postpone then
   ; immediate compile-only

: do ( n1 n2 -- ) ( R: -- loop-sys )
   0 >leave \ Zero marks end of linked list to be resolved for LEAVE.
   postpone 2>r
   postpone (do)
   postpone begin 0 \ Zero means LOOP will not resolve a THEN.
   ; immediate compile-only

: ?do ( n1 n2 -- ) ( R: -- loop-sys )
   0 >leave \ Zero marks end of linked list to be resolved for LEAVE.
   postpone 2dup
   postpone 2>r
   postpone <>
   postpone if \ LOOP will resolve this with a THEN.
   postpone (do)
   postpone begin 1 \ One means LOOP needs to resolve a THEN.
   ; immediate compile-only

: unloop ( R: loop-sys -- )
   postpone 2rdrop \ Drop loop variable I from return stack.
   ; immediate compile-only

: +loop ( n -- ) ( R: loop-sys -- | loop-sys )
   >r
   postpone (+loop)
   postpone until
   r> 0 ?do postpone then loop \ Resolve possible IF by ?DO.
   leave> (leave) \ Resolve LEAVE.
   postpone unloop
   ; immediate compile-only

: loop ( R: loop-sys -- | loop-sys )
   1 literal, \ Loop increment. FIXME Optimise this
   postpone +loop
   ; immediate compile-only
