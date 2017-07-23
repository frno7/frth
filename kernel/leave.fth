\ The LEAVE statement needs a stack to resolve into position indendent code.

10 value loop-stack# \ Maximum level of nested DO ... LOOP statements.

0 value loop-stack
align here to loop-stack
loop-stack# cells allot

0 value #loop-stack \ DO ... LOOP level.

: >leave ( addr -- ) \ Push LEAVE address to loop stack.
   #loop-stack 1+ to #loop-stack
   loop-stack# #loop-stack <= if -7 throw then
   loop-stack #loop-stack 1- cells + ! ;

: leave> ( -- addr ) \ Pop LEAVE address to loop stack.
   #loop-stack 1- to #loop-stack
   loop-stack #loop-stack cells + @ ;

: (leave,) ( C: orig -- orig ) \ Provisionally store offset to previous LEAVE.
   ?dup if here swap - else 0 then here swap t:offset, ;

: (leave) ( C: orig -- )
   begin ?dup                             \ Zero marks end of LEAVE list.
   while dup t:offset@ >r                 \ Save offset to next LEAVE.
         dup t:relative!                  \ Resolve forward jump for LEAVE.
         r> ?dup if - else drop exit then \ Go to previous LEAVE or zero out.
   repeat ;
