: (base#) ( "<spaces>name" -- n | d )
   >r parse-name ['] (>number) r> base-execute 0= if 0 ( FIXME throw ) then ;
: b#  2 (base#) ; immediate
: o#  8 (base#) ; immediate
: d# 10 (base#) ; immediate
: h# 16 (base#) ; immediate

\ : (wordlist) ( wid "<name>" -- ; ) FIXME Simplify VOCABULARY using CREATE.
\    CREATE ,
\    DOES>
\      @ >R
\      GET-ORDER NIP
\      R> SWAP SET-ORDER
\ ;
: vocabulary ( "<spaces>name" -- )
      wordlist
   >r parse-name 2dup r@ name>wordlist
      ?redefined create-name, 0 c, 0 c, create-link,
      postpone get-order
      postpone nip
   r> postpone literal
      postpone swap
      postpone set-order
      postpone ; ;
