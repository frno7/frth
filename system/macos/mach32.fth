$1000 value mach:vaddr \ Virtual address of first segment byte in memory.

0 value mach:start
0 value mach:text
0 value mach:end

: t:>address ( u -- u ) dup if mach:text - then ;
: t:address> ( u -- u ) dup if mach:text + then ;
: t:aligned ( u -- u ) t:>address 3 + 3 invert and t:address> ; \ Align by 4.
: t:align ( -- ) here t:aligned here - erase, ;

: mach:open ( -- )
   t:align here to mach:start

   \ mach header
   $ce c, $fa c, $ed c, $fe c, \ magic
                     7 t:u32,  \ cputype i386
                     3 t:u32,  \ cpusubtype ALL
                     2 t:u32,  \ filetype EXECUTE
                     3 t:u32,  \ ncmds
                   260 t:u32,  \ sizeofcmds
                    %1 t:u32,  \ flags NOUNDEFS

                     1 t:u32,  \ cmd LC_SEGMENT
                    56 t:u32,  \ cmdsize
   '_' c, '_' c, 'P' c, 'A' c, \ segname
   'G' c, 'E' c, 'Z' c, 'E' c,
   'R' c, 'O' c,     6  erase,
                     0 t:u32,  \ vmaddr
                 $1000 t:u32,  \ vmsize
                     0 t:u32,  \ fileoff
                     0 t:u32,  \ filesize
                  %000 t:u32,  \ maxprot
                  %000 t:u32,  \ initprot
                     0 t:u32,  \ nsects
                     0 t:u32,  \ flags

                     1 t:u32,  \ cmd LC_SEGMENT
                   124 t:u32,  \ cmdsize
   '_' c, '_' c, 'T' c, 'E' c, \ segname
   'X' c, 'T' c,    10  erase,
                 $1000 t:u32,  \ vmaddr
                     0 t:u32,  \ vmsize (updated in mach:close)
                     0 t:u32,  \ fileoff
                     0 t:u32,  \ filesize (updated in mach:close)
                  %111 t:u32,  \ maxprot (read, write, execute)
                  %111 t:u32,  \ initprot (read, write, execute)
                     1 t:u32,  \ nsects
                     0 t:u32,  \ flags
   '_' c, '_' c, 't' c, 'e' c, \ sectname
   'x' c, 't' c,    10  erase,
   '_' c, '_' c, 'T' c, 'E' c, \ segname
   'X' c, 'T' c,    10  erase,
                 $1120 t:u32,  \ addr
                     0 t:u32,  \ size (updated in mach:close)
                  $120 t:u32,  \ offset
                     0 t:u32,  \ align
                     0 t:u32,  \ reloff
                     0 t:u32,  \ nreloc
                     0 t:u32,  \ flags
                     0 t:u32,  \ reserved
                     0 t:u32,  \ reserved

                     5 t:u32,  \ cmd LC_UNIXTHREAD
                    80 t:u32,  \ cmdsize
                     1 t:u32,  \ flavor i386_THREAD_STATE
                    16 t:u32,  \ count i386_THREAD_STATE_COUNT
                     0 t:u32,  \ eax
                     0 t:u32,  \ ebx
                     0 t:u32,  \ ecx
                     0 t:u32,  \ edx
                     0 t:u32,  \ edi
                     0 t:u32,  \ esi
                     0 t:u32,  \ dbp
                     0 t:u32,  \ esp
                     0 t:u32,  \ ss
                     0 t:u32,  \ elfags
                 $1120 t:u32,  \ eip
                     0 t:u32,  \ cs
                     0 t:u32,  \ ds
                     0 t:u32,  \ es
                     0 t:u32,  \ fs
                     0 t:u32,  \ gs

  here to mach:text ;

: mach:text> ( -- a-addr u ) mach:text here mach:text - ;

: mach> ( -- a-addr u ) mach:start mach:end mach:start - ;

: mach:close ( -- )
   here mach:text - mach:start 176 + t:! \ Update text size.
   mach:start $1000 + here - 0 max erase, \ Pad to required 4096 byte minimum.
   here to mach:end
   mach> nip
   dup mach:start 112 + t:!   \ Update text vmsize.
       mach:start 120 + t:! ; \ Update text filesize.

: image:open ( -- ) mach:open ;
: image:text> ( -- a-addr u ) mach:text> ;
: image:close ( -- ) mach:close ;
: image> ( -- a-addr u ) mach> ;
