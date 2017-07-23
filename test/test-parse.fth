suite parse
   : test-parse ( char ) >in @ swap parse nip >in @ rot - ;

   T{ '#' test-parse
      -> 0 0 }T
   T{ '#' test-parse #
      -> 0 1 }T
   T{ '#' test-parse f
      -> 1 1 }T
   T{ '#' test-parse fo
      -> 2 2 }T
   T{ '#' test-parse foo
      -> 3 3 }T
   T{ '#' test-parse foo#
      -> 3 4 }T
   T{ '#' test-parse foo#17
      -> 3 4 17 }T
   T{ '#' test-parse foobar#4711
      -> 6 7 4711 }T
end-suite
