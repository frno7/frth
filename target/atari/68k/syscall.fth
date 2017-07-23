code sys-call0 ( n -- n )
 20 1e                   \ move.l  (a6)+,d0
 3f 00                   \ move.w  d0,-(sp)
 4e 41                   \ trap    #1
 54 8f                   \ addq.l  #2,sp
 2d 00                   \ move.l  d0,-(a6)
end-code

code sys-call1-w ( x n -- n )
 20 1e                   \ move.l  (a6)+,d0
 22 1e                   \ move.l  (a6)+,d1
 3f 01                   \ move.w  d1,-(sp)
 3f 00                   \ move.w  d0,-(sp)
 4e 41                   \ trap    #1
 58 8f                   \ addq.l  #4,sp
 2d 00                   \ move.l  d0,-(a6)
end-code

code sys-call1-l ( x n -- n )
 20 1e                   \ move.l  (a6)+,d0
 2f 1e                   \ move.l  (a6)+,-(sp)
 3f 00                   \ move.w  d0,-(sp)
 4e 41                   \ trap    #1
 5c 8f                   \ addq.l  #6,sp
 2d 00                   \ move.l  d0,-(a6)
end-code

code sys-call2-ww ( x x n -- n )
 20 1e                   \ move.l  (a6)+,d0
 22 1e                   \ move.l  (a6)+,d1
 24 1e                   \ move.l  (a6)+,d2
 3f 02                   \ move.w  d2,-(sp)
 3f 01                   \ move.w  d1,-(sp)
 3f 00                   \ move.w  d0,-(sp)
 4e 41                   \ trap    #1
 5c 8f                   \ addq.l  #6,sp
 2d 00                   \ move.l  d0,-(a6)
end-code

code sys-call2-wl ( x x n -- n )
 20 1e                   \ move.l  (a6)+,d0
 22 1e                   \ move.l  (a6)+,d1
 24 1e                   \ move.l  (a6)+,d2
 3f 02                   \ move.w  d2,-(sp)
 2f 01                   \ move.l  d1,-(sp)
 3f 00                   \ move.w  d0,-(sp)
 4e 41                   \ trap    #1
 50 8f                   \ addq.l  #8,sp
 2d 00                   \ move.l  d0,-(a6)
end-code

code sys-call3-wwl ( x x x n -- n )
 20 1e                   \ move.l  (a6)+,d0
 22 1e                   \ move.l  (a6)+,d1
 24 1e                   \ move.l  (a6)+,d2
 26 1e                   \ move.l  (a6)+,d3
 3f 03                   \ move.w  d3,-(sp)
 3f 02                   \ move.w  d2,-(sp)
 2f 01                   \ move.l  d1,-(sp)
 3f 00                   \ move.w  d0,-(sp)
 4e 41                   \ trap    #1
 4f ef 00 0a             \ lea     10(sp),sp
 2d 00                   \ move.l  d0,-(a6)
end-code

code sys-call3-wlw ( x x x n -- n )
 20 1e                   \ move.l  (a6)+,d0
 22 1e                   \ move.l  (a6)+,d1
 24 1e                   \ move.l  (a6)+,d2
 2f 1e                   \ move.l  (a6)+,-(sp)
 3f 02                   \ move.w  d2,-(sp)
 2f 01                   \ move.l  d1,-(sp)
 3f 00                   \ move.w  d0,-(sp)
 4e 41                   \ trap    #1
 4f ef 00 0c             \ lea     12(sp),sp
 2d 00                   \ move.l  d0,-(a6)
end-code

code sys-call3-llw ( x x x n -- n )
 20 1e                   \ move.l  (a6)+,d0
 22 1e                   \ move.l  (a6)+,d1
 24 1e                   \ move.l  (a6)+,d2
 2f 1e                   \ move.l  (a6)+,-(sp)
 2f 02                   \ move.l  d2,-(sp)
 3f 01                   \ move.w  d1,-(sp)
 3f 00                   \ move.w  d0,-(sp)
 4e 41                   \ trap    #1
 4f ef 00 0c             \ lea     12(sp),sp
 2d 00                   \ move.l  d0,-(a6)
end-code

code sys-call4-lllw ( x x x x n -- n )
 20 1e                   \ move.l  (a6)+,d0
 22 1e                   \ move.l  (a6)+,d1
 24 1e                   \ move.l  (a6)+,d2
 26 1e                   \ move.l  (a6)+,d3
 2f 1e                   \ move.l  (a6)+,-(sp)
 2f 03                   \ move.l  d3,-(sp)
 2f 02                   \ move.l  d2,-(sp)
 3f 01                   \ move.w  d1,-(sp)
 3f 00                   \ move.w  d0,-(sp)
 4e 41                   \ trap    #1
 4f ef 00 10             \ lea     16(sp),sp
 2d 00                   \ move.l  d0,-(a6)
end-code

: sys-pterm0   ( -- )                 0 sys-call0         ; \ --
: sys-cconin   ( -- char )            1 sys-call0         ; \ -- c
: sys-cconout  ( char -- )            2 sys-call1-w drop  ; \ c --
: sys-cauxin   ( -- char )            3 sys-call0         ; \ -- c
: sys-cauxout  ( char -- )            4 sys-call1-w drop  ; \ c --
: sys-cprnout  ( char -- )            5 sys-call1-w drop  ; \ c --
: sys-crawio   ( char -- char )       6 sys-call1-w       ; \ c -- c
: sys-crawin   ( -- char )            7 sys-call0         ; \ -- c
: sys-cnecin   ( -- char )            8 sys-call0         ; \ -- c
: sys-cconws   ( c-addr -- )          9 sys-call1-l drop  ; \ c-addr --
: sys-cconrs   ( c-addr -- )         10 sys-call1-l drop  ; \ c-addr --
: sys-cconis   ( -- n )              11 sys-call0         ; \ -- n
: sys-dsetdrv  ( n -- u )            14 sys-call1-w       ; \ n -- u
: sys-cconos   ( -- n )              16 sys-call0         ; \ -- n
: sys-cprnos   ( -- n )              17 sys-call0         ; \ -- n
: sys-cauxis   ( -- n )              18 sys-call0         ; \ -- n
: sys-cauxos   ( -- n )              19 sys-call0         ; \ -- n
: sys-dgetdrv  ( -- n )              25 sys-call0         ; \ -- n
: sys-fsetdta  ( addr -- )           26 sys-call1-l drop  ; \ addr --
: sys-super    ( addr -- )           32 sys-call1-l drop  ; \ stack --
: sys-tgetdate ( -- n )              42 sys-call0         ; \ -- n
: sys-tsetdate ( n -- n )            43 sys-call1-w       ; \ n -- n
: sys-tgettime ( -- n )              44 sys-call0         ; \ -- n
: sys-tsettime ( n -- n )            45 sys-call1-w       ; \ n -- n
: sys-fgetdta  ( -- addr )           47 sys-call0         ; \ -- addr
: sys-sversion ( -- n )              48 sys-call0         ; \ -- n
: sys-ptermres ( n u -- )            49 sys-call2-wl drop ; \ retcode keepcnt --
: sys-dfree    ( n u -- )            54 sys-call2-wl drop ; \ drveno buf --
: sys-dcreate  ( c-addr -- )         57 sys-call1-l       ; \ pathname -- status
: sys-ddelete  ( c-addr -- )         58 sys-call1-l       ; \ pathname -- status
: sys-dsetpath ( c-addr -- )         59 sys-call1-l       ; \ pathname -- status
: sys-fcreate  ( fam c-addr -- )     60 sys-call2-wl      ; \ attribs fname -- status
: sys-fopen    ( fam c-addr -- fd )  61 sys-call2-wl      ; \ mode fname -- fd
: sys-fclose   ( fd -- ior )         62 sys-call1-w       ; \ fd -- status
: sys-fread    ( a-addr u fd -- n )  63 sys-call3-llw     ; \ buf count fd -- size
: sys-fwrite   ( a-addr u fd -- n )  64 sys-call3-llw     ; \ buf count fd -- size
: sys-fdelete  ( c-addr -- ior )     65 sys-call1-l       ; \ fname -- status
: sys-fseek    ( u u c-addr -- ior ) 66 sys-call3-wwl     ; \ mode fd offset -- status
: sys-fattrib  ( u u c-addr -- ior ) 67 sys-call3-wwl     ; \ attribs wflag fname -- status
: sys-fdup     ( fd -- fd )          69 sys-call1-w       ; \ fd -- fd
: sys-fforce   ( fd fd -- ior )      70 sys-call2-ww      ; \ fd fd -- ior
: sys-dgetpath ( n c-addr -- )       71 sys-call2-wl drop ; \ driveno buf --
: sys-malloc   ( u -- a-addr )       72 sys-call1-l       ; \ amount -- addr
: sys-mfree    ( a-addr -- n )       73 sys-call1-l       ; \ addr -- status
: sys-mshrink  ( u a-addr u -- n )   74 sys-call3-llw     ; \ newsiz block 0 -- status
: sys-pexec    ( c-addr3 c-addr2 c-addr1 u -- n )
                                     75 sys-call4-lllw    ; \ ptr3 ptr2 ptr1 mode -- status
: sys-pterm    ( n -- )              76 sys-call1-w       ; \ status --
: sys-fsfirst  ( u c-addr -- ior )   78 sys-call2-wl      ; \ attribs fspec -- status
: sys-fsnext   ( -- ior )            79 sys-call0         ; \ -- status
: sys-frename  ( c-addr2 c-addr1 u -- ior )
                                     86 sys-call3-llw     ; \ newname oldname 0 -- status
: sys-fdatime  ( u c-addr1 fd -- )   87 sys-call3-wlw     ; \ wflag timeptr fd --

\ All error numbers are negative.  Two ranges  of  errors  are defined; BIOS
\ errors range from -1 to -31 and GEMDOS errors range from -32 to -127.
\
\ BIOS error codes:
\
\ E_OK          0   OK (no error)
\ ERROR        -1   Error
\ EDRVNR       -2   Drive not ready
\ EUNCMD       -3   Unknown command
\ E_CRC        -4   CRC error
\ EBADRQ       -5   Bad request
\ E_SEEK       -6   Seek error
\ EMEDIA       -7   Unknown media
\ ESECNF       -8   Sector not found
\ EPAPER       -9   Out of paper
\ EWRITF      -10   Write fault
\ EREADF      -11   Read fault
\             -12   (unused)
\ EWRPRO      -13   Write on write-protected media
\ E_CHNG      -14   Media change detected
\ EUNDEV      -15   Unknown device
\ EBADSF      -16   Bad sectors on format
\ EOTHER      -17   Insert other disk (request)
\
\ GEMDOS error codes:
\
\ EINVFN      -32   Invalid function number
\ EFILNF      -33   File not found
\ EPTHNF      -34   Path not found
\ ENHNDL      -35   Handle pool exhausted
\ EACCDN      -36   Access denied
\ EIHNDL      -37   Invalid handle
\ ENSMEM      -39   Insufficient memory
\ EIMBA       -40   Invalid memory block address
\ EDRIVE      -46   Invalid drive specification
\ ENMFIL      -47   No more files
\ ERANGE      -64   Range error
\ EINTRN      -65   GEMDOS internal error
\ EPLFMT      -66   Invalid executable file format
\ EGSBF       -67   Memory block growth failure
