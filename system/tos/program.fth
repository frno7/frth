$40000 constant prg:bss \ 256 KiB of data space.

0 value prg:start
0 value prg:text
0 value prg:end

: t:>address ( u -- u ) dup if prg:text - then ;
: t:address> ( u -- u ) dup if prg:text + then ;
: t:aligned ( u -- u ) t:>address 3 + 3 invert and t:address> ; \ Align by 4.
: t:align ( -- ) here t:aligned here - erase, ;

: prg:open ( -- )
   t:align here to prg:start

   $601a u16msb, \ magic
       0 u32msb, \ text size (updated in prg:close)
       0 u32msb, \ data size
 prg:bss u32msb, \ bss size
       0 u32msb, \ symbol table size
       0 u32msb, \ reserved
       0 u32msb, \ flags
       0 u16msb, \ fixup

  here to prg:text ;

: prg:text> ( -- a-addr u ) prg:text here prg:text - ;

: tos> ( -- a-addr u ) prg:start prg:end prg:start - ;

: prg:close ( -- )
   here prg:text - prg:start 2 + u32msb! \ Update text size.
   0 u32msb, \ Zero terminate fixup list for best compatibility by GEMDOS.
   here to prg:end ;

: image:open ( -- ) prg:open ;
: image:text> ( -- a-addr u ) prg:text> ;
: image:close ( -- ) prg:close ;
: image> ( -- a-addr u ) tos> ;
