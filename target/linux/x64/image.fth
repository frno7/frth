include processor/x64/virtual.fth

include image/relocate.fth

include processor/x64/literal.fth
include system/unix/elf64.fth

include image/image1.fth

include processor/x64/image.fth

include image/image2.fth

s" target/linux/x64/kernel.fth" compile-image
