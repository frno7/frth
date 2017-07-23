suite numeric notation
   : gc1 [char] X ;
   : gc2 [char] HELLO ;
   : gc3 [char] ö ;
   : gc4 [char] ጷ ;
   : gc5 [char] € ;
   : gc6 [char] 🚀 ;

   T{      #1289  ->       1289  }T
   T{  #12346789. ->   12346789. }T
   T{     #-1289  ->      -1289  }T
   T{ #-12346789. ->  -12346789. }T
   T{      $12eF  ->       4847  }T
   T{  $12aBcDeF. ->  313249263. }T
   T{     $-12eF  ->      -4847  }T
   T{ $-12AbCdEf. -> -313249263. }T
   T{  %10010110  ->        150  }T
   T{  %10010110. ->        150. }T
   T{ %-10010110  ->       -150  }T
   T{ %-10010110. ->       -150. }T
   T{        'A'  ->         65  }T
   T{        'z'  ->        122  }T
   T{     char A  ->         65  }T
   T{     char z  ->        122  }T
   T{        gc1  ->        $58  }T
   T{        gc2  ->        $48  }T
\  T{        gc3  ->        $f6  }T \ FIXME
\  T{        gc4  ->      $1337  }T \ FIXME
\  T{        gc5  ->      $20ac  }T \ FIXME
\  T{        gc6  ->     $1F680  }T \ FIXME

   create gn-buf 0 c,
   : gn-string gn-buf 1 ;
   : gn-consumed gn-buf char+ 0 ;
   : gn' [char] ' parse drop c@ gn-buf c! gn-string ;

   T{ 0 0 gn' 0' >number ->         0 0 gn-consumed }T
   T{ 0 0 gn' 1' >number ->         1 0 gn-consumed }T
   T{ 1 0 gn' 1' >number -> base @ 1+ 0 gn-consumed }T

   \ Following should fail to convert.
   T{ 0 0 gn' -' >number ->         0 0 gn-string   }T
   T{ 0 0 gn' +' >number ->         0 0 gn-string   }T
   T{ 0 0 gn' .' >number ->         0 0 gn-string   }T

   : >number-based base @ >r base ! >number r> base ! ;

   T{ 0 0 gn' 2'      $10 >number-based ->  $2 0 gn-consumed }T
   T{ 0 0 gn' 2'       $2 >number-based ->  $0 0 gn-string   }T
   T{ 0 0 gn' f'      $10 >number-based ->  $f 0 gn-consumed }T
   T{ 0 0 gn' g'      $10 >number-based ->  $0 0 gn-string   }T
   T{ 0 0 gn' g' max-base >number-based -> $10 0 gn-consumed }T
   T{ 0 0 gn' z' max-base >number-based -> $23 0 gn-consumed }T

   : gn1 ( ud base -- ud' len ) \ ud should equal ud' and len should be zero.
      base @ >r base !
      <# #s #>
      0 0 2swap >number swap drop \ Return length only.
      r> base ! ;

   T{        0   0        2 gn1 ->        0   0 0 }T
   T{ max-uint   0        2 gn1 -> max-uint   0 0 }T
   T{ max-uint dup        2 gn1 -> max-uint dup 0 }T
   T{        0   0 max-base gn1 ->        0   0 0 }T
   T{ max-uint   0 max-base gn1 -> max-uint   0 0 }T
   T{ max-uint dup max-base gn1 -> max-uint dup 0 }T
end-suite

suite numeric notation (extended)
   T{        123. ->     123  0  }T
   T{       -456. ->    -456 -1  }T
   T{     -#1289  ->      -1289  }T
   T{ -#12346789. ->  -12346789. }T
   T{     -$12eF  ->      -4847  }T
   T{ -$12AbCdEf. -> -313249263. }T
   T{ -%10010110  ->       -150  }T
   T{ -%10010110. ->       -150. }T
   T{        'ö'  ->        $f6  }T
   T{        'ጷ'  ->      $1337  }T
   T{        '€'  ->      $20ac  }T
   T{        '🚀'  ->     $1F680  }T \ FIXME Unicode 16 bits double.
\  T{     char ö  ->        $f6  }T \ FIXME
\  T{     char ጷ  ->      $1337  }T \ FIXME
\  T{     char €  ->      $20ac  }T \ FIXME
\  T{     char 🚀  ->     $1F680  }T \ FIXME
   T{     b# 101  ->          5  }T
   T{ b# 1011110  ->   %1011110  }T
   T{ b# -110010  ->   -%110010  }T
   T{ o# 1023470  ->     272184  }T
   T{ o# -740030  ->    -245784  }T
   T{ d# 1093478  ->   #1093478  }T
   T{ d# -740930  ->   -#740930  }T
   T{ h# 109a478  ->   $109a478  }T
   T{ h# -f4093e  ->   -$f4093e  }T
end-suite
