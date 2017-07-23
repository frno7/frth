: (does>) ( FIXME -- )
   >r $e9 ( jmp $xxxxxxxx ) latest >code 5 + c!
   latest >code 6 +
   dup r> swap - 4 - swap t:! ;

: (does') ( -- ) \ Push EAX to the data stack.
   $89 c, $45 c, $fc c,   \ mov  [ebp-4],eax
   $8d c, $6d c, $fc c, ; \ lea  ebp,[ebp-4]

: does> ( -- ) ( R: nest-sys1 -- ) ( C: colon-sys1 -- colon-sys2 )
   state @ 0= if
      here (does>) (does') ]
   else
      here 16 + \ FIXME Sizes of following code
      postpone literal
      postpone (does>)
      postpone exit
      (does')
   then ; immediate
