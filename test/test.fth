decimal

                      36 constant max-base
            cell 8 * 2 * constant #bits-ud
0 invert                 constant max-uint
0 invert 1 rshift        constant max-int
0 invert 1 rshift invert constant min-int
0 invert 1 rshift        constant mid-uint
0 invert 1 rshift invert constant mid-uint+1

include test/tester.fth

include test/test-stack.fth
include test/test-integer.fth
include test/test-double.fth
include test/test-numeric.fth
include test/test-picture.fth
include test/test-string.fth
include test/test-create.fth
include test/test-flow.fth
include test/test-evaluate.fth
include test/test-exception.fth
include test/test-search.fth
include test/test-source.fth
include test/test-parse.fth

suite summary
   T{ #tests -> 460 }T
end-suite

: plurals ( n c-addr u -- ) 2 pick . type 1 <> if ." s" then ;

: summary ( -- )
   ." Checked "
    #tests s" test"  plurals ."  with "
   #errors s" error" plurals ." ." cr
   #errors 0= if bye else exit-failure bye! then ;

summary
