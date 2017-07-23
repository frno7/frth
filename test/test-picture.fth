\ FIXME https://forth-standard.org/standard/core/numS

suite pictured numeric
   : test-hold <# 65 hold 66 hold 0 0 #> s" BA" s= ;
   : test-sign <# 'A' hold -1 sign
                  'B' hold  0 sign
                  'C' hold -1 sign
                  'D' hold 0 0 #> s" D-CB-A" s= ;
   : test-#    <# 1 0 # # #> s" 01" s= ;
   : test-#s-1 <# 1 0 #s #> s" 1" s= ;
   : test-#s-2
      base @ true
      max-base 1+ 2 ?do
        i base !
          i 0 <# #s #> s" 10" s= and
      loop
      swap base ! ;
   : test-#s-3
      base @ >r 2 base !
      max-uint max-uint <# #s #>
      r> base !
      dup #bits-ud = swap
      0 ?do
        over c@ [char] 1 = and
        >r char+ r>
      loop swap drop ;
   : test-#s-4
      base @ >r max-base base !
      true
      10 0 ?do
        i 0 <# #s #>
        1 = swap c@ i '0' + = and and
      loop
      max-base 10 ?do
        i 0 <# #s #>
        1 = swap c@ 'A' i 10 - + = and and
      loop
      r> base ! ;
   : test-#s-5 <#  123 s>d #s #>  s" 123" s= ;
   : test-#s-6 <# -123 dup abs 0 #s rot sign #> s" -123" s= ;

   T{ test-hold -> true }T
   T{ test-sign -> true }T
   T{ test-#    -> true }T
   T{ test-#s-1 -> true }T
   T{ test-#s-2 -> true }T
   T{ test-#s-3 -> true }T
   T{ test-#s-4 -> true }T
   T{ test-#s-5 -> true }T
   T{ test-#s-6 -> true }T
end-suite
