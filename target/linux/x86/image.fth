include processor/x86/virtual.fth

include image/relocate.fth

include processor/x86/literal.fth
include system/unix/elf32.fth

include image/image1.fth

include processor/x86/image.fth

include image/image2.fth

s" target/linux/x86/kernel.fth" compile-image
