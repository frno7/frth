include processor/68k/virtual.fth

include image/relocate.fth

include processor/68k/literal.fth
include system/tos/program.fth

include image/image1.fth

include processor/68k/image.fth

include image/image2.fth

s" target/atari/68k/kernel.fth" compile-image
