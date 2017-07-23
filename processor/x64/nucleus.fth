\ The BASIS word determines the absolute address of itself using the
\ program counter. The adjustment constant takes preceding dictionary
\ storage into account. By placing the word first the program entry
\ point will be given which is useful for relocation.
code basis ( -- addr )
 e8 00 00 00 00          \ db   0xe8,0,0,0,0 ; call +0
 58                      \ pop  rax
 48 83 e8 1d             \ sub  rax,29 ; Adjustment constant.
 48 89 45 f8             \ mov  [rbp-8],rax
 48 8d 6d f8             \ lea  rbp,[rbp-8]
end-code noninline

code init \ Provisional 16384 bytes return stack.
 fc                      \ cld
 48 8d ac 24 00 c0 ff ff \ lea rbp,[rsp-0x4000]
end-code

init

code drop
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code swap
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 5d 08             \ mov  rbx,[rbp+8]
 48 89 5d 00             \ mov  [rbp],rbx
 48 89 45 08             \ mov  [rbp+8],rax
end-code

code dup
 48 8b 45 00             \ mov  rax,[rbp]
 48 89 45 f8             \ mov  [rbp-8],rax
 48 8d 6d f8             \ lea  rbp,[rbp-8]
end-code

code over
 48 8b 45 08             \ mov  rax,[rbp+8]
 48 89 45 f8             \ mov  [rbp-8],rax
 48 8d 6d f8             \ lea  rbp,[rbp-8]
end-code

code rot
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 5d 08             \ mov  rbx,[rbp+8]
 48 8b 4d 10             \ mov  rcx,[rbp+16]
 48 89 4d 00             \ mov  [rbp],rcx
 48 89 45 08             \ mov  [rbp+8],rax
 48 89 5d 10             \ mov  [rbp+16],rbx
end-code

code -rot
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 5d 08             \ mov  rbx,[rbp+8]
 48 8b 4d 10             \ mov  rcx,[rbp+16]
 48 89 5d 00             \ mov  [rbp],rbx
 48 89 4d 08             \ mov  [rbp+8],rcx
 48 89 45 10             \ mov  [rbp+16],rax
end-code

code 2drop
 48 8d 6d 10             \ lea  rbp,[rbp+16]
end-code

code 2dup
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 5d 08             \ mov  rbx,[rbp+8]
 48 89 45 f0             \ mov  [rbp-16],rax
 48 89 5d f8             \ mov  [rbp-8],rbx
 48 8d 6d f0             \ lea  rbp,[rbp-16]
end-code

code 2swap
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 5d 08             \ mov  rbx,[rbp+8]
 48 8b 4d 10             \ mov  rcx,[rbp+16]
 48 8b 55 18             \ mov  rdx,[rbp+24]
 48 89 4d 00             \ mov  [rbp],rcx
 48 89 55 08             \ mov  [rbp+8],rdx
 48 89 45 10             \ mov  [rbp+16],rax
 48 89 5d 18             \ mov  [rbp+24],rbx
end-code

code ?dup
 48 8b 45 00             \ mov  rax,[rbp]
 48 85 c0                \ test rax,rax
 74 08                   \ db   0x74,0x08 ; je +8
 48 8d 6d f8             \ lea  rbp,[rbp-8]
 48 89 45 00             \ mov  [rbp],rax
end-code

code 2** ( n n -- n ) \ Power of 2.
 8a 4d 00                \ mov  cl,[rbp]
 84 c9                   \ test cl,cl
 78 06                   \ db   0x78,0x06 ; js +6
 48 d3 65 08             \ sal  qword [rbp+8],cl
$eb 06                   \ db   0xeb,0x06 ; jmp +6
 f6 d9                   \ neg cl
 48 d3 7d 08             \ sar  qword [rbp+8],cl
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code rshift
 8a 4d 00                \ mov  cl,[rbp]
 48 d3 6d 08             \ shr  qword [rbp+8],cl
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code lshift
 8a 4d 00                \ mov  cl,[rbp]
 48 d3 65 08             \ shl  qword [rbp+8],cl
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code 1+
 48 83 45 00 01          \ add  qword [rbp],1
end-code

code 1-
 48 83 6d 00 01          \ sub  qword [rbp],1
end-code

code 4+
 48 83 45 00 04          \ add  qword [rbp],4
end-code

code 4-
 48 83 6d 00 04          \ sub  qword [rbp],4
end-code

code 8+
 48 83 45 00 08          \ add  qword [rbp],8
end-code

code 8-
 48 83 6d 00 08          \ sub  qword [rbp],8
end-code

code +
 48 8b 45 00             \ mov  rax,[rbp]
 48 01 45 08             \ add  [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code um+
 48 31 db                \ xor  rbx,rbx
 48 8b 45 00             \ mov  rax,[rbp]
 48 01 45 08             \ add  [rbp+8],rax
 0f 92 c3                \ setb bl
 48 89 5d 00             \ mov  [rbp],rbx
end-code

code -
 48 8b 45 00             \ mov  rax,[rbp]
 48 29 45 08             \ sub  [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code m* ( u1 u2 -- du )
 48 8b 45 00             \ mov  rax,[rbp]
 48 f7 6d 08             \ imul qword [rbp+8]
 48 89 45 08             \ mov  [rbp+8],rax
 48 89 55 00             \ mov  [rbp],rdx
end-code

code um* ( u1 u2 -- du )
 48 8b 45 00             \ mov  rax,[rbp]
 48 f7 65 08             \ mul  qword [rbp+8]
 48 89 45 08             \ mov  [rbp+8],rax
 48 89 55 00             \ mov  [rbp],rdx
end-code

code /mod
 48 8b 45 08             \ mov  rax,[rbp+8]
 48 8b 5d 00             \ mov  rbx,[rbp]
 48 99                   \ cqo
 48 f7 fb                \ idiv rbx
 48 89 55 08             \ mov  [rbp+8],rdx
 48 89 45 00             \ mov  [rbp],rax
end-code

code um/mod ( ud u -- u u )
 48 8b 45 10             \ mov  rax,[rbp+16]
 48 8b 55 08             \ mov  rdx,[rbp+8]
 48 f7 75 00             \ div  qword [rbp]
 48 89 45 08             \ mov  [rbp+8],rax
 48 89 55 10             \ mov  [rbp+16],rdx
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code =
 48 8b 45 00             \ mov  rax,[rbp]
 48 39 45 08             \ cmp  [rbp+8],rax
 0f 95 c0                \ setne al
 48 0f b6 c0             \ movzx rax,al
 48 ff c8                \ dec  rax
 48 89 45 08             \ mov  [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code <>
 48 8b 45 00             \ mov  rax,[rbp]
 48 39 45 08             \ cmp  [rbp+8],rax
 0f 94 c0                \ sete al
 48 0f b6 c0             \ movzx rax,al
 48 ff c8                \ dec  rax
 48 89 45 08             \ mov  [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code <
 48 8b 45 00             \ mov  rax,[rbp]
 48 39 45 08             \ cmp  [rbp+8],rax
 0f 9d c0                \ setge al
 48 0f b6 c0             \ movzx rax,al
 48 ff c8                \ dec  rax
 48 89 45 08             \ mov  [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code >
 48 8b 45 00             \ mov  rax,[rbp]
 48 39 45 08             \ cmp  [rbp+8],rax
 0f 9e c0                \ setle al
 48 0f b6 c0             \ movzx rax,al
 48 ff c8                \ dec  rax
 48 89 45 08             \ mov  [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code <=
 48 8b 45 00             \ mov  rax,[rbp]
 48 39 45 08             \ cmp  [rbp+8],rax
 0f 9f c0                \ setg al
 48 0f b6 c0             \ movzx rax,al
 48 ff c8                \ dec  rax
 48 89 45 08             \ mov  [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code >=
 48 8b 45 00             \ mov  rax,[rbp]
 48 39 45 08             \ cmp  [rbp+8],rax
 0f 9c c0                \ setl al
 48 0f b6 c0             \ movzx rax,al
 48 ff c8                \ dec  rax
 48 89 45 08             \ mov  [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code u<
 48 8b 45 00             \ mov  rax,[rbp]
 48 39 45 08             \ cmp  [rbp+8],rax
 0f 93 c0                \ setae al
 48 0f b6 c0             \ movzx rax,al
 48 ff c8                \ dec  rax
 48 89 45 08             \ mov  [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code u>
 48 8b 45 00             \ mov  rax,[rbp]
 48 39 45 08             \ cmp  [rbp+8],rax
 0f 96 c0                \ setbe al
 48 0f b6 c0             \ movzx rax,al
 48 ff c8                \ dec  rax
 48 89 45 08             \ mov  [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code 0=
 48 8b 45 00             \ mov  rax,[rbp]
 48 85 c0                \ test rax,rax
 0f 95 c0                \ setne al
 48 0f b6 c0             \ movzx rax,al
 48 ff c8                \ dec  rax
 48 89 45 00             \ mov  [rbp],rax
end-code

code 0<>
 48 8b 45 00             \ mov  rax,[rbp]
 48 85 c0                \ test rax,rax
 0f 94 c0                \ sete al
 48 0f b6 c0             \ movzx rax,al
 48 ff c8                \ dec  rax
 48 89 45 00             \ mov  [rbp],rax
end-code

code 0<
 48 8b 45 00             \ mov  rax,[rbp]
 48 85 c0                \ test rax,rax
 0f 9d c0                \ setge al
 48 0f b6 c0             \ movzx rax,al
 48 ff c8                \ dec  rax
 48 89 45 00             \ mov  [rbp],rax
end-code

code 0>
 48 8b 45 00             \ mov  rax,[rbp]
 48 85 c0                \ test rax,rax
 0f 9e c0                \ setle al
 48 0f b6 c0             \ movzx rax,al
 48 ff c8                \ dec  rax
 48 89 45 00             \ mov  [rbp],rax
end-code

code and
 48 8b 45 00             \ mov  rax,[rbp]
 48 21 45 08             \ and  [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code or
 48 8b 45 00             \ mov  rax,[rbp]
 48 09 45 08             \ or   [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code xor
 48 8b 45 00             \ mov  rax,[rbp]
 48 31 45 08             \ xor  [rbp+8],rax
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code invert
 48 f7 55 00             \ not  qword [rbp]
end-code

code exit
 c3                      \ ret
end-code compile-only

code !
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 5d 08             \ mov  rbx,[rbp+8]
 48 89 18                \ mov  [rax],rbx
 48 8d 6d 10             \ lea  rbp,[rbp+16]
end-code

code @
 48 8b 45 00             \ mov  rax,[rbp]
 48 8b 18                \ mov  rbx,[rax]
 48 89 5d 00             \ mov  [rbp],rbx
end-code

code +!
 48 8b 5d 00             \ mov  rbx,[rbp]
 48 8b 45 08             \ mov  rax,[rbp+8]
 48 01 03                \ add  [rbx],rax
 48 8d 6d 10             \ lea  rbp,[rbp+16]
end-code

code -!
 48 8b 5d 00             \ mov  rbx,[rbp]
 48 8b 45 08             \ mov  rax,[rbp+8]
 48 29 03                \ sub  [rbx],rax
 48 8d 6d 10             \ lea  rbp,[rbp+16]
end-code

code c!
 48 8b 5d 00             \ mov  rbx,[rbp]
 48 8b 45 08             \ mov  rax,[rbp+8]
 88 03                   \ mov  [rbx],al
 48 8d 6d 10             \ lea  rbp,[rbp+16]
end-code

code c@
 48 8b 5d 00             \ mov  rbx,[rbp]
 48 31 c0                \ xor  rax,rax
 8a 03                   \ mov  al,[rbx]
 48 89 45 00             \ mov  [rbp],rax
end-code

code cmove
 48 8b 4d 00             \ mov  rcx,[rbp]
 48 8b 7d 08             \ mov  rdi,[rbp+8]
 48 8b 75 10             \ mov  rsi,[rbp+16]
 f3 a4                   \ rep  movsb
 48 8d 6d 18             \ lea  rbp,[rbp+24]
end-code

code >r
 48 8b 45 00             \ mov  rax,[rbp]
 48 8d 6d 08             \ lea  rbp,[rbp+8]
 50                      \ push rax
end-code compile-only

code r>
 58                      \ pop  rax
 48 89 45 f8             \ mov  [rbp-8],rax
 48 8d 6d f8             \ lea  rbp,[rbp-8]
end-code compile-only

code r@
 48 8b 04 24             \ mov  rax,[rsp]
 48 89 45 f8             \ mov  [rbp-8],rax
 48 8d 6d f8             \ lea  rbp,[rbp-8]
end-code compile-only

code execute
 48 8b 45 00             \ mov  rax,[rbp]
 48 8d 6d 08             \ lea  rbp,[rbp+8]
 48 83 c0 08             \ add  rax,8
 ff d0                   \ call rax
end-code

code rp@
 48 89 65 f8             \ mov  [rbp-8],rsp
 48 8d 6d f8             \ lea  rbp,[rbp-8]
end-code

code rp!
 48 8b 65 00             \ mov  rsp,[rbp]
 48 8d 6d 08             \ lea  rbp,[rbp+8]
end-code

code 2>r
 48 8b 45 08             \ mov  rax,[rbp+8]
 48 8b 5d 00             \ mov  rbx,[rbp]
 48 8d 6d 10             \ lea  rbp,[rbp+16]
 50                      \ push rax
 53                      \ push rbx
end-code compile-only

code 2r>
 58                      \ pop  rax
 5b                      \ pop  rbx
 48 89 45 f0             \ mov  [rbp-16],rax
 48 89 5d f8             \ mov  [rbp-8],rbx
 48 8d 6d f0             \ lea  rbp,[rbp-16]
end-code compile-only

code 2r@
 48 8b 04 24             \ mov  rax,[rsp]
 48 8b 5c 24 08          \ mov  rbx,[rsp+8]
 48 89 45 f0             \ mov  [rbp-16],rax
 48 89 5d f8             \ mov  [rbp-8],rbx
 48 8d 6d f0             \ lea  rbp,[rbp-16]
end-code compile-only

code rdrop
 48 83 c4 08             \ add  rsp,8
end-code compile-only

code 2rdrop
 48 83 c4 10             \ add  rsp,16
end-code compile-only

code sp!
 48 8b 6d 00             \ mov  rbp,[rbp]
 48 8d 6d 08             \ lea  rbp,[rbp+8] ; FIXME ???
end-code

code sp@
 48 8d 6d f8             \ lea  rbp,[rbp-8]
 48 89 6d 00             \ mov  [rbp],rbp
end-code

code i
 48 8b 04 24             \ mov  rax,[rsp]
 48 03 44 24 08          \ add  rax,[rsp+8]
 48 89 45 f8             \ mov  [rbp-8],rax
 48 8d 6d f8             \ lea  rbp,[rbp-8]
end-code compile-only

code j
 48 8b 44 24 10          \ mov  rax,[rsp+16]
 48 03 44 24 18          \ add  rax,[rsp+24]
 48 89 45 f8             \ mov  [rbp-8],rax
 48 8d 6d f8             \ lea  rbp,[rbp-8]
end-code compile-only

code k
 48 8b 44 24 20          \ mov  rax,[rsp+32]
 48 03 44 24 28          \ add  rax,[rsp+40]
 48 89 45 f8             \ mov  [rbp-8],rax
 48 8d 6d f8             \ lea  rbp,[rbp-8]
end-code compile-only

code (do)
 58                      \ pop  rax
 5b                      \ pop  rbx
 48 31 c9                \ xor  rcx,rcx
 48 0f ba e9 3f          \ bts  rcx,63
 48 01 cb                \ add  rbx,rcx
 48 29 d8                \ sub  rax,rbx
 53                      \ push rbx
 50                      \ push rax
end-code

code (+loop)
 48 8b 45 00             \ mov  rax,[rbp]
 48 01 04 24             \ add  [rsp],rax
 0f 91 c0                \ setno al
 48 0f b6 c0             \ movzx rax,al
 48 ff c8                \ dec  rax
 48 89 45 00             \ mov  [rbp],rax
end-code

: chars ; inline
: cell 8 ; inline
: cell- 8- ; inline
: cell+ 8+ ; inline
: cells 3 lshift ; inline

: nip ( x1 x2 -- x2 ) swap drop ; inline \ FIXME

: * ( n n -- n ) um* drop ; inline
: / ( n n -- n n ) /mod nip ; inline
: mod ( n n -- n ) /mod drop ; inline
: negate ( u -- u ) invert 1+ ; inline
: dnegate ( d -- d ) invert >r invert 1 um+ r> + ; \ FIXME negx
: abs ( n -- n ) dup 0< if negate then ; inline

include kernel/nucleus.fth
