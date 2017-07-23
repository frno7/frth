: (does>) ( FIXME -- )
   >r $4e latest >code 6 + c!  \ jmp xxxxxxxx
      $f9 latest >code 7 + c!
       r> latest >code 8 + t:absolute! ; \ FIXME Update code size?

: (does') ( -- ) ;

: does> ( -- ) ( R: nest-sys1 -- ) ( C: colon-sys1 -- colon-sys2 )
   state @ 0= if
      here (does>) (does') ]
   else
      here 6 + 6 + 2 + \ FIXME Sizes of following code
      postpone literal
      ['] (does>) absolute-call,
      postpone exit
      (does')
   then ; immediate
