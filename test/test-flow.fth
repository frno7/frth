suite if
   : test-if-01 1 if 2 then ;
   : test-if-02 0 if 2 then ;
   : test-if-03 1 if   then ;
   : test-if-04 0 if   then ;
   : test-if-05 1 if   else 3 then ;
   : test-if-06 0 if   else 3 then ;
   : test-if-07 1 if 2 else   then ;
   : test-if-08 0 if 2 else   then ;
   : test-if-09 1 if 2 else 3 then ;
   : test-if-10 0 if 2 else 3 then ;
   : test-if-11 if 123 then ;
   : test-if-12 if 123 else 234 then ;
   : test-if-13 if 1 else 2 else 3 else 4 else 5 then ;

   T{    test-if-01 ->     2 }T
   T{    test-if-02 ->       }T
   T{    test-if-03 ->       }T
   T{    test-if-04 ->       }T
   T{    test-if-05 ->       }T
   T{    test-if-06 ->     3 }T
   T{    test-if-07 ->     2 }T
   T{    test-if-08 ->       }T
   T{    test-if-09 ->     2 }T
   T{    test-if-10 ->     3 }T
   T{  0 test-if-11 ->       }T
   T{  1 test-if-11 ->   123 }T
   T{ -1 test-if-11 ->   123 }T
   T{  0 test-if-12 ->   234 }T
   T{  1 test-if-12 ->   123 }T
   T{ -1 test-if-11 ->   123 }T
   T{  0 test-if-13 ->   2 4 }T
   T{ -1 test-if-13 -> 1 3 5 }T
end-suite

suite while
   : test-while-1 begin dup 5 < while dup 1+ repeat ;
   : test-while-2 begin dup 2 > while
	 dup 5 < while dup 1+ repeat
      123 else 345 then ;
   : test-while-3 ( n1 -- n2 )
      dup 2 < if drop 1 exit then
      dup begin dup 2 > while
	 1- swap over * swap
      repeat drop ;

   T{ 0 test-while-1 -> 0 1 2 3 4 5 }T
   T{ 4 test-while-1 ->         4 5 }T
   T{ 5 test-while-1 ->           5 }T
   T{ 6 test-while-1 ->           6 }T
   T{ 1 test-while-2 ->       1 345 }T
   T{ 2 test-while-2 ->       2 345 }T
   T{ 3 test-while-2 ->   3 4 5 123 }T
   T{ 4 test-while-2 ->     4 5 123 }T
   T{ 5 test-while-2 ->       5 123 }T
   T{ 1 test-while-3 ->           1 }T
   T{ 2 test-while-3 ->           2 }T
   T{ 3 test-while-3 ->           6 }T
   T{ 4 test-while-3 ->          24 }T
   T{ 5 test-while-3 ->         120 }T
end-suite

suite case
   : cs1 case
         1 of 111 endof
         2 of 222 endof
         3 of 333 endof
         >r 999 r>
      endcase ;

   T{ 1 cs1 -> 111 }T
   T{ 2 cs1 -> 222 }T
   T{ 3 cs1 -> 333 }T
   T{ 4 cs1 -> 999 }T

   : cs2 >r case
         -1 of case r@
               1 of 100 endof
               2 of 200 endof
               >r -300 r>
            endcase endof
         -2 of case r@
               1 of -99 endof
               >r -199 r>
            endcase endof
         >r 299 r>
      endcase r> drop ;

   T{ -1 1 cs2 ->  100 }T
   T{ -1 2 cs2 ->  200 }T
   T{ -1 3 cs2 -> -300 }T
   T{ -2 1 cs2 ->  -99 }T
   T{ -2 2 cs2 -> -199 }T
   T{  0 2 cs2 ->  299 }T
end-suite

suite do
   : gd0 do i loop ;

   T{          4        1 gd0 ->  1 2 3   }T
   T{          2       -1 gd0 -> -1 0 1   }T
   T{ mid-uint+1 mid-uint gd0 -> mid-uint }T

   : gd1 do i 1 +loop ;

   T{          4        1 gd1 ->  1 2 3   }T
   T{          2       -1 gd1 -> -1 0 1   }T
   T{ mid-uint+1 mid-uint gd1 -> mid-uint }T

   : gd2 do i -1 +loop ;

   T{        1          4 gd2 -> 4 3 2  1 }T
   T{       -1          2 gd2 -> 2 1 0 -1 }T
   T{ mid-uint mid-uint+1 gd2 -> mid-uint+1 mid-uint }T

   : gd5 123 swap 0 do i 4 > if drop 234 leave then loop ;

   T{ 1 gd5 -> 123 }T 
   T{ 5 gd5 -> 123 }T 
   T{ 6 gd5 -> 234 }T

   variable gditerations
   variable gdincrement

   : gd7 ( limit start increment -- )
      gdincrement !
      0 gditerations !
      do
        1 gditerations +!
        i
        gditerations @ 6 = if leave then
        gdincrement @
      +loop gditerations @
   ;

   T{    4  4  -1 gd7 ->  4                  1  }T
   T{    1  4  -1 gd7 ->  4  3  2  1         4  }T
   T{    4  1  -1 gd7 ->  1  0 -1 -2  -3  -4 6  }T
   T{    4  1   0 gd7 ->  1  1  1  1   1   1 6  }T
   T{    0  0   0 gd7 ->  0  0  0  0   0   0 6  }T
   T{    1  4   0 gd7 ->  4  4  4  4   4   4 6  }T
   T{    1  4   1 gd7 ->  4  5  6  7   8   9 6  }T
   T{    4  1   1 gd7 ->  1  2  3            3  }T
   T{    4  4   1 gd7 ->  4  5  6  7   8   9 6  }T
   T{    2 -1  -1 gd7 -> -1 -2 -3 -4  -5  -6 6  }T
   T{   -1  2  -1 gd7 ->  2  1  0 -1         4  }T
   T{    2 -1   0 gd7 -> -1 -1 -1 -1  -1  -1 6  }T
   T{   -1  2   0 gd7 ->  2  2  2  2   2   2 6  }T
   T{   -1  2   1 gd7 ->  2  3  4  5   6   7 6  }T
   T{    2 -1   1 gd7 -> -1 0 1              3  }T
   T{  -20 30 -10 gd7 -> 30 20 10  0 -10 -20 6  }T
   T{  -20 31 -10 gd7 -> 31 21 11  1  -9 -19 6  }T
   T{  -20 29 -10 gd7 -> 29 19  9 -1 -11     5  }T

   max-uint 8 rshift 1+ constant  ustep
           ustep negate constant -ustep
    max-int 7 rshift 1+ constant   step
            step negate constant  -step
                        variable   bump

   : gd8 bump ! do 1+ bump @ +loop ;

   T{ 0 max-uint 0      ustep gd8 -> 256 }T
   T{ 0 0 max-uint     -ustep gd8 -> 256 }T
   T{ 0 max-int min-int  step gd8 -> 256 }T
   T{ 0 min-int max-int -step gd8 -> 256 }T

   : qd ?do i loop ;

   T{   789   789 qd ->           }T
   T{ -9876 -9876 qd ->           }T
   T{     5     0 qd -> 0 1 2 3 4 }T

   : qd1 ?do i 10 +loop ;

   T{ 50 1 qd1 -> 1 11 21 31 41 }T
   T{ 50 0 qd1 -> 0 10 20 30 40 }T

   : qd2 ?do i 3 > if leave else i then loop ;

   T{ 5 -1 qd2 -> -1 0 1 2 3 }T

   : qd3 ?do i 1 +loop ;

   T{ 4  4 qd3 -> }T
   T{ 4  1 qd3 ->  1 2 3 }T
   T{ 2 -1 qd3 -> -1 0 1 }T

   : qd4 ?do i -1 +loop ;

   T{  4 4 qd4 -> }T
   T{  1 4 qd4 -> 4 3 2  1 }T
   T{ -1 2 qd4 -> 2 1 0 -1 }T

   : qd5 ?do i -10 +loop ;

   T{   1 50 qd5 -> 50 40 30 20 10   }T
   T{   0 50 qd5 -> 50 40 30 20 10 0 }T
   T{ -25 10 qd5 -> 10 0 -10 -20     }T

   : gd3 do 1 0 do j loop loop ;

   T{          4        1 gd3 ->  1 2 3   }T
   T{          2       -1 gd3 -> -1 0 1   }T
   T{ mid-uint+1 mid-uint gd3 -> mid-uint }T

   : gd4 do 1 0 do j loop -1 +loop ;

   T{        1          4 gd4 -> 4 3 2 1             }T
   T{       -1          2 gd4 -> 2 1 0 -1            }T
   T{ mid-uint mid-uint+1 gd4 -> mid-uint+1 mid-uint }T

   : leave2 10 swap ?do
         3 i = if 17 leave then
         5 i = if 19 leave then
      loop 23 ;

   T{ 0 leave2 -> 17 23 }T
   T{ 2 leave2 -> 17 23 }T
   T{ 3 leave2 -> 17 23 }T
   T{ 4 leave2 -> 19 23 }T
   T{ 5 leave2 -> 19 23 }T
   T{ 6 leave2 -> 23 }T

   : leave3 10 swap ?do
         3 i = if 17 leave then
         5 i = if 19 leave then
         7 i = if 23 leave then
      loop 29 ;

   T{ 0 leave3 -> 17 29 }T
   T{ 2 leave3 -> 17 29 }T
   T{ 3 leave3 -> 17 29 }T
   T{ 4 leave3 -> 19 29 }T
   T{ 5 leave3 -> 19 29 }T
   T{ 6 leave3 -> 23 29 }T
   T{ 7 leave3 -> 23 29 }T
   T{ 8 leave3 ->    29 }T

   : leave-sqrt 30 swap ?do \ Test nested leaves.
         i 11 = if leave then
         i 2 + 0 ?do j i i * < if i 1- leave then loop \ Integer square root.
         i 21 = if leave then
      loop ;

   T{  0 leave-sqrt -> 0 1 1 1 2 2 2 2 2 3 3 }T
   T{  8 leave-sqrt ->                 2 3 3 }T
   T{ 10 leave-sqrt ->                     3 }T
   T{ 11 leave-sqrt ->                       }T
   T{ 12 leave-sqrt ->   3 3 3 3 4 4 4 4 4 4 }T
   T{ 13 leave-sqrt ->     3 3 3 4 4 4 4 4 4 }T
   T{ 20 leave-sqrt ->                   4 4 }T
   T{ 21 leave-sqrt ->                     4 }T
   T{ 22 leave-sqrt ->       4 4 4 5 5 5 5 5 }T
   T{ 23 leave-sqrt ->         4 4 5 5 5 5 5 }T
   T{ 28 leave-sqrt ->                   5 5 }T
   T{ 29 leave-sqrt ->                     5 }T
   T{ 30 leave-sqrt ->                       }T

   : test-leave-1 5 0 ?do 17 leave 19 leave 23 loop ;
   : test-leave-2 5 0 ?do 19 leave 23 leave 29 leave leave loop ;
   : test-leave-3 5 0 ?do if 19 leave then 23 leave 29 leave leave loop ;
   : test-leave-4 5 0 ?do if leave 19 leave then 23 leave 29 leave leave loop ;
   : test-leave-5 5 0 ?do if 23 leave
            leave leave leave leave leave leave leave leave leave leave
         if leave leave leave leave leave leave leave leave leave leave then
      then 29 leave 31
      leave leave leave leave leave leave leave leave leave leave 2 3 5
      leave leave leave leave leave leave leave leave leave leave loop ;

   T{    test-leave-1 -> 17 }T
   T{    test-leave-2 -> 19 }T
   T{  0 test-leave-3 -> 23 }T
   T{ -1 test-leave-3 -> 19 }T
   T{  0 test-leave-4 -> 23 }T
   T{ -1 test-leave-4 ->    }T
   T{  0 test-leave-5 -> 29 }T
   T{ -1 test-leave-5 -> 23 }T
end-suite

suite recurse
   : test-recurse ( n1 -- n2 ) dup 2 < if drop 1 exit then dup 1- recurse * ;

   T{ 1 test-recurse ->   1 }T
   T{ 2 test-recurse ->   2 }T
   T{ 3 test-recurse ->   6 }T
   T{ 4 test-recurse ->  24 }T
   T{ 5 test-recurse -> 120 }T
end-suite

suite execution token
   : gt1 123 ;
   : gt2 ['] gt1 ;

   T{ ' gt1 execute -> 123 }T
   T{   gt2 execute -> 123 }T
end-suite
