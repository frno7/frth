: \ ( "ccc<eol>" -- ) 10 parse 2drop ; immediate

: ( ( "ccc<char>" -- )
   begin >in @ 41 parse nip >in @ rot - =
   while refill 0<>
   while repeat then ; immediate
