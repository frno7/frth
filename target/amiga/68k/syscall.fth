code sys-dos-base ( -- addr )
 2a 78 00 04             \ move.l  4.w,a5
 43 fa 00 10             \ dc.w    $43fa,$0010 ; lea 16(pc),a1
 70 00                   \ moveq   #0,%d0
 4e ad fd d8             \ jsr     -30-522(a5)
 4a 80                   \ tst.l   d0
 66 10                   \ dc.w    $6610 ; bne.s +16(pc)
 70 00                   \ moveq.l #0,%d0
 4e 75                   \ rts
 64 6f 73 2e 6c 69       \ dc.b 'dos.li'
 62 72 61 72 79 00       \ dc.b 'brary',0
 2d 00                   \ move.l  d0,-(a6)
end-code

code sys-call0 ( n addr -- n )
 2a 5e                   \ move.l  (a6)+,a5
 db de                   \ add.l   (a6)+,a5
 4e 95                   \ jsr     (a5)
 2d 00                   \ move.l  d0,-(a6)
end-code

code sys-call1 ( x n addr -- n )
 2a 5e                   \ move.l  (a6)+,a5
 db de                   \ add.l   (a6)+,a5
 22 1e                   \ move.l  (a6)+,d1
 4e 95                   \ jsr     (a5)
 2d 00                   \ move.l  d0,-(a6)
end-code

code sys-call2 ( x x n addr -- n )
 2a 5e                   \ move.l  (a6)+,a5
 db de                   \ add.l   (a6)+,a5
 22 1e                   \ move.l  (a6)+,d1
 24 1e                   \ move.l  (a6)+,d2
 4e 95                   \ jsr     (a5)
 2d 00                   \ move.l  d0,-(a6)
end-code

code sys-call3 ( x x x n addr -- n )
 2a 5e                   \ move.l  (a6)+,a5
 db de                   \ add.l   (a6)+,a5
 22 1e                   \ move.l  (a6)+,d1
 24 1e                   \ move.l  (a6)+,d2
 26 1e                   \ move.l  (a6)+,d3
 4e 95                   \ jsr     (a5)
 2d 00                   \ move.l  d0,-(a6)
end-code

code sys-call4 ( x x x x n addr -- n )
 2a 5e                   \ move.l  (a6)+,a5
 db de                   \ add.l   (a6)+,a5
 22 1e                   \ move.l  (a6)+,d1
 24 1e                   \ move.l  (a6)+,d2
 26 1e                   \ move.l  (a6)+,d3
 28 1e                   \ move.l  (a6)+,d4
 4e 95                   \ jsr     (a5)
 2d 00                   \ move.l  d0,-(a6)
end-code

sys-dos-base constant dos-base

: sys-open   ( fam c-addr -- fd )   -30 dos-base sys-call2      ; \ mode name -- fd
: sys-close  ( fd -- )              -36 dos-base sys-call1 drop ; \ fd --
: sys-read   ( u addr fd -- n )     -42 dos-base sys-call3      ; \ length buffer fd -- n
: sys-write  ( u addr fd -- n )     -48 dos-base sys-call3      ; \ length buffer fd -- n
: sys-seek   ( u u fd -- n )        -66 dos-base sys-call3      ; \ mode distance fd -- pos
: sys-input  ( -- fd )              -54 dos-base sys-call0      ; \ -- fd
: sys-output ( -- fd )              -60 dos-base sys-call0      ; \ -- fd
: sys-io-err ( -- ior )            -132 dos-base sys-call0      ; \ -- ior
: sys-exit   ( n -- )              -144 dos-base sys-call1      ; \ n --
: sys-wait-for-char ( u fd -- u )  -204 dos-base sys-call2      ; \ timeout fd -- status
: sys-is-interactive ( u fd -- u ) -216 dos-base sys-call1      ; \ fd -- status
