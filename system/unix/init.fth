rp@ @     constant argc
rp@ cell+ constant argv
argv argc 1 + cells +
          constant envp

sp@ constant sp0 \ Address to bottom of stack.

: depth ( -- u ) sp@ sp0 swap - cell / ;

0 value here \ Provisional HERE until allocated using SYS-BRK.

include kernel/init.fth

include system/unix/memory.fth

include kernel/character.fth

include system/unix/io.fth
