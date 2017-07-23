suite string
   : test-csuffix?-1 s" "        '!' csuffix? ;
   : test-csuffix?-2 s" x"       '!' csuffix? ;
   : test-csuffix?-3 s" !"       '!' csuffix? ;
   : test-csuffix?-4 s" xx"      '!' csuffix? ;
   : test-csuffix?-5 s" !x"      '!' csuffix? ;
   : test-csuffix?-6 s" x!"      '!' csuffix? ;
   : test-csuffix?-7 s" !!"      '!' csuffix? ;
   : test-csuffix?-8 s" xxxxxx " 'x' csuffix? ;
   : test-csuffix?-9 s"       x" 'x' csuffix? ;

   T{ test-csuffix?-1 -> false }T
   T{ test-csuffix?-2 -> false }T
   T{ test-csuffix?-3 ->  true }T
   T{ test-csuffix?-4 -> false }T
   T{ test-csuffix?-5 -> false }T
   T{ test-csuffix?-6 ->  true }T
   T{ test-csuffix?-7 ->  true }T
   T{ test-csuffix?-8 -> false }T
   T{ test-csuffix?-9 ->  true }T

   : under_ ( x1 x2 "<spaces>name" -- x3 x2 ) \ Apply name to x1 to obtain x3.
      postpone >r
      postpone '
      postpone literal
      postpone execute
      postpone r>
      ; immediate
   : 3- ( n -- n ) 3 - ;
   : 3+ ( n -- n ) 3 + ;
   : 3/string ( addr u -- addr u ) 3- under_ 3+ ; \ FIXME Define 1/string like this.
   : foobar-str s" foobar" ;
   :    bar-str    s" bar" ;
   : under-test s" fiebuz" 3/string s" buz" s= ;

   T{ foobar-str 3/string            -> foobar-str swap 3+ swap 3- }T
   T{ foobar-str 3/string bar-str s= -> true                       }T
   T{ under-test                     -> true                       }T
end-suite
