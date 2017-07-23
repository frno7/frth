# Frth

Frth is a subroutine threaded
[Forth system](https://en.wikipedia.org/wiki/Forth_(programming_language))
written in Forth itself for the targets
[x86](https://en.wikipedia.org/wiki/X86),
[x64](https://en.wikipedia.org/wiki/X86-64) and
[68k](https://en.wikipedia.org/wiki/Motorola_68000) on
[Linux](https://en.wikipedia.org/wiki/Linux),
[macOS](https://en.wikipedia.org/wiki/MacOS),
[Atari ST](https://en.wikipedia.org/wiki/Atari_ST) and
[Amiga 500](https://en.wikipedia.org/wiki/Amiga_500). All targets are
[self-relocating](https://en.wikipedia.org/wiki/Self-relocation)
and can therefore load into memory at any address.

# Targets

System | Processor
--- | ---
Linux | x86, x64
macOS | x86, x64
Atari ST | 68k
Amiga 500 | 68k

# Options

```
Usage: frth [option]... [input]...

Options:

  --help                   Display this help and exit.
  -v, --verbose            Print verbously.
  -e, --evaluate <expr>    Evaluate Forth expression.
  -t, --target <target>    Compile for given target.
  -o, --output <file>      Compile to output image.

Compiling to an output image requires a target. Providing a target
without giving an output image has no effect. Valid targets are:

  linux/x64 linux/x86
  macos/x64 macos/x86
  atari/68k amiga/68k
```

# Compiling

Since Frth is written in Forth, another Forth system, for example
[Gforth](https://en.wikipedia.org/wiki/Gforth), is needed to compile Frth
the first time. Once Frth has been compiled, it can recompile or
[cross-compile](https://en.wikipedia.org/wiki/Cross_compiler) itself for any
target. To compile Frth for Linux/x64 one can for example do

```Shell
% gforth -e "fpath+ $PWD" contrib/gforth.fth -e bye -- -o frth-linux-x64 --target linux/x64
```

where the arguments after `--` are forwarded to the Frth emulation. After
this first compilation Frth can recompile itself, for example to macOS/x64:

```Shell
% ./frth-linux-x64 -o frth-macos-x64 --target macos/x64
```

# Testing

There is a test suite with 460 tests, many of them based on the
[Forth 2012 Standard](http://forth-standard.org/standard/testsuite). These can
be run by giving `test/test.fth` as a command input argument, or by giving
`include test/test.fth` at the Forth prompt.

# Licence

Copyright © 2017 Fredrik Noring. See the [LICENCE](LICENCE) file.
