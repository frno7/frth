rp@ cell+ @ constant basepage \ Pointer to GEMDOS basepage structure.

\ Offset  Name         Description
\    $00  p_lowtpa     -> base of TPA
\    $04  p_hitpa      -> end of TPA
\    $08  p_tbase      base of text segment
\    $0c  p_tlen       size of text segment
\    $10  p_dbase      base of data segment
\    $14  p_dlen       size of data segment
\    $18  p_bbase      size of BSS segment
\    $1c  p_blen       base of BSS segment
\    $20  p_dta        Disk Transfer Address (DTA)
\    $24  p_parent     -> parent's basepage
\    $28  (reserved)
\    $2c  p_env        -> enviroment string
\    $80  p_cmdlin     commandline image
basepage $18 + @ constant bss:base \ Note: The GEMDOS documentation seems to
basepage $1c + @ constant bss:size \ incorrectly give them the other way around.

0 constant argc \ FIXME
0 constant argv \ FIXME
0 constant envp \ FIXME

rp@ $4000 - sp! \ 16 KiB of return stack.

sp@ constant sp0 \ Address to bottom of stack.

: depth ( -- u ) sp@ sp0 swap - cell / ;

bss:base value here
bss:base bss:size + value break

include kernel/init.fth

include system/tos/memory.fth

include kernel/character.fth

include system/tos/io.fth
