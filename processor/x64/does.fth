: (does>) ( FIXME -- )
   >r $e9 latest >code 10 + c!   \ jmp xxxxxxxx FIXME Absolute call
       r> latest >code 11 + (t:relative!) ;

: (does') ( -- ) \ Push RAX to the data stack.
   $48 c, $89 c, $45 c, $f8 c,   \ mov [rbp-8],rax
   $48 c, $8d c, $6d c, $f8 c, ; \ lea rbp,[rbp-8]

: does> ( -- ) ( R: nest-sys1 -- ) ( C: colon-sys1 -- colon-sys2 )
   state @ 0= if
      here (does>) (does') ]
   else
      here 18 + 12 + 1 + \ FIXME Sizes of following code
      postpone literal
      ['] (does>) absolute-call,
      postpone exit
      (does')
   then ; immediate
