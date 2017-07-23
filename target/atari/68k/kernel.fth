include processor/68k/nucleus.fth
include target/atari/68k/syscall.fth

include system/tos/init.fth

include processor/68k/kernel.fth

\ include kernel/argument.fth \ FIXME
\ include kernel/command.fth \ FIXME

." text " text> swap hex. hex. cr \ FIXME
."  bss " bss:base hex. bss:size hex. cr
." here " here hex. break hex. cr
."   sp " sp@ hex. cr
."   rp " rp@ hex. cr

variable cmd:verbose \ FIXME
1 cmd:verbose !
\ s" test/test.fth" included

quit bye
