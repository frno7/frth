suite comparison
   T{  2  2   = -> true  }T
   T{  2  3   = -> false }T

   T{    -7  0< -> true  }T
   T{    -1  0< -> true  }T
   T{     0  0< -> false }T
   T{     1  0< -> false }T
   T{     7  0< -> false }T

   T{    -7  0= -> false }T
   T{    -1  0= -> false }T
   T{     0  0= -> true  }T
   T{     1  0= -> false }T
   T{     7  0= -> false }T

   T{    -7  0> -> false }T
   T{    -1  0> -> false }T
   T{     0  0> -> false }T
   T{     1  0> -> true  }T
   T{     7  0> -> true  }T

   T{    -7 0<> -> true  }T
   T{    -1 0<> -> true  }T
   T{     0 0<> -> false }T
   T{     1 0<> -> true  }T
   T{     7 0<> -> true  }T

   T{  2  2  <> -> false }T
   T{  2  3  <> -> true  }T

   T{  2 -2   < -> false }T
   T{  3 -2   < -> false }T
   T{  2  2   < -> false }T
   T{  3  2   < -> false }T
   T{ -2  2   < -> true  }T
   T{ -2  3   < -> true  }T
   T{  2  3   < -> true  }T

   T{ -2  2   > -> false }T
   T{ -2  3   > -> false }T
   T{  2  2   > -> false }T
   T{  2  3   > -> false }T
   T{  2 -2   > -> true  }T
   T{  3 -2   > -> true  }T
   T{  3  2   > -> true  }T

   T{  2 -2  <= -> false }T
   T{  3 -2  <= -> false }T
   T{  2  2  <= -> true  }T
   T{  3  2  <= -> false }T
   T{ -2  2  <= -> true  }T
   T{ -2  3  <= -> true  }T
   T{  2  3  <= -> true  }T

   T{ -2  2  >= -> false }T
   T{ -2  3  >= -> false }T
   T{  2  2  >= -> true  }T
   T{  2  3  >= -> false }T
   T{  2 -2  >= -> true  }T
   T{  3 -2  >= -> true  }T
   T{  3  2  >= -> true  }T

   T{  0  1  u< -> true  }T
   T{  1  0  u< -> false }T
   T{  0  0  u< -> false }T
   T{  1  1  u< -> false }T
   T{  3  7  u< -> true  }T
   T{  7  3  u< -> false }T
   T{ -2 -1  u< -> true  }T
   T{ -1 -2  u< -> false }T
   T{ -1  1  u< -> false }T
   T{ -1  2  u< -> false }T

   T{  0  1  u> -> false }T
   T{  1  0  u> -> true  }T
   T{  0  0  u> -> false }T
   T{  1  1  u> -> false }T
   T{  3  7  u> -> false }T
   T{  7  3  u> -> true  }T
   T{ -2 -1  u> -> false }T
   T{ -1 -2  u> -> true  }T
   T{ -1  1  u> -> true  }T
   T{ -1  2  u> -> true  }T
end-suite

suite logic
   T{        0 0 and ->  0 }T
   T{        0 1 and ->  0 }T
   T{        1 0 and ->  0 }T
   T{        1 1 and ->  1 }T
   T{ 0 invert 1 and ->  1 }T
   T{ 1 invert 1 and ->  0 }T

   T{       0  0 and ->  0 }T
   T{       0 -1 and ->  0 }T
   T{      -1  0 and ->  0 }T
   T{      -1 -1 and -> -1 }T

   T{       0  0 xor ->  0 }T
   T{       0 -1 xor -> -1 }T
   T{      -1  0 xor -> -1 }T
   T{      -1 -1 xor ->  0 }T

   T{ %1010111011 3 rshift ->        %1010111 }T
   T{ %1010111011 2 rshift ->       %10101110 }T
   T{ %1010111011 1 rshift ->      %101011101 }T
   T{ %1010111011 0 rshift ->     %1010111011 }T
   T{ %1010111011 0 lshift ->     %1010111011 }T
   T{ %1010111011 1 lshift ->    %10101110110 }T
   T{ %1010111011 2 lshift ->   %101011101100 }T
   T{ %1010111011 3 lshift ->  %1010111011000 }T

   T{ -19 0 rshift    ->             -19 }T
   T{ -19 1 rshift 0> ->            true }T
   T{ -19 1 rshift    -> max-int     9 - }T
   T{ -19 2 rshift    -> max-int 2 / 4 - }T

   T{ -19 0 lshift -> -19 }T
   T{ -19 1 lshift -> -38 }T
   T{ -19 2 lshift -> -76 }T

   T{ -19 -7 2** ->    -1 }T \ FIXME Establish relation to 2 /
   T{ -19 -6 2** ->    -1 }T
   T{ -19 -5 2** ->    -1 }T
   T{ -19 -4 2** ->    -2 }T
   T{ -19 -3 2** ->    -3 }T
   T{ -19 -2 2** ->    -5 }T
   T{ -19 -1 2** ->   -10 }T
   T{ -19  0 2** ->   -19 }T
   T{ -19  1 2** ->   -38 }T
   T{ -19  2 2** ->   -76 }T
   T{ -19  3 2** ->  -152 }T
   T{ -19  4 2** ->  -304 }T
   T{ -19  5 2** ->  -608 }T
   T{ -19  6 2** -> -1216 }T
   T{ -19  7 2** -> -2432 }T

   T{  19 -7 2** ->     0 }T
   T{  19 -6 2** ->     0 }T
   T{  19 -5 2** ->     0 }T
   T{  19 -4 2** ->     1 }T
   T{  19 -3 2** ->     2 }T
   T{  19 -2 2** ->     4 }T
   T{  19 -1 2** ->     9 }T
   T{  19  0 2** ->    19 }T
   T{  19  1 2** ->    38 }T
   T{  19  2 2** ->    76 }T
   T{  19  3 2** ->   152 }T
   T{  19  4 2** ->   304 }T
   T{  19  5 2** ->   608 }T
   T{  19  6 2** ->  1216 }T
   T{  19  7 2** ->  2432 }T

   T{ -37 -4 2** -> -37 4 rshift $ffff invert or }T
   T{ -37 -3 2** -> -37 3 rshift $ffff invert or }T
   T{ -37 -2 2** -> -37 2 rshift $ffff invert or }T
   T{ -37 -1 2** -> -37 1 rshift $ffff invert or }T
   T{ -37  0 2** -> -37 0 rshift }T
   T{  37  0 2** ->  37 0 lshift }T
   T{  37  1 2** ->  37 1 lshift }T
   T{  37  2 2** ->  37 2 lshift }T
   T{  37  3 2** ->  37 3 lshift }T
   T{  37  4 2** ->  37 4 lshift }T
end-suite
