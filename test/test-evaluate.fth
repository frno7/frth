suite evaluate
   : ge1 s" 123" ; immediate
   : ge2 s" 123 1+" ; immediate
   : ge3 s" : ge4 345 ;" ;
   : ge5 evaluate ; immediate

   T{ ge1 evaluate -> 123 }T \ Test evaluate in interpreting state.
   T{ ge2 evaluate -> 124 }T

   ge3 evaluate

   T{ ge4          -> 345 }T

   : ge6 ge1 ge5 ;           \ Test evaluate in compiling state.
   : ge7 ge2 ge5 ;

   T{ ge6 -> 123 }T
   T{ ge7 -> 124 }T
end-suite
