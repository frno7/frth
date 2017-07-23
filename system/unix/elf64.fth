$400000 value elf:vaddr \ Virtual address of first segment byte in memory.

0 value elf:start
0 value elf:text
0 value elf:end

: t:>address ( u -- u ) dup if elf:text - then ;
: t:address> ( u -- u ) dup if elf:text + then ;
: t:aligned ( u -- u ) t:>address 7 + 7 invert and t:address> ; \ Align by 8.
: t:align ( -- ) here t:aligned here - erase, ;

: elf:open ( -- )
   t:align here to elf:start

   \ ident
   $7f c, 'E' c, 'L' c, 'F' c, \ magic
     2 c,   1 c,   1 c,   0 c, \ class encoding version osabi
     8 erase,                  \ pad

   \ ehdr
     2 c,   0 c,  62 c,   0 c, \ type machine
     1 c,   0 c,   0 c,   0 c, \ version
   elf:vaddr 128 + t:u64,      \ entry
    64 t:u64,      0 t:u64,    \ phoff shoff
     0 c,   0 c,   0 c,   0 c, \ flags
    64 c,   0 c,               \ ehsize
    56 c,   0 c,   1 c,   0 c, \ phentsize phnum
    64 c,   0 c,   0 c,   0 c, \ shentsize shnum
     0 c,   0 c,               \ shtrndx

   \ phdr
     1 c,   0 c,   0 c,   0 c, \ type
  %111 c,   0 c,   0 c,   0 c, \ flags (read, write, execute)
     0 t:u64,                  \ offset
   elf:vaddr t:u64,            \ vaddr
   elf:vaddr t:u64,            \ paddr
     0 t:u64,                  \ filesz (updated in elf:close)
     0 t:u64,                  \ memsz (updated in elf:close)
     $200000 t:u64,            \ align

     8 erase,                  \ pad

  here to elf:text ;

: elf:text> ( -- a-addr u ) elf:text here elf:text - ;

: elf> ( -- a-addr u ) elf:start elf:end elf:start - ;

: elf:close ( -- )
   here to elf:end
   elf> nip 128 -
   dup elf:start  96 + t:!   \ filesz
       elf:start 104 + t:! ; \ memsz

: image:open ( -- ) elf:open ;
: image:text> ( -- a-addr u ) elf:text> ;
: image:close ( -- ) elf:close ;
: image> ( -- a-addr u ) elf> ;
