: t:offset, ( addr -- ) t:, ;
: t:offset@ ( addr -- u ) t:@ ;
: t:offset! ( addr1 addr2 -- u ) t:! ;
: t:relative; ( -- addr ) here 0 t:offset, ;
: t:relative, ( addr -- ) here - 4 - t:offset, ;
: t:relative! ( addr -- ) dup here swap - 4 - swap t:offset! ;

: if, ( x -- ) ( C: -- orig )
   $8b c, $45 c, $00 c,           \ mov  eax,[ebp]
   $8d c, $6d c, $04 c,           \ lea  ebp,[ebp+4]
   $85 c, $c0 c,                  \ test eax,eax
   $0f c, $84 c, t:relative; ;    \ je   xxxxxxxx

: ahead, ( C: -- orig )
   $e9 c, t:relative; ;           \ jmp  xxxxxxxx

: then, ( C: orig -- )
   t:relative! ;

: until, ( C: dest -- )
   $8b c, $45 c, $00 c,           \ mov  eax,[ebp]
   $8d c, $6d c, $04 c,           \ lea  ebp,[ebp+4]
   $85 c, $c0 c,                  \ test eax,eax
   $0f c, $84 c, t:relative, ;    \ je   xxxxxxxx

: again, ( C: dest -- )
   $e9 c, t:relative, ;           \ jmp  xxxxxxxx

include kernel/leave.fth

: leave, ( C: -- )
   $e9 c, leave> (leave,) >leave ; \ jmp xxxxxxxx
