\ test/test-numeric.fth tests a 128 character binary number on 64 bit systems.
256 constant pic# \ Character capacity of pictured numeric.
variable hld
0 value pic
here to pic pic# allot

: <#   ( ud -- ud )       pic pic# + hld ! ;
: hold (  c -- )          1 hld -! hld @ c! ;
: #    ( ud -- ud )       base @ udm/mod rot digit> hold ;
: #s   ( ud -- 0 0 )      begin # 2dup d0= until ;
: sign (  n -- )          0< if '-' hold then ;
: #>   ( ud -- c-addr u ) 2drop hld @ pic pic# + over - ;
