$1000000 value sys-brk0

: sys-brk ( a-addr -- a-addr )
   ?dup if
      dup sys-brk0 u< if drop -1 exit then \ FIXME errno
      $fff + $fff invert and \ Round up to nearest 4096 address.
      dup sys-brk0 = if exit then
      >r
      0
      -1
      $1012 \ MAP_ANON | MAP_FIXED | MAP_PRIVATE
      %111  \ PROT_READ | PROT_WRITE | PROT_EXEC
      r@ sys-brk0 -
      sys-brk0
      sys-mmap
      -1000 over u< if
         drop rdrop -1 \ FIXME errno
      else
         drop r@ to sys-brk0 r>
      then
   else
      sys-brk0
   then ;
