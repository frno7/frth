: (parse-name) ( addr1 n1 xt -- addr2 n2 )
   >r begin dup
      while over c@ r@ execute
      while 1/string
      repeat then rdrop ;

: parse-name ( "name" -- c-addr u )
   source
   >in @ /string
   [']    space? (parse-name) over >r
   ['] nonspace? (parse-name) 2dup
   1 min + source drop - >in !
   drop r> tuck - ;

: parse ( char "ccc<char>" -- c-addr u )
   >r >in @
   source >in @ /string
   begin dup
   while 1 >in +!
         over c@ r@ <>
   while 1/string
   repeat drop swap >in @ - 0 swap 1+
   else rot >in @ -
   then rdrop /string ;
