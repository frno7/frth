\ Forth 2012 reference implementation of CASE words.
\ https://forth-standard.org/standard/rationale

0 constant case immediate   ( Set OF counter to zero. )

: of ( #of -- orig #of+1 / x -- )
   1+                       ( Incrememt OF counter. )
   >r                       ( Move off the stack in case the control-flow. )
                            ( Stack is the data stack. )
   postpone over postpone = ( Copy and test case value. )
   postpone if              ( Add orig to control flow stack. )
   postpone drop            ( Discards case value if =. )
   r>                       ( We can bring count back now. )
   ; immediate compile-only

: endof ( orig1 #of -- orig2 #of )
   >r                       ( Move off the stack in case the control-flow. )
                            ( Stack is the data stack. )
   postpone else
   r>                       ( We can bring count back now. )
   ; immediate compile-only

: endcase ( orig1 ... orign #of -- )
   postpone drop            ( Discard case value. )
   0 ?do postpone then loop
   ; immediate compile-only
