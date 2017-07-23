$1000 value mach:vaddr \ Virtual address of first segment byte in memory.

0 value mach:start
0 value mach:text
0 value mach:end

: t:>address ( u -- u ) dup if mach:text - then ;
: t:address> ( u -- u ) dup if mach:text + then ;
: t:aligned ( u -- u ) t:>address 7 + 7 invert and t:address> ; \ Align by 8.
: t:align ( -- ) here t:aligned here - erase, ;

: mach:open ( -- )
   t:align here to mach:start

   \ mach header
   $ce c, $fa c, $ed c, $fe c, \ magic
              $1000007 t:u32,  \ cputype X86_64
             $80000003 t:u32,  \ cpusubtype ALL LIB64
                     2 t:u32,  \ filetype EXECUTE
                     3 t:u32,  \ ncmds
                   408 t:u32,  \ sizeofcmds
                    %1 t:u32,  \ flags NOUNDEFS

                    25 t:u32,  \ cmd LC_SEGMENT_64
                    72 t:u32,  \ cmdsize
   '_' c, '_' c, 'P' c, 'A' c, \ segname
   'G' c, 'E' c, 'Z' c, 'E' c,
   'R' c, 'O' c,     6  erase,
                     0 t:u64,  \ vmaddr
                 $1000 t:u64,  \ vmsize
                     0 t:u64,  \ fileoff
                     0 t:u64,  \ filesize
                  %000 t:u32,  \ maxprot
                  %000 t:u32,  \ initprot
                     0 t:u32,  \ nsects
                     0 t:u32,  \ flags

                    25 t:u32,  \ cmd LC_SEGMENT_64
                   152 t:u32,  \ cmdsize
   '_' c, '_' c, 'T' c, 'E' c, \ segname
   'X' c, 'T' c,    10  erase,
                 $1000 t:u64,  \ vmaddr
                     0 t:u64,  \ vmsize (updated in mach:close)
                     0 t:u64,  \ fileoff
                     0 t:u64,  \ filesize (updated in mach:close)
                  %111 t:u32,  \ maxprot (read, write, execute)
                  %111 t:u32,  \ initprot (read, write, execute)
                     1 t:u32,  \ nsects
                     0 t:u32,  \ flags
   '_' c, '_' c, 't' c, 'e' c, \ sectname
   'x' c, 't' c,    10  erase,
   '_' c, '_' c, 'T' c, 'E' c, \ segname
   'X' c, 'T' c,    10  erase,
                 $11b8 t:u64,  \ addr
                     0 t:u64,  \ size (updated in mach:close)
                  $1b8 t:u32,  \ offset
                     0 t:u32,  \ align
                     0 t:u32,  \ reloff
                     0 t:u32,  \ nreloc
                     0 t:u32,  \ flags
                     0 t:u32,  \ reserved
                     0 t:u32,  \ reserved
                     0 t:u32,  \ reserved

                     5 t:u32,  \ cmd LC_UNIXTHREAD
                   184 t:u32,  \ cmdsize
                     4 t:u32,  \ flavor x86_THREAD_STATE64
                    42 t:u32,  \ count x86_THREAD_STATE64_COUNT
                     0 t:u64,  \ rax
                     0 t:u64,  \ rbx
                     0 t:u64,  \ rcx
                     0 t:u64,  \ rdx
                     0 t:u64,  \ rdi
                     0 t:u64,  \ rsi
                     0 t:u64,  \ rbp
                     0 t:u64,  \ rsp
                     0 t:u64,  \ r8
                     0 t:u64,  \ r9
                     0 t:u64,  \ r10
                     0 t:u64,  \ r11
                     0 t:u64,  \ r12
                     0 t:u64,  \ r13
                     0 t:u64,  \ r14
                     0 t:u64,  \ r15
                 $11b8 t:u64,  \ rip
                     0 t:u64,  \ rflags
                     0 t:u64,  \ cs
                     0 t:u64,  \ fs
                     0 t:u64,  \ gs

                     4  erase, \ padding for alignment by 8

  here to mach:text ;

: mach:text> ( -- a-addr u ) mach:text here mach:text - ;

: mach> ( -- a-addr u ) mach:start mach:end mach:start - ;

: mach:close ( -- )
   here mach:text - mach:start 212 + t:! \ Update text size.
   mach:start $1000 + here - 0 max erase, \ Pad to required 4096 byte minimum.
   here to mach:end
   mach> nip
   dup mach:start 132 + t:!   \ Update text vmsize.
       mach:start 148 + t:! ; \ Update text filesize.

: image:open ( -- ) mach:open ;
: image:text> ( -- a-addr u ) mach:text> ;
: image:close ( -- ) mach:close ;
: image> ( -- a-addr u ) mach> ;
