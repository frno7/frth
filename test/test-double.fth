suite double
   T{ -1 s>d -> -1 -1 }T
   T{  0 s>d ->  0  0 }T
   T{  1 s>d ->  1  0 }T

   T{        0            0        1 um/mod -> 0        0 }T
   T{        1            0        1 um/mod -> 0        1 }T
   T{        1            0        2 um/mod -> 1        0 }T
   T{        3            0        2 um/mod -> 1        1 }T
   T{ max-uint        2 um*        2 um/mod -> 0 max-uint }T
   T{ max-uint        2 um* max-uint um/mod -> 0        2 }T
   T{ max-uint max-uint um* max-uint um/mod -> 0 max-uint }T
end-suiTE
