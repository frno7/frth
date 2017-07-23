suite search \ FIXME
\  T{ only forth get-order -> get-orderlist }T
\  : so1 set-order ; \ in case it is unavailable in the forth wordlist

\  T{ only forth definitions order -> }T
\  T{ alsowid2 definitions order -> }T

\  T{ only forth-wordlist 1 set-order get-orderlist so1 -> }T
\  T{ get-order -> get-orderlist }T

\  only forth definitions
\  variable xt ' dup xt !
\  variable xti ' .( xti ! \ immediate word
\  T{ s" dup" wid1 @ search-wordlist -> xt  @ -1 }T
\  T{ s" .("  wid1 @ search-wordlist -> xti @  1 }T
\  T{ s" dup" wid2 @ search-wordlist ->        0 }T

\  T{ only forth definitions -> }T
\  T{ get-current -> forth-wordlist }T
\  T{ get-order wid2 @ swap 1+ set-order definitions get-current -> wid2 @ }T
\  T{ get-order -> get-orderlist wid2 @ swap 1+ }T
\  T{ previous get-order -> get-orderlist }T
\  T{ definitions get-current -> forth-wordlist }T

\  : alsowid2 also get-order wid2 @ rot drop swap set-order ;
\  alsowid2
\  : w1 1234 ;
\  definitions : w1 -9876 ; immediate

\  only forth
\  T{ w1 -> 1234 }T
\  definitions
\  T{ w1 -> 1234 }T
\  alsowid2
\  T{ w1 -> -9876 }T
\  definitions T{ w1 -> -9876 }T

\  only forth definitions
\  : so5 dup if swap execute then ;

\  T{ s" w1" wid1 @ search-wordlist so5 -> -1  1234 }T
\  T{ s" w1" wid2 @ search-wordlist so5 ->  1 -9876 }T

\  : c"w1" c" w1" ;
\  T{ alsowid2 c"w1" find so5 ->  1 -9876 }T
\  T{ previous c"w1" find so5 -> -1  1234 }T

\  T{ also get-order only -> get-orderlist over swap 1+ }T

\  T{ get-order over      -> get-order wid1 @ }T
\  T{ get-order set-order -> }T
\  T{ get-order           -> get-orderlist }T
\  T{ get-orderlist drop get-orderlist 2* set-order -> }T
\  T{ get-order -> get-orderlist drop get-orderlist 2* }T
\  T{ get-orderlist set-order get-order -> get-orderlist }T
\  : so2a get-order get-orderlist set-order ;
\  : so2 0 set-order so2a ;

\  T{ so2 -> 0 }T	    \ 0 set-order leaves an empty search order

\  : so3 -1 set-order so2a ;
\  : so4 only so2a ;

\  T{ so3 -> so4 }T	   \ -1 set-order is the same as only
end-suite
