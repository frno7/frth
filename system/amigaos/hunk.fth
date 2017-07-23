$40000 2 rshift constant hunk:bss \ 256 KiB of data space i longwords.

0 value hunk:start
0 value hunk:text
0 value hunk:end

: t:>address ( u -- u ) dup if hunk:text - then ;
: t:address> ( u -- u ) dup if hunk:text + then ;
: t:aligned ( u -- u ) t:>address 3 + 3 invert and t:address> ; \ Align by 4.
: t:align ( -- ) here t:aligned here - erase, ;

: hunk:open ( -- )
   t:align here to hunk:start

    $3f3 u32msb, \ hunk file header block for executable files
       0 u32msb, \ empty list of strings
       2 u32msb, \ table size
       0 u32msb, \ first hunk
       1 u32msb, \ last hunk
       0 u32msb, \ hunk code size (updated in hunk:close)
hunk:bss u32msb, \ hunk bss size in longwords
    $3e9 u32msb, \ hunk code
       0 u32msb, \ number of machine code longwords (updated in hunk:close)

   here to hunk:text ;

: hunk:text> ( -- a-addr u ) hunk:text here hunk:text - ;

: tos> ( -- a-addr u ) hunk:start hunk:end hunk:start - ;

: hunk:close ( -- )
   t:align here hunk:text - 2 rshift
   dup hunk:start 20 + u32msb! \ Update hunk size.
       hunk:start 32 + u32msb! \ Update number of machine code longwords.

    $3f2 u32msb, \ hunk end
    $3eb u32msb, \ hunk bss
hunk:bss u32msb, \ hunk bss size in longwords
    $3f2 u32msb, \ hunk end

   here to hunk:end ;

: image:open ( -- ) hunk:open ;
: image:text> ( -- a-addr u ) hunk:text> ;
: image:close ( -- ) hunk:close ;
: image> ( -- a-addr u ) tos> ;
