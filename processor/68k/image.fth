include processor/68k/flow.fth
include processor/68k/create.fth
include processor/68k/does.fth

: prologue, ahead, ;
: epilogue, t:align then, ;

include processor/68k/code.fth
