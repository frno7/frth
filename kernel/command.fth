\ Commands are parsed in two passes. Options such as target and output are
\ resolved in the first pass, while evaluation and input are resolved in the
\ second pass.

: help ( -- )
   ." Usage: frth [option]... [input]..." cr
   cr
   ." Options:" cr
   cr
   ."   --help                   Display this help and exit." cr
   ."   -v, --verbose            Print verbously."            cr
   ."   -e, --evaluate <expr>    Evaluate Forth expression."  cr
   ."   -t, --target <target>    Compile for given target."   cr
   ."   -o, --output <file>      Compile to output image."    cr
   cr
   ." Compiling to an output image requires a target. Providing a target" cr
   ." without giving an output image has no effect. Valid targets are:" cr
   cr
   ."   linux/x64 linux/x86" cr
   ."   macos/x64 macos/x86" cr
   ."   atari/68k amiga/68k" cr ;

 variable cmd:verbose \ Verbosity level starting at 0.
2variable cmd:target
2variable cmd:output

0 value cmd:pass

: (verbose)  ( -- ) cmd:pass 0= if 1 cmd:verbose +! then ;
: (target)   ( c-addr u -- ) cmd:pass 0= if cmd:target 2! else 2drop then ;
: (output)   ( c-addr u -- ) cmd:pass 0= if cmd:output 2! else 2drop then ;
: (evaluate) ( c-addr u -- ) cmd:pass 1= if evaluate      else 2drop then ;
: (input)    ( c-addr u -- ) cmd:pass 1= if included      else 2drop then ;

2variable cmd:opt
  0 value cmd:arg \ Execution token for option with argument.

: (argument) ( c-addr u -- c-addr u 0 | -1 )
   cmd:arg if cmd:arg execute 0 to cmd:arg true else false then ;

: error-no-such-option ( c-addr u -- )
   ." frth: No such option: " type cr exit-failure bye! ;

: error-missing-argument ( c-addr u -- )
   ." frth: Missing argument to option " cmd:opt 2@ type cr exit-failure bye! ;

: error-command-exception ( u -- )
   ." frth: Exception " . cr exit-failure bye! ;

: (option) ( c-addr u -- c-addr u 0 | -1 )
        2dup cmd:opt 2!
        2dup s" --help"     s=       if help bye
   else 2dup s" -v"         s= >r
        2dup s" --verbose"  s= r> or if 2drop (verbose)
   else 2dup s" -e"         s= >r
        2dup s" --evaluate" s= r> or if 2drop ['] (evaluate) to cmd:arg
   else 2dup s" -t"         s= >r
        2dup s" --target"   s= r> or if 2drop [']   (target) to cmd:arg
   else 2dup s" -o"         s= >r
        2dup s" --output"   s= r> or if 2drop [']   (output) to cmd:arg
   else 2dup s" -"    sprefix?       if error-no-such-option
   else false exit
   then then then then then then true ;

: (command) ( c-addr u -- f )
   (argument) 0= if
     (option) 0= if
      (input)
   then then true ;

: ((commands)) ( -- )
   ['] (command) traverse-arguments
   cmd:arg if
      error-missing-argument
   then cmd:pass 1+ to cmd:pass ;

: (commands) ( -- )
   ((commands)) \ Commands pass 1.

   cmd:output 2@ d0<> if
      \ By inluding the file in a word it is postponed.
      s" image/output.fth" included \ FIXME INCLUDE image/output.fth
   else
      ((commands)) \ Commands pass 2.
   then ;

: commands ( -- )
   ['] (commands) catch ?dup if error-command-exception then ;
   \ (commands) ; \ FIXME

commands
