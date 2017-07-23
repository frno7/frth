suite stack
   T{            3  drop ->               }T
   T{          5 7  swap ->          7  5 }T
   T{          5 7  tuck ->       7  5  7 }T
   T{          1 2  over ->       1  2  1 }T
   T{          5 7   nip ->             7 }T
   T{       1  2 3   rot ->       2  3  1 }T
   T{       1  2 3  -rot ->       3  1  2 }T
   T{     1 2  3 4 2swap ->     3 4  1  2 }T
   T{ 2 3 5 7 11 0  pick -> 2 3 5 7 11 11 }T
   T{ 2 3 5 7 11 1  pick -> 2 3 5 7 11  7 }T
   T{ 2 3 5 7 11 2  pick -> 2 3 5 7 11  5 }T
   T{ 2 3 5 7 11 3  pick -> 2 3 5 7 11  3 }T
   T{ 2 3 5 7 11 4  pick -> 2 3 5 7 11  2 }T
   T{         11 0  roll ->            11 }T
   T{       7 11 1  roll ->         11  7 }T
   T{     5 7 11 2  roll ->       7 11  5 }T
   T{   3 5 7 11 3  roll ->     5 7 11  3 }T
   T{ 2 3 5 7 11 4  roll ->   3 5 7 11  2 }T
end-suite

suite stack (extended)
   T{          5 7   nup ->       5  5  7 }T
   T{       1  2 3  swup ->       2  1  3 }T
   T{          2 3 2drop ->               }T
   T{       1  2 3 3drop ->               }T
end-suite

suite return stack
   : test-rstack-01   2  >r        7   5 3     r> ;
   : test-rstack-02   1   2  3 2>r 5  r> 7     r> ;
   : test-rstack-03 3 2 2>r 13  11 7  r@ 5    2r> ;
   : test-rstack-04 3 2 2>r 13  11 7 2r@ 5    2r> ;
   : test-rstack-05   1   2 >r   3 5  >r 7    2r> ;
   : test-rstack-06                2  >r 3  rdrop ;
   : test-rstack-07          1   2 3 2>r 3 2rdrop ;
   : test-rstack-08                    n>r 23 nr> ;

   T{ test-rstack-01 ->            7 5 3 2 }T
   T{ test-rstack-02 ->          1 5 3 7 2 }T
   T{ test-rstack-03 ->    13 11 7 2 5 3 2 }T
   T{ test-rstack-04 -> 13 11  7 3 2 5 3 2 }T
   T{ test-rstack-05 ->          1 3 7 2 5 }T
   T{ test-rstack-06 ->                  3 }T
   T{ test-rstack-07 ->                1 3 }T

   T{ 2 3 5 7 11 13 17 7 test-rstack-08 -> 23 2 3 5 7 11 13 17 7 }T
   T{   3 5 7 11 13 17 6 test-rstack-08 -> 23   3 5 7 11 13 17 6 }T
   T{     5 7 11 13 17 5 test-rstack-08 -> 23     5 7 11 13 17 5 }T
   T{       7 11 13 17 4 test-rstack-08 -> 23       7 11 13 17 4 }T
   T{         11 13 17 3 test-rstack-08 -> 23         11 13 17 3 }T
   T{            13 17 2 test-rstack-08 -> 23            13 17 2 }T
   T{               17 1 test-rstack-08 -> 23               17 1 }T
   T{                  0 test-rstack-08 -> 23                  0 }T
end-suite
