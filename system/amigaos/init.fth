0 constant argc \ FIXME
0 constant argv \ FIXME
0 constant envp \ FIXME

text> + value here
here $40000 + value break \ 256 KiB data space reserved in hunk.fth.

break cell- rp!      \ Put return stack at end of break.
rp@ $4000 - sp!      \ 16 KiB of return stack.
sp@ $4000 - to break \ Adjust break to 16 KiB of data stack.

sp@ constant sp0 \ Address to bottom of stack.

: depth ( -- u ) sp@ sp0 swap - cell / ;

include kernel/init.fth

include system/amigaos/memory.fth

include kernel/character.fth

include system/amigaos/io.fth
