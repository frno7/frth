\ The BASIS word determines the absolute address of itself using the
\ program counter. The adjustment constant takes preceding dictionary
\ storage into account. By placing the word first the program entry
\ point will be given which is useful for relocation.
code basis ( -- addr )
 41 fa ff ee             \ dc.w   $41fa,$ffee ; lea -18(pc),a0
 2d 08                   \ move.l a0,-(a6)
end-code noninline

code init \ Provisional 4096 bytes return stack.
 4d ef f0 00             \ lea     -$1000(sp),a6
end-code

init

code drop
 58 8e                   \ addq.l  #4,a6
end-code

code swap
 20 16                   \ move.l  (a6),d0
 2c ae 00 04             \ move.l  4(a6),(a6)
 2d 40 00 04             \ move.l  d0,4(a6)
end-code

code dup
 2d 16                   \ move.l  (a6),-(a6)
end-code

code over
 2d 2e 00 04             \ move.l  4(a6),-(a6)
end-code

code rot
 20 16                   \ move.l  (a6),d0
 22 2e 00 04             \ move.l  4(a6),d1
 24 2e 00 08             \ move.l  8(a6),d2
 2d 40 00 04             \ move.l  d0,4(a6)
 2d 41 00 08             \ move.l  d1,8(a6)
 2c 82                   \ move.l  d2,(a6)
end-code

code -rot
 20 16                   \ move.l  (a6),d0
 22 2e 00 04             \ move.l  4(a6),d1
 24 2e 00 08             \ move.l  8(a6),d2
 2d 40 00 08             \ move.l  d0,8(a6)
 2c 81                   \ move.l  d1,(a6)
 2d 42 00 04             \ move.l  d2,4(a6)
end-code

code 2drop
 50 8e                   \ addq.l  #8,a6
end-code

code 2dup
 2d 2e 00 04             \ move.l  4(a6),-(a6)
 2d 2e 00 04             \ move.l  4(a6),-(a6)
end-code

code 2swap
 20 16                   \ move.l  (a6),d0
 22 2e 00 04             \ move.l  4(a6),d1
 24 2e 00 08             \ move.l  8(a6),d2
 26 2e 00 0c             \ move.l  12(a6),d3
 2c 82                   \ move.l  d2,(a6)
 2d 43 00 04             \ move.l  d3,4(a6)
 2d 40 00 08             \ move.l  d0,8(a6)
 2d 41 00 0c             \ move.l  d1,12(a6)
end-code

code ?dup
 20 16                   \ move.l  (a6),d0
 67 02                   \ dc.w    $6702 ; beq +2
 2d 00                   \ move.l  d0,-(a6)
end-code

code 2** ( n n -- n ) \ Power of 2.
 20 1e                   \ move.l  (a6)+,d0
 22 16                   \ move.l  (a6),d1
 4a 80                   \ tst.l   d0
 6b 04                   \ dc.w    $6b04 ; bmi.s +4
 e1 a1                   \ asl.l   d0,d1
 60 04                   \ dc.w    $6004 ; bra.s +4
 44 80                   \ neg.l   d0
 e0 a1                   \ asr.l   d0,d1
 2c 81                   \ move.l  d1,(a6)
end-code

code rshift
 20 1e                   \ move.l  (a6)+,d0
 22 16                   \ move.l  (a6),d1
 e0 a9                   \ lsr.l   d0,d1
 2c 81                   \ move.l  d1,(a6)
end-code

code lshift
 20 1e                   \ move.l  (a6)+,d0
 22 16                   \ move.l  (a6),d1
 e1 a9                   \ lsl.l   d0,d1
 2c 81                   \ move.l  d1,(a6)
end-code

code negate
 44 96                   \ neg.l   (a6)
end-code

code 1+
 52 96                   \ addq.l  #1,(a6)
end-code

code 1-
 53 96                   \ subq.l  #1,(a6)
end-code

code 4+
 58 96                   \ addq.l  #4,(a6)
end-code

code 4-
 59 96                   \ subq.l  #4,(a6)
end-code

code 8+
 50 96                   \ addq.l  #8,(a6)
end-code

code 8-
 51 96                   \ subq.l  #8,(a6)
end-code

code +
 20 1e                   \ move.l  (a6)+,d0
 d1 96                   \ add.l   d0,(a6)
end-code

code um+ ( u1 u2 -- du )
 42 81                   \ clr.l   d1
 20 16                   \ move.l  (a6),d0
 d1 ae 00 04             \ add.l   d0,4(a6)
 d3 81                   \ addx.l  d1,d1
 2c 81                   \ move.l  d1,(a6)
end-code

code -
 20 1e                   \ move.l  (a6)+,d0
 91 96                   \ sub.l   d0,(a6)
end-code

code * ( n1 n2 -- n3 )
 20 1e                   \ move.l  (a6)+,d0
 22 16                   \ move.l  (a6),d1
 34 01                   \ move.w  d1,d2
 c4 c0                   \ mulu    d0,d2
 26 01                   \ move.l  d1,d3
 48 43                   \ swap    d3
 c6 c0                   \ mulu    d0,d3
 48 43                   \ swap    d3
 42 43                   \ clr.w   d3
 d4 83                   \ add.l   d3,d2
 48 40                   \ swap    d0
 c0 c1                   \ mulu    d1,d0
 48 40                   \ swap    d0
 42 40                   \ clr.w   d0
 d0 82                   \ add.l   d2,d0
 2c 80                   \ move.l  d0,(a6)
end-code

code =
 20 1e                   \ move.l  (a6)+,d0
 b0 96                   \ cmp.l   (a6),d0
 57 c0                   \ seq     d0
 48 80                   \ ext.w   d0
 48 c0                   \ ext.l   d0
 2c 80                   \ move.l  d0,(a6)
end-code

code <>
 20 1e                   \ move.l  (a6)+,d0
 b0 96                   \ cmp.l   (a6),d0
 56 c0                   \ sne     d0
 48 80                   \ ext.w   d0
 48 c0                   \ ext.l   d0
 2c 80                   \ move.l  d0,(a6)
end-code

code u<
 20 1e                   \ move.l  (a6)+,d0
 b0 96                   \ cmp.l   (a6),d0
 52 c0                   \ shi     d0
 48 80                   \ ext.w   d0
 48 c0                   \ ext.l   d0
 2c 80                   \ move.l  d0,(a6)
end-code

code u>
 20 1e                   \ move.l  (a6)+,d0
 b0 96                   \ cmp.l   (a6),d0
 55 c0                   \ scs     d0
 48 80                   \ ext.w   d0
 48 c0                   \ ext.l   d0
 2c 80                   \ move.l  d0,(a6)
end-code

code <
 20 1e                   \ move.l  (a6)+,d0
 b0 96                   \ cmp.l   (a6),d0
 5e c0                   \ sgt     d0
 48 80                   \ ext.w   d0
 48 c0                   \ ext.l   d0
 2c 80                   \ move.l  d0,(a6)
end-code

code >
 20 1e                   \ move.l  (a6)+,d0
 b0 96                   \ cmp.l   (a6),d0
 5d c0                   \ slt     d0
 48 80                   \ ext.w   d0
 48 c0                   \ ext.l   d0
 2c 80                   \ move.l  d0,(a6)
end-code

code <=
 20 1e                   \ move.l  (a6)+,d0
 b0 96                   \ cmp.l   (a6),d0
 5c c0                   \ sge     d0
 48 80                   \ ext.w   d0
 48 c0                   \ ext.l   d0
 2c 80                   \ move.l  d0,(a6)
end-code

code >=
 20 1e                   \ move.l  (a6)+,d0
 b0 96                   \ cmp.l   (a6),d0
 5f c0                   \ sle     d0
 48 80                   \ ext.w   d0
 48 c0                   \ ext.l   d0
 2c 80                   \ move.l  d0,(a6)
end-code

code 0=
 4a 96                   \ tst.l   (a6)
 57 c0                   \ seq     d0
 48 80                   \ ext.w   d0
 48 c0                   \ ext.l   d0
 2c 80                   \ move.l  d0,(a6)
end-code

code 0<>
 4a 96                   \ tst.l   (a6)
 56 c0                   \ sne     d0
 48 80                   \ ext.w   d0
 48 c0                   \ ext.l   d0
 2c 80                   \ move.l  d0,(a6)
end-code

code 0<
 4a 96                   \ tst.l   (a6)
 5d c0                   \ slt     d0
 48 80                   \ ext.w   d0
 48 c0                   \ ext.l   d0
 2c 80                   \ move.l  d0,(a6)
end-code

code 0>
 4a 96                   \ tst.l   (a6)
 5e c0                   \ sgt     d0
 48 80                   \ ext.w   d0
 48 c0                   \ ext.l   d0
 2c 80                   \ move.l  d0,(a6)
end-code

code and
 20 1e                   \ move.l  (a6)+,d0
 c1 96                   \ and.l   d0,(a6)
end-code

code or
 20 1e                   \ move.l  (a6)+,d0
 81 96                   \ or.l    d0,(a6)
end-code

code xor
 20 1e                   \ move.l  (a6)+,d0
 b1 96                   \ eor.l   d0,(a6)
end-code

code invert
 46 96                   \ not.l   (a6)
end-code

code exit
 4e 75                   \ rts
end-code compile-only

code !
 20 5e                   \ move.l  (a6)+,a0
 20 1e                   \ move.l  (a6)+,d0
 20 80                   \ move.l  d0,(a0)
end-code

code @
 20 56                   \ move.l  (a6),a0
 2c 90                   \ move.l  (a0),(a6)
end-code

code +!
 20 5e                   \ move.l  (a6)+,a0
 20 1e                   \ move.l  (a6)+,d0
 d1 90                   \ add.l   d0,(a0)
end-code

code -!
 20 5e                   \ move.l  (a6)+,a0
 20 1e                   \ move.l  (a6)+,d0
 91 90                   \ sub.l   d0,(a0)
end-code

code c!
 20 5e                   \ move.l  (a6)+,a0
 20 1e                   \ move.l  (a6)+,d0
 10 80                   \ move.b  d0,(a0)
end-code

code c@
 20 56                   \ move.l  (a6),a0
 42 96                   \ clr.l   (a6)
 1d 50 00 03             \ move.b  (a0),3(a6)
end-code

code >r
 2f 1e                   \ move.l  (a6)+,-(sp)
end-code compile-only

code r>
 2d 1f                   \ move.l  (sp)+,-(a6)
end-code compile-only

code r@
 2d 17                   \ move.l  (sp),-(a6)
end-code compile-only

code execute
 20 5e                   \ move.l  (a6)+,a0
 4e 90                   \ bsr     (a0)
end-code

code rp@
 2d 0f                   \ move.l  sp,-(a6)
end-code

code rp!
 2e 5e                   \ move.l  (a6)+,sp
end-code

code 2>r
 20 1e                   \ move.l  (a6)+,d0
 2f 1e                   \ move.l  (a6)+,-(sp)
 2f 00                   \ move.l  d0,-(sp)
end-code compile-only

code 2r>
 20 1f                   \ move.l  (sp)+,d0
 2d 1f                   \ move.l  (sp)+,-(a6)
 2d 00                   \ move.l  d0,-(a6)
end-code compile-only

code 2r@
 2d 2f 00 04             \ move.l  4(sp),-(a6)
 2d 17                   \ move.l  (sp),-(a6)
end-code compile-only

code rdrop
 58 8f                   \ addq.l  #4,sp
end-code compile-only

code 2rdrop
 50 8f                   \ addq.l  #8,sp
end-code compile-only

code sp!
 2c 56                   \ move.l  (a6),a6
 58 8e                   \ addq.l  #4,a6 \ FIXME ???
end-code

code sp@
 59 8e                   \ subq.l  #4,a6
 2c 8e                   \ move.l  a6,(a6)
end-code

code i
 20 17                   \ move.l  (sp),d0
 d0 af 00 04             \ add.l   4(sp),d0
 2d 00                   \ move.l  d0,-(a6)
end-code compile-only

code j
 20 2f 00 08             \ move.l  8(sp),d0
 d0 af 00 0c             \ add.l   12(sp),d0
 2d 00                   \ move.l  d0,-(a6)
end-code compile-only

code k
 20 2f 00 10             \ move.l  16(sp),d0
 d0 af 00 14             \ add.l   20(sp),d0
 2d 00                   \ move.l  d0,-(a6)
end-code compile-only

code (do)
 20 1f                   \ move.l  (sp)+,d0
 22 1f                   \ move.l  (sp)+,d1
 06 81 80 00 00 00       \ add.l   #$80000000,d1
 90 81                   \ sub.l   d1,d0
 2f 01                   \ move.l  d1,-(sp)
 2f 00                   \ move.l  d0,-(sp)
end-code

code (+loop)
 20 16                   \ move.l  (a6),d0
 d1 97                   \ add.l   d0,(sp)
 59 c0                   \ svs     d0
 48 80                   \ ext.w   d0
 48 c0                   \ ext.l   d0
 2c 80                   \ move.l  d0,(a6)
end-code

: chars ; inline
: cell 4 ; inline
: cell- 4- ; inline
: cell+ 4+ ; inline
: cells 2 lshift ; inline
: bits/cell 32 ; inline

: abs ( n -- n ) dup 0< if negate then ;
: dnegate ( d -- d ) invert >r invert 1 um+ r> + ; \ FIXME negx

include kernel/division.fth
include kernel/multiplication.fth

: cmove ( c-addr1 c-addr2 u -- )
   over + swap ?do dup 1+ swap c@ i c! loop drop ;

: nip ( x1 x2 -- x2 ) swap drop ; inline \ FIXME

include kernel/nucleus.fth
