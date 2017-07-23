suite create
   create cr0

   T{ ' cr0 >body -> here }T

   : does1 does> @ 1 + ;
   : does2 does> @ 2 + ;

   create cr1 T{ cr1   -> here }T
          1 , T{ cr1 @ ->    1 }T
        does1 T{ cr1   ->    2 }T
        does2 T{ cr1   ->    3 }T

   create cr2 5 , 7 , 11 , does> swap cells + @ ;

   T{ 0 cr2 ->  5 }T
   T{ 1 cr2 ->  7 }T
   T{ 2 cr2 -> 11 }T

   : weird: create does> 1 + does> 2 + ;
   weird: w1

   T{ ' w1 >body -> here     }T
   T{         w1 -> here 1 + }T
   T{         w1 -> here 2 + }T

end-suite

suite constant
   123 constant x123
   : equ constant ;
   x123 equ y123

   T{ x123 -> 123 }T
   T{ y123 -> 123 }T
end-suite

suite value
    111 value v1
   -999 value v2
   : vd1 v1 ;
   : vd2 to v2 ;

   T{        v1 ->  111 }T
   T{        v2 -> -999 }T
   T{ 222 to v1 ->      }T
   T{        v1 ->  222 }T
   T{       vd1 ->  222 }T
   T{        v2 -> -999 }T
   T{  -333 vd2 ->      }T
   T{        v2 -> -333 }T
   T{        v1 ->  222 }T
end-suite

suite 2variable
   2variable 2v1
   : cd2 2variable ;
   cd2 2v2
   : cd3 2v2 2! ;
   2variable 2v3 immediate

   T{    0. 2v1 2! ->        }T
   T{       2v1 2@ ->     0. }T
   T{ -1 -2 2v1 2! ->        }T
   T{       2v1 2@ -> -1 -2  }T
   T{    -2 -1 cd3 ->        }T
   T{       2v2 2@ ->  -2 -1 }T
   T{   5 6 2v3 2! ->        }T
   T{       2v3 2@ ->    5 6 }T
end-suite
