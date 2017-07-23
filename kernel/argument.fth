\ Command line argument and environment parsing and traversal words.

: arg ( u -- c-addr u ) cells + @ 0count ;

: traverse-arguments ( xt -- ) ( xt: c-addr u -- f )
   argv cell+ 2>r
   begin r@ @ ?dup
   while 0count 2r@ drop execute
   while r> cell+ >r
   repeat then 2rdrop ;

\ FIXME https://www.gnu.org/software/libc/manual/html_node/Environment-Access.html
: traverse-environment ( xt -- ) ( xt: c-addr1 u1 c-addr2 u2 -- f )
   envp 2>r
   begin r@ @ ?dup
   while 0count '=' split 2r> nup 2>r execute
   while r> cell+ >r
   repeat then 2rdrop ;
