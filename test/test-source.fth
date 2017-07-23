suite source
\  : gs1 s" source" 2dup evaluate >r swap >r = r> r> = ;

\  T{ gs1 -> true true }T FIXME

   : gs4 source >in ! drop ;

   T{ gs4 123 456
       -> }T
end-suite

suite >in
   variable scans
   : rescan? -1 scans +! scans @ if 0 >in ! then ;

   T{ 2 scans !
   345 rescan?
   -> 345 345 }T

   : gs2 5 scans ! s" 123 rescan?" evaluate ;

   T{ gs2 -> 123 123 123 123 123 }T

   \ These tests must start on a new line FIXME
\ T{ 123456 depth over 9 < 35 and + 3 + >in !
\    -> 123456 23456 3456 456 56 6 }T
\ T{ 14145 8115 ?dup 0= 34 and >in +! tuck mod 14 >in ! gcd calculation
\    -> 15 }T
end-suite
