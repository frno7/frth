include processor/x86/virtual.fth

include image/relocate.fth

include processor/x86/literal.fth
include system/macos/mach32.fth

include image/image1.fth

include processor/x86/image.fth

include image/image2.fth

s" target/macos/x86/kernel.fth" compile-image
