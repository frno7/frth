$400000 value elf:vaddr \ Virtual address of first segment byte in memory.

0 value elf:start
0 value elf:text
0 value elf:end

: t:>address ( u -- u ) dup if elf:text - then ;
: t:address> ( u -- u ) dup if elf:text + then ;
: t:aligned ( u -- u ) t:>address 3 + 3 invert and t:address> ; \ Align by 4.
: t:align ( -- ) here t:aligned here - erase, ;

: elf:open ( -- )
   t:align here to elf:start

   \ ident
   $7f c, 'E' c, 'L' c, 'F' c, \ magic
     1 c,   1 c,   1 c,   0 c, \ class encoding version osabi
     8 erase,                  \ pad

   \ ehdr
     2 c,   0 c,   3 c,   0 c, \ type machine
     1 c,   0 c,   0 c,   0 c, \ version
   elf:vaddr 96 + t:u32,       \ entry
    52 t:u32,      0 t:u32,    \ phoff shoff
     0 c,   0 c,   0 c,   0 c, \ flags
    52 c,   0 c,               \ ehsize
    32 c,   0 c,   1 c,   0 c, \ phentsize phnum
    40 c,   0 c,   0 c,   0 c, \ shentsize shnum
     0 c,   0 c,               \ shtrndx

   \ phdr
     1 c,   0 c,   0 c,   0 c, \ type
     0 t:u32,                  \ offset
   elf:vaddr t:u32,            \ vaddr
   elf:vaddr t:u32,            \ paddr
     0 t:u32,                  \ filesz (updated in elf:close)
     0 t:u32,                  \ memsz (updated in elf:close)
  %111 c,   0 c,   0 c,   0 c, \ flags (read, write, execute) \ FIXME t:u32,
     $200000 t:u32,            \ align

    12 erase,                  \ pad

  here to elf:text ;

: elf:text> ( -- a-addr u ) elf:text here elf:text - ;

: elf> ( -- a-addr u ) elf:start elf:end elf:start - ;

: elf:close ( -- )
   here to elf:end
   elf> nip 96 -
   dup elf:start 68 + t:!   \ filesz
       elf:start 72 + t:! ; \ memsz

: image:open ( -- ) elf:open ;
: image:text> ( -- a-addr u ) elf:text> ;
: image:close ( -- ) elf:close ;
: image> ( -- a-addr u ) elf> ;
