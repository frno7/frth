\ The BASIS word determines the absolute address of itself using the
\ program counter. The adjustment constant takes preceding dictionary
\ storage into account. By placing the word first the program entry
\ point will be given which is useful for relocation.
code basis ( -- addr )
 e8 00 00 00 00          \ db   0xe8,0,0,0,0 ; call +0
 58                      \ pop  eax
 2d 19 00 00 00          \ sub  eax,25 ; Adjustment constant.
 89 45 fc                \ mov  [ebp-4],eax
 8d 6d fc                \ lea  ebp,[ebp-4]
end-code noninline

code init \ Provisional 16384 bytes return stack.
 fc                      \ cld
 8d ac 24 00 c0 ff ff    \ lea ebp,[esp-0x4000]
end-code

init

code drop
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code swap
 8b 45 00                \ mov  eax,[ebp]
 8b 5d 04                \ mov  ebx,[ebp+4]
 89 5d 00                \ mov  [ebp],ebx
 89 45 04                \ mov  [ebp+4],eax
end-code

code dup
 8b 45 00                \ mov  eax,[ebp]
 89 45 fc                \ mov  [ebp-4],eax
 8d 6d fc                \ lea  ebp,[ebp-4]
end-code

code over
 8b 45 04                \ mov  eax,[ebp+4]
 89 45 fc                \ mov  [ebp-4],eax
 8d 6d fc                \ lea  ebp,[ebp-4]
end-code

code rot
 8b 45 00                \ mov  eax,[ebp]
 8b 5d 04                \ mov  ebx,[ebp+4]
 8b 4d 08                \ mov  ecx,[ebp+8]
 89 4d 00                \ mov  [ebp],ecx
 89 45 04                \ mov  [ebp+4],eax
 89 5d 08                \ mov  [ebp+8],ebx
end-code

code -rot
 8b 45 00                \ mov  eax,[ebp]
 8b 5d 04                \ mov  ebx,[ebp+4]
 8b 4d 08                \ mov  ecx,[ebp+8]
 89 5d 00                \ mov  [ebp],ebx
 89 4d 04                \ mov  [ebp+4],ecx
 89 45 08                \ mov  [ebp+8],eax
end-code

code 2drop
 8d 6d 08                \ lea  ebp,[ebp+8]
end-code

code 2dup
 8b 45 00                \ mov  eax,[ebp]
 8b 5d 04                \ mov  ebx,[ebp+4]
 89 45 f8                \ mov  [ebp-8],eax
 89 5d fc                \ mov  [ebp-4],ebx
 8d 6d f8                \ lea  ebp,[ebp-8]
end-code

code 2swap
 8b 45 00                \ mov  eax,[ebp]
 8b 5d 04                \ mov  ebx,[ebp+4]
 8b 4d 08                \ mov  ecx,[ebp+8]
 8b 55 0c                \ mov  edx,[ebp+12]
 89 4d 00                \ mov  [ebp],ecx
 89 55 04                \ mov  [ebp+4],edx
 89 45 08                \ mov  [ebp+8],eax
 89 5d 0c                \ mov  [ebp+12],ebx
end-code

code ?dup
 8b 45 00                \ mov  eax,[ebp]
 85 c0                   \ test eax,eax
 74 06                   \ db   0x74,0x06 ; je +6
 8d 6d fc                \ lea  ebp,[ebp-4]
 89 45 00                \ mov  [ebp],eax
end-code

code 2** ( n n -- n ) \ Power of 2.
 8a 4d 00                \ mov  cl,[ebp]
 84 c9                   \ test cl,cl
 78 05                   \ db   0x78,0x05 ; js +5
 d3 65 04                \ sal  dword [ebp+4],cl
$eb 05                   \ db   0xeb,0x05 ; jmp +5
 f6 d9                   \ neg cl
 d3 7d 04                \ sar  dword [ebp+4],cl
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code rshift
 8a 4d 00                \ mov  cl,[ebp]
 d3 6d 04                \ shr  dword [ebp+4],cl
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code lshift
 8a 4d 00                \ mov  cl,[ebp]
 d3 65 04                \ shl  dword [ebp+4],cl
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code 1+
 83 45 00 01             \ add  dword [ebp],1
end-code

code 1-
 83 6d 00 01             \ sub  dword [ebp],1
end-code

code 4+
 83 45 00 04             \ add  dword [ebp],4
end-code

code 4-
 83 6d 00 04             \ sub  dword [ebp],4
end-code

code 8+
 83 45 00 08             \ add  dword [ebp],8
end-code

code 8-
 83 6d 00 08             \ sub  dword [ebp],8
end-code

code +
 8b 45 00                \ mov  eax,[ebp]
 01 45 04                \ add  [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code um+
 31 db                   \ xor  ebx,ebx
 8b 45 00                \ mov  eax,[ebp]
 01 45 04                \ add  [ebp+4],eax
 0f 92 c3                \ setb bl
 89 5d 00                \ mov  [ebp],ebx
end-code

code -
 8b 45 00                \ mov  eax,[ebp]
 29 45 04                \ sub  [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code m* ( u1 u2 -- du )
 8b 45 00                \ mov  eax,[ebp]
 f7 6d 04                \ imul dword [ebp+4]
 89 45 04                \ mov  [ebp+4],eax
 89 55 00                \ mov  [ebp],edx
end-code

code um* ( u1 u2 -- du )
 8b 45 00                \ mov  eax,[ebp]
 f7 65 04                \ mul  dword [ebp+4]
 89 45 04                \ mov  [ebp+4],eax
 89 55 00                \ mov  [ebp],edx
end-code

code /mod
 8b 45 04                \ mov  eax,[ebp+4]
 8b 5d 00                \ mov  ebx,[ebp]
 99                      \ cdq
 f7 fb                   \ idiv ebx
 89 55 04                \ mov  [ebp+4],edx
 89 45 00                \ mov  [ebp],eax
end-code

code um/mod ( ud u -- u u )
 8b 45 08                \ mov  eax,[ebp+8]
 8b 55 04                \ mov  edx,[ebp+4]
 f7 75 00                \ div  dword [ebp]
 89 45 04                \ mov  [ebp+4],eax
 89 55 08                \ mov  [ebp+8],edx
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code =
 8b 45 00                \ mov  eax,[ebp]
 39 45 04                \ cmp  [ebp+4],eax
 0f 95 c0                \ setne al
 0f b6 c0                \ movzx eax,al
 48                      \ dec  eax
 89 45 04                \ mov  [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code <>
 8b 45 00                \ mov  eax,[ebp]
 39 45 04                \ cmp  [ebp+4],eax
 0f 94 c0                \ sete al
 0f b6 c0                \ movzx eax,al
 48                      \ dec  eax
 89 45 04                \ mov  [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code <
 8b 45 00                \ mov  eax,[ebp]
 39 45 04                \ cmp  [ebp+4],eax
 0f 9d c0                \ setge al
 0f b6 c0                \ movzx eax,al
 48                      \ dec  eax
 89 45 04                \ mov  [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code >
 8b 45 00                \ mov  eax,[ebp]
 39 45 04                \ cmp  [ebp+4],eax
 0f 9e c0                \ setle al
 0f b6 c0                \ movzx eax,al
 48                      \ dec  eax
 89 45 04                \ mov  [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code <=
 8b 45 00                \ mov  eax,[ebp]
 39 45 04                \ cmp  [ebp+4],eax
 0f 9f c0                \ setg al
 0f b6 c0                \ movzx eax,al
 48                      \ dec  eax
 89 45 04                \ mov  [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code >=
 8b 45 00                \ mov  eax,[ebp]
 39 45 04                \ cmp  [ebp+4],eax
 0f 9c c0                \ setl al
 0f b6 c0                \ movzx eax,al
 48                      \ dec  eax
 89 45 04                \ mov  [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code u<
 8b 45 00                \ mov  eax,[ebp]
 39 45 04                \ cmp  [ebp+4],eax
 0f 93 c0                \ setae al
 0f b6 c0                \ movzx eax,al
 48                      \ dec  eax
 89 45 04                \ mov  [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code u>
 8b 45 00                \ mov  eax,[ebp]
 39 45 04                \ cmp  [ebp+4],eax
 0f 96 c0                \ setbe al
 0f b6 c0                \ movzx eax,al
 48                      \ dec  eax
 89 45 04                \ mov  [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code 0=
 8b 45 00                \ mov  eax,[ebp]
 85 c0                   \ test eax,eax
 0f 95 c0                \ setne al
 0f b6 c0                \ movzx eax,al
 48                      \ dec  eax
 89 45 00                \ mov  [ebp],eax
end-code

code 0<>
 8b 45 00                \ mov  eax,[ebp]
 85 c0                   \ test eax,eax
 0f 94 c0                \ sete al
 0f b6 c0                \ movzx eax,al
 48                      \ dec  eax
 89 45 00                \ mov  [ebp],eax
end-code

code 0<
 8b 45 00                \ mov  eax,[ebp]
 85 c0                   \ test eax,eax
 0f 9d c0                \ setge al
 0f b6 c0                \ movzx eax,al
 48                      \ dec  eax
 89 45 00                \ mov  [ebp],eax
end-code

code 0>
 8b 45 00                \ mov  eax,[ebp]
 85 c0                   \ test eax,eax
 0f 9e c0                \ setle al
 0f b6 c0                \ movzx eax,al
 48                      \ dec  eax
 89 45 00                \ mov  [ebp],eax
end-code

code and
 8b 45 00                \ mov  eax,[ebp]
 21 45 04                \ and  [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code or
 8b 45 00                \ mov  eax,[ebp]
 09 45 04                \ or   [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code xor
 8b 45 00                \ mov  eax,[ebp]
 31 45 04                \ xor  [ebp+4],eax
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code invert
 f7 55 00                \ not  dword [ebp]
end-code

code exit
 c3                      \ ret
end-code compile-only

code !
 8b 45 00                \ mov  eax,[ebp]
 8b 5d 04                \ mov  ebx,[ebp+4]
 89 18                   \ mov  [eax],ebx
 8d 6d 08                \ lea  ebp,[ebp+8]
end-code

code @
 8b 45 00                \ mov  eax,[ebp]
 8b 18                   \ mov  ebx,[eax]
 89 5d 00                \ mov  [ebp],ebx
end-code

code +!
 8b 5d 00                \ mov  ebx,[ebp]
 8b 45 04                \ mov  eax,[ebp+4]
 01 03                   \ add  [ebx],eax
 8d 6d 08                \ lea  ebp,[ebp+8]
end-code

code -!
 8b 5d 00                \ mov  ebx,[ebp]
 8b 45 04                \ mov  eax,[ebp+4]
 29 03                   \ sub  [ebx],eax
 8d 6d 08                \ lea  ebp,[ebp+8]
end-code

code c!
 8b 5d 00                \ mov  ebx,[ebp]
 8b 45 04                \ mov  eax,[ebp+4]
 88 03                   \ mov  [ebx],al
 8d 6d 08                \ lea  ebp,[ebp+8]
end-code

code c@
 8b 5d 00                \ mov  ebx,[ebp]
 31 c0                   \ xor  eax,eax
 8a 03                   \ mov  al,[ebx]
 89 45 00                \ mov  [ebp],eax
end-code

code cmove
 8b 4d 00                \ mov  ecx,[ebp]
 8b 7d 04                \ mov  edi,[ebp+4]
 8b 75 08                \ mov  esi,[ebp+8]
 f3 a4                   \ rep  movsb
 8d 6d 0c                \ lea  ebp,[ebp+12]
end-code

code >r
 8b 45 00                \ mov  eax,[ebp]
 8d 6d 04                \ lea  ebp,[ebp+4]
 50                      \ push eax
end-code compile-only

code r>
 58                      \ pop  eax
 89 45 fc                \ mov  [ebp-4],eax
 8d 6d fc                \ lea  ebp,[ebp-4]
end-code compile-only

code r@
 8b 04 24                \ mov  eax,[esp]
 89 45 fc                \ mov  [ebp-4],eax
 8d 6d fc                \ lea  ebp,[ebp-4]
end-code compile-only

code execute
 8b 45 00                \ mov  eax,[ebp]
 8d 6d 04                \ lea  ebp,[ebp+4]
 83 c0 04                \ add  eax,4
 ff d0                   \ call eax
end-code

code rp@
 89 65 fc                \ mov  [ebp-4],esp
 8d 6d fc                \ lea  ebp,[ebp-4]
end-code

code rp!
 8b 65 00                \ mov  esp,[ebp]
 8d 6d 04                \ lea  ebp,[ebp+4]
end-code

code 2>r
 8b 45 04                \ mov  eax,[ebp+4]
 8b 5d 00                \ mov  ebx,[ebp]
 8d 6d 08                \ lea  ebp,[ebp+8]
 50                      \ push eax
 53                      \ push ebx
end-code compile-only

code 2r>
 58                      \ pop  eax
 5b                      \ pop  ebx
 89 45 f8                \ mov  [ebp-8],eax
 89 5d fc                \ mov  [ebp-4],ebx
 8d 6d f8                \ lea  ebp,[ebp-8]
end-code compile-only

code 2r@
 8b 04 24                \ mov  eax,[esp]
 8b 5c 24 04             \ mov  ebx,[esp+4]
 89 45 f8                \ mov  [ebp-8],eax
 89 5d fc                \ mov  [ebp-4],ebx
 8d 6d f8                \ lea  ebp,[ebp-8]
end-code compile-only

code rdrop
 83 c4 04                \ add  esp,4
end-code compile-only

code 2rdrop
 83 c4 08                \ add  esp,8
end-code compile-only

code sp!
 8b 6d 00                \ mov  ebp,[ebp]
 8d 6d 04                \ lea  ebp,[ebp+4] ; FIXME ???
end-code

code sp@
 8d 6d fc                \ lea  ebp,[ebp-4]
 89 6d 00                \ mov  [ebp],ebp
end-code

code i
 8b 04 24                \ mov  eax,[esp]
 03 44 24 04             \ add  eax,[esp+4]
 89 45 fc                \ mov  [ebp-4],eax
 8d 6d fc                \ lea  ebp,[ebp-4]
end-code compile-only

code j
 8b 44 24 08             \ mov  eax,[esp+8]
 03 44 24 0c             \ add  eax,[esp+12]
 89 45 fc                \ mov  [ebp-4],eax
 8d 6d fc                \ lea  ebp,[ebp-4]
end-code compile-only

code k
 8b 44 24 10             \ mov  eax,[esp+16]
 03 44 24 14             \ add  eax,[esp+20]
 89 45 fc                \ mov  [ebp-4],eax
 8d 6d fc                \ lea  ebp,[ebp-4]
end-code compile-only

code (do)
 58                      \ pop  eax
 5b                      \ pop  ebx
 81 c3 00 00 00 80       \ add  ebx,0x80000000
 29 d8                   \ sub  eax,ebx
 53                      \ push ebx
 50                      \ push eax
end-code

code (+loop)
 8b 45 00                \ mov  eax,[ebp]
 01 04 24                \ add  [esp],eax
 0f 91 c0                \ setno al
 0f b6 c0                \ movzx eax,al
 48                      \ dec  eax
 89 45 00                \ mov  [ebp],eax
end-code

: chars ; inline
: cell 4 ; inline
: cell- 4- ; inline
: cell+ 4+ ; inline
: cells 2 lshift ; inline

: nip ( x1 x2 -- x2 ) swap drop ; inline \ FIXME

: * ( n n -- n ) um* drop ; inline
: / ( n n -- n n ) /mod nip ; inline
: mod ( n n -- n ) /mod drop ; inline
: negate ( u -- u ) invert 1+ ; inline
: dnegate ( d -- d ) invert >r invert 1 um+ r> + ; \ FIXME negx
: abs ( n -- n ) dup 0< if negate then ; inline

include kernel/nucleus.fth
